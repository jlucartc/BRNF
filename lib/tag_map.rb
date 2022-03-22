module BRNF

	class TagMap
		attr_reader :map
		attr_reader :reverse_map
		attr_reader :message_map
		attr_reader :xpath_map

		def initialize(keep_mutex_tags: false)
			@keep_mutex_tags = keep_mutex_tags
			create_tag_map
			@reverse_map = generate_reverse_map if @reverse_map.nil?
			@message_map = generate_message_map if @message_map.nil?
			@xpath_map = generate_xpath_map if @xpath_map.nil?
		end

		def get_tag(index)
			@map[index]
		end

		def get_keys
			@map.keys
		end

		def get_values
			@map.values
		end

		def get_children_of(parent_tag_id)
			get_tag(parent_tag_id)["children"]
		end

		def get_attributes_of(parent_tag_id)
			get_tag(parent_tag_id)["attributes"]
		end

		def get_real_tags
			@map.values.filter{|tag| !["CGO","GO"].include?(tag["type"])}
		end

		def get_constant_regex_tags
			@map.values.filter{|tag| !tag["regex"].nil? and tag["regex"].match(/^(.*\[.*\])+|(.*\|.*)+$/).nil? }
		end

		private

		def generate_message_map
			@message_map = @map.filter{|key,value| !value['message_field'].nil?}
			@message_map = @message_map.values
			@message_map = @message_map.group_by{|item| item["message_field"]}
		end

		def generate_reverse_map
			@reverse_map = @map.values
			@reverse_map = @reverse_map.group_by{|item| item["name"]}
			@reverse_map = @reverse_map.map{|key,value| [key,{"indexes" => value.map{|item| item["id"] }, "tags" => value}]}.to_h
		end

		def generate_xpath_map
			@xpath_map = @map.values
			@xpath_map = @xpath_map.group_by{|item| item["xpath"]}
		end

		def create_tag_map()
			tags = CSV.read('tags.csv',col_sep:";",headers:true)
			mapa_tags = {}
			tags.each do |tag|
				if tag["active"] == "1"
					dados_tag = {}
					dados_tag["id"] = tag["id"].to_i
					dados_tag["name"] = tag["name"]
					dados_tag["type"] = tag["type"]
					dados_tag["parent"] = tag["parent"].to_i
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
					mapa_tags[tag["id"].to_i] = dados_tag

					if mapa_tags.key?(tag["parent"].to_i)
						mapa_tags[tag["id"].to_i]["xpath_namespace"] = mapa_tags[tag["parent"].to_i]["xpath_namespace"] if mapa_tags[tag["id"].to_i]["xpath_namespace"].nil?
						mapa_tags[tag["parent"].to_i]["children"] << tag["id"].to_i
						mapa_tags[tag["parent"].to_i]["attributes"] << tag["id"].to_i if tag["type"] == "A"
					end
				end
			end
			@map = mapa_tags
			remove_tags_mutex if !@keep_mutex_tags
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
				@map[parent_tag_id]["children"] = ([children[:children_tag_ce].sample,children[:children_tag_cg].sample,children[:children_tag_cgo].sample].compact + children[:children_tag_normal]).sort_by{|item| item}
				children = {children_tag_ce: [],children_tag_cg: [],children_tag_cgo: [],children_tag_normal: []}
			end
		end

	end

end