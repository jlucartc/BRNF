module BRNF

	class TagMap
		attr_reader :map
		attr_reader :reverse_map
		attr_reader :message_map

		def initialize()
			create_tag_map
			@reverse_map = generate_reverse_map if @reverse_map.nil?
			@message_map = generate_message_map if @message_map.nil?
		end

		def get_tag(index)
			@map[index.to_s]
		end

		def get_keys
			@map.keys
		end

		def get_reverse_keys
			@reverse_map.keys
		end

		def get_message_field_tags(tag_name,ancestor_id)
			if ancestor_id.nil?
				@message_map[tag_name].sort_by{|item| item["id"].to_i}.first
			else
				if has_ancestor(tag_name,ancestor_id)
					get_closest_tags_to_ancestor(tag_name,ancestor_id)
				end
			end
		end

		def get_children_of(parent_tag_id)
			get_tag(parent_tag_id)["children"]
		end

		def get_attributes_of(parent_tag_id)
			get_tag(parent_tag_id)["attributes"]
		end

		def get_inferrable_tags()
			@map.values.filter{|tag| tag["inferrable"] == "1" }
		end

		def get_inferrable_empty_tags(xml)
			get_inferrable_tags
			.filter{|tag| tag = xml.xpath(tag["xpath"],"xs" => tag["xpath_namespace"]).first if !tag["xpath"].nil? and !tag["xpath_namespace"].nil?; !tag.nil? and !tag.content.nil?}
		end

		def get_constant_regex_tags
			@map.values.filter{|tag| !tag["regex"].nil? and tag["regex"].match(/^(.*\[.*\])+|(.*\|.*)+$/).nil? }
		end

		def get_mutex_parents
			@map.values.filter{|tag| ['CE','CG','CGO'].include?(tag["type"]) }.map{|tag| get_tag(tag["parent"]) }.compact.uniq
		end

		private

		def has_ancestor(child_tag_name,ancestor_id)
			tags = @message_map[child_tag_name]
			tags = [@map[child_tag_name]].compact if tags.nil?
			if tags.nil?
				false
			else
				tags = tags.map do |tag|
					if tag["parent"] == ancestor_id
						true
					else
						if tag["parent"].nil?
							false
						else
							has_ancestor(tag["parent"],ancestor_id)
						end
					end
				end
			end

			tags = tags.uniq
			tags.first != tags.last ? true : tags.first
		end

		def get_closest_tags_to_ancestor(child_tag_name,ancestor_id, count: 0)
			tags = @message_map[child_tag_name]
			tags = [@map[child_tag_name]] if tags.nil?
			tags_distance = calculate_parent_child_distance(tags,ancestor_id)

			closest_tags = []
			tags_distance.each_with_index do |distance,index|
				closest_tags << tags[index] if distance == tags_distance.filter{|item| item >= 0 }.sort.first
			end
			closest_tags
		end

		def calculate_parent_child_distance(tag_list,ancestor_id,current_parent_id: nil, count: 0)
			if current_parent_id.nil?
				tags_distance = tag_list.map do |tag|
					if tag["parent"] == ancestor_id
						count
					else
						if tag["parent"].nil?
							-(count+1)
						else
							calculate_parent_child_distance(tag_list,ancestor_id,current_parent_id: tag["parent"], count: count+1)
						end
					end
				end
				tags_distance
			else
				current_parent = @map[current_parent_id]
				if current_parent.nil?
					-(count+1)
				elsif current_parent["parent"] == ancestor_id
					count
				else
					if current_parent["parent"].nil?
						-(count+1)
					else
						calculate_parent_child_distance(tag_list,ancestor_id,current_parent_id: current_parent["parent"], count: count+1)
					end
				end
			end
		end

		def generate_message_map
			@message_map = @map.filter{|key,value| !value['message_field'].nil?}
			@message_map = @message_map.map{|key,value| value }
			@message_map = @message_map.group_by{|item| item["message_field"]}
		end

		def generate_reverse_map
			@reverse_map = @map.map{|key,value| value }
			@reverse_map = @reverse_map.group_by{|item| item["name"]}
			@reverse_map = @reverse_map.map{|key,value| [key,{"indexes" => value.map{|item| item["id"] }, "tags" => value}]}.to_h
		end

		def create_tag_map(from_scratch: true)
			if from_scratch
				tags = CSV.read('tags.csv',col_sep:";",headers:true)
				mapa_tags = {}
				tags.each do |tag|
					if tag["active"] == "1"
						dados_tag = {}
						dados_tag["id"] = tag["id"]
						dados_tag["name"] = tag["name"]
						dados_tag["type"] = tag["type"]
						dados_tag["parent"] = tag["parent"]
						dados_tag["min"] = tag["min"]
						dados_tag["max"] = tag["max"]
						dados_tag["regex"] = tag["regex"]
						dados_tag["namespace"] = tag["namespace"]
						dados_tag["xpath_namespace"] = tag["namespace"]
						dados_tag["inferrable"] = tag["inferrable"]
						dados_tag["xpath"] = tag["xpath"]
						dados_tag["message_field"] = tag["message_field"]
						dados_tag["children"] = []
						dados_tag["attributes"] = []
						mapa_tags["#{tag["id"]}"] = dados_tag

						if mapa_tags.key?(tag["parent"])
							mapa_tags["#{tag["id"]}"]["xpath_namespace"] = mapa_tags[tag["parent"]]["xpath_namespace"] if mapa_tags["#{tag["id"]}"]["xpath_namespace"].nil?
							mapa_tags[tag["parent"]]["children"] << tag["id"]
							mapa_tags[tag["parent"]]["attributes"] << tag["id"] if tag["type"] == "A"
						end
					end
				end
				@map = mapa_tags
				remove_tags_mutex
			else
				@map = JSON.parse(File.open("#{__dir__}/../map.json",'r').read)
				@reverse_map = JSON.parse(File.open("#{__dir__}/../reverse_map.json",'r').read)
				@message_map = JSON.parse(File.open("#{__dir__}/../message_map.json",'r').read)
			end
		end

		def remove_tags_mutex
			tags = @map.keys
			children = {children_tag_ce: [],children_tag_cg: [],children_tag_cgo: [],children_tag_normal: []}
			tags.each do |parent_tag_id|
				lista_children = get_children_of(parent_tag_id)
				lista_children.each do |child_tag_id|
					child_data = @map[child_tag_id]
					case child_data["type"]
					when "CE"
						children[:children_tag_ce] << child_tag_id
					when "CG"
						children[:children_tag_cg] << child_tag_id
					when "CGO"
						children[:children_tag_cgo] << child_tag_id
					else
						children[:children_tag_normal] << child_tag_id
					end
				end
				@map[parent_tag_id]["children"] = ([children[:children_tag_ce].sample,children[:children_tag_cg].sample,children[:children_tag_cgo].sample].compact + children[:children_tag_normal]).sort_by{|item| item.to_i}
				children = {children_tag_ce: [],children_tag_cg: [],children_tag_cgo: [],children_tag_normal: []}
			end
		end

	end

end