module BRNF
	class XMLBuilder
		TAGS = ["E","G","CE","CG","Raiz"]
		ATTR = ["A"]
		OPTIONAL = ["GO","CGO"]

		attr_reader :mapa_tags

		class MapaTags
			attr_reader :map
			attr_reader :reverse_map
			attr_reader :message_map

			def initialize(hash,reverse_map: nil,message_map: nil)
				@map = hash
				@reverse_map = reverse_map
				generate_reverse_map if @reverse_map.nil?
				generate_message_map if @message_map.nil?
			end

			def get_candidate_tags_list(tag)
				@reverse_map[tag.to_s]
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

			private

			def has_ancestor(child_tag_name,ancestor_id)
				tags = @message_map[child_tag_name]
				tags = [@map[child_tag_name]].compact if tags.nil?
				if tags.nil?
					false
				else
					tags = tags.map do |tag|
						if tag["pai"] == ancestor_id
							true
						else
							if tag["pai"].nil?
								false
							else
								has_ancestor(tag["pai"],ancestor_id)
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
						if tag["pai"] == ancestor_id
							count
						else
							if tag["pai"].nil?
								-(count+1)
							else
								calculate_parent_child_distance(tag_list,ancestor_id,current_parent_id: tag["pai"], count: count+1)
							end
						end
					end
					tags_distance
				else
					current_parent = @map[current_parent_id]
					if current_parent.nil?
						-(count+1)
					elsif current_parent["pai"] == ancestor_id
						count
					else
						if current_parent["pai"].nil?
							-(count+1)
						else
							calculate_parent_child_distance(tag_list,ancestor_id,current_parent_id: current_parent["pai"], count: count+1)
						end
					end
				end
			end

			def generate_message_map
				@message_map = @map.filter{|key,value| !value['campo_mensagem'].nil?}
				@message_map = @message_map.map{|key,value| value}
				@message_map = @message_map.group_by{|item| item["campo_mensagem"]}
			end

			def generate_reverse_map
				@reverse_map = @map.map{|key,value| value }
				@reverse_map = @reverse_map.group_by{|item| item["nome"]}
				@reverse_map = @reverse_map.map{|key,value| [key,{"indices" => value.map{|item| item["id"] }, "tags" => value}]}.to_h
			end
		end

		def initialize(fill: true)
			@should_fill_with_data = fill
			create_mapa_tags()
			@mapa_tags = MapaTags.new(@mapa_tags) if @mapa_tags.class != MapaTags
		end

		def build_xml(tag)
			Nokogiri::XML::Document.parse(build_tag(tag.to_s).first.to_xml.gsub(/>[\s\n\t]*</,"><"))
		end

		def sign_message(xml)
			content = xml.xpath("//*[@Id]").first.canonicalize
			signature = xml.xpath("//xs:Signature","xs" => "http://www.w3.org/2000/09/xmldsig#")
			digest = signature.xpath("//xs:DigestValue","xs" => "http://www.w3.org/2000/09/xmldsig#").first
			signature_value = signature.xpath("//xs:SignatureValue","xs" => "http://www.w3.org/2000/09/xmldsig#").first 
			reference = signature.xpath("//xs:Reference","xs"=>"http://www.w3.org/2000/09/xmldsig#").first
			x509_certificate = signature.xpath("//xs:X509Certificate","xs"=>"http://www.w3.org/2000/09/xmldsig#").first
			reference['URI'] = "##{xml.xpath("//*[@Id]").first['Id']}"
			digest.content = Base64.encode64(Digest::SHA1.digest(content)).gsub(/\n/,'')
			key = OpenSSL::PKey::RSA.new(2048)
			signature_value.content = Base64.encode64(key.sign(OpenSSL::Digest::SHA1.new,content)).gsub(/\n/,'')
			x509_certificate.content = key.to_pem.gsub(/[-]{5}[\sA-Z]+[-]{5}/,'').gsub(/\n/,'')
			xml
		end

		private

		def create_xml_tag(tag_name)
			Nokogiri::XML("<#{tag_name}>").elements.first
		end

		def build_tag(tag_number)
			tag_xml = create_xml_tag(@mapa_tags.get_tag(tag_number)["nome"])
			tag_tipo = @mapa_tags.get_tag(tag_number)["tipo"]
			resultado = []

			tag_xml = add_namespace(tag_xml,tag_number)
			tag_xml = add_attr(tag_xml,tag_number)

			if has_children(tag_number)
				tag_filhos = get_children_of(tag_number) - get_attr_of(tag_number)
				if OPTIONAL.include?(tag_tipo)
					tag_filhos.each do |filho|
						resultado += build_tag(filho)
					end
				elsif TAGS.include?(tag_tipo)
					tag_filhos.each do |filho|
						build_tag(filho).each do |item|
							tag_xml.add_child(item)
						end
					end
					resultado << tag_xml
				end
			else
				tag_xml = fill_tag(tag_xml,tag_number) if @should_fill_with_data
				resultado << tag_xml
			end

			resultado
		end

		def add_namespace(xml,tag_id)
			xml['xmlns'] = @mapa_tags.get_tag(tag_id)["namespace"] if !@mapa_tags.get_tag(tag_id)["namespace"].nil?
			xml
		end

		def add_attr(xml,tag_id)
			atributos = get_attr_of(tag_id)
			atributos.each do |atributo|
				atributo = @mapa_tags.get_tag(atributo)
					if atributo["regex"].nil?
						xml[atributo["nome"]] = ""
					else
						xml[atributo["nome"]] = Regexp.new(atributo["regex"]).random_example.gsub("\u0000",'') if !atributo["regex"].nil?
					end
			end
			xml
		end

		def has_children(parent_tag_id)
			if @mapa_tags.get_keys.include?(parent_tag_id)
				!@mapa_tags.get_tag(parent_tag_id)["filhos"].empty?
			else
				false
			end
		end

		def fill_tag(xml,tag_id)
			regex = @mapa_tags.get_tag(tag_id)["regex"]
			xml.content = Regexp.new(regex).random_example.gsub("\u0000",'') unless regex.nil?
			xml
		end

		def get_children_of(parent_tag_id)
			if @mapa_tags.class == MapaTags
				@mapa_tags.get_tag(parent_tag_id)["filhos"]
			else
				@mapa_tags[parent_tag_id]["filhos"]
			end
		end

		def get_attr_of(parent_tag_id)
			@mapa_tags.get_tag(parent_tag_id)["atributos"]
		end

		def create_mapa_tags(from_scratch: true)
			if from_scratch
				tags = CSV.read('tags.csv',col_sep:";",headers:true)
				mapa_tags = {}
				tags.each do |tag|
					if tag["ativo"] == "1"
						dados_tag = {}
						dados_tag["id"] = tag["id"]
						dados_tag["nome"] = tag["nome"]
						dados_tag["tipo"] = tag["tipo"]
						dados_tag["pai"] = tag["pai"]
						dados_tag["min"] = tag["min"]
						dados_tag["max"] = tag["max"]
						dados_tag["regex"] = tag["regex"]
						dados_tag["namespace"] = tag["namespace"]
						dados_tag["xpath_namespace"] = tag["namespace"]
						dados_tag["inferivel"] = tag["inferivel"]
						dados_tag["xpath"] = tag["xpath"]
						dados_tag["campo_mensagem"] = tag["campo_mensagem"]
						dados_tag["filhos"] = []
						dados_tag["atributos"] = []
						mapa_tags["#{tag["id"]}"] = dados_tag

						if mapa_tags.key?(tag["pai"])
							mapa_tags["#{tag["id"]}"]["xpath_namespace"] = mapa_tags[tag["pai"]]["xpath_namespace"] if mapa_tags["#{tag["id"]}"]["xpath_namespace"].nil?
							mapa_tags[tag["pai"]]["filhos"] << tag["id"]
							mapa_tags[tag["pai"]]["atributos"] << tag["id"] if ATTR.include?(tag["tipo"])
						end
					end
				end
				@mapa_tags = mapa_tags
				remove_tags_mutex
			else
				map = JSON.parse(File.open("#{__dir__}/../map.json",'r').read)
				reverse_map = JSON.parse(File.open("#{__dir__}/../reverse_map.json",'r').read)
				message_map = JSON.parse(File.open("#{__dir__}/../message_map.json",'r').read)
				@mapa_tags = MapaTags.new(map,reverse_map: reverse_map);
			end
		end

		def remove_tags_mutex
			tags = @mapa_tags.keys
			filhos = {tags_filhos_ce: [],tags_filhos_cg: [],tags_filhos_cgo: [],tags_filhos_normais: []}
			tags.each do |parent_tag_id|
				lista_filhos = get_children_of(parent_tag_id)
				lista_filhos.each do |child_tag_id|
					dados_filho = @mapa_tags[child_tag_id]
					case dados_filho["tipo"]
					when "CE"
						filhos[:tags_filhos_ce] << child_tag_id
					when "CG"
						filhos[:tags_filhos_cg] << child_tag_id
					when "CGO"
						filhos[:tags_filhos_cgo] << child_tag_id
					else
						filhos[:tags_filhos_normais] << child_tag_id
					end
				end
				@mapa_tags[parent_tag_id]["filhos"] = ([filhos[:tags_filhos_ce].sample,filhos[:tags_filhos_cg].sample,filhos[:tags_filhos_cgo].sample].compact + filhos[:tags_filhos_normais]).sort_by{|item| item.to_i}
				filhos = {tags_filhos_ce: [],tags_filhos_cg: [],tags_filhos_cgo: [],tags_filhos_normais: []}
			end
		end

	end
end