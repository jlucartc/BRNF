module BRNF
	class XMLBuilder

		class MapaTags
			attr_reader :body
			attr_reader :reverse_body

			def initialize(hash)
				@body = hash
				generate_reverse_body
			end

			def get_index_list(tag)
				@reverse_body[tag.to_s]
			end

			def get_tag(index)
				@body[index.to_s]
			end

			def get_keys
				@body.keys
			end

			def get_reverse_keys
				@reverse_body.keys
			end

			private

			def generate_reverse_body
				@reverse_body = @body.map{|key,value| value }
				@reverse_body = @reverse_body.group_by{|item| item["nome"]}
				@reverse_body = @reverse_body.map{|chave,valor| [chave,{"indices": valor.map{|item| item["id"] }, "tags": valor}]}.to_h
			end
		end

		TAGS = ["E","G","CE","CG","Raiz"]
		ATRIBUTOS = ["A"]
		OPCIONAIS = ["GO","CGO"]

		def initialize(fill: true)
			@should_fill_with_data = fill
			create_mapa_tags
			@mapa_tags = MapaTags.new(@mapa_tags) if @mapa_tags.class != MapaTags
		end

		def build_xml(tag)
			Nokogiri::XML::Document.parse(build_tag(tag.to_s).first.to_xml.gsub(/>[\s\n\t]*</,"><"))
		end

		def build_tag(tag_number)
			tag_xml = Nokogiri::XML("<#{@mapa_tags.get_tag(tag_number)["nome"]}>").elements.first
			tag_tipo = @mapa_tags.get_tag(tag_number)["tipo"]
			resultado = []

			tag_xml = add_namespace(tag_xml,tag_number)
			tag_xml = add_attr(tag_xml,tag_number)

			if has_children(tag_number)
				tag_filhos = get_children_of(tag_number) - get_attr_of(tag_number)
				if OPCIONAIS.include?(tag_tipo)
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
			@mapa_tags.get_tag(parent_tag_id)["filhos"]
		end

		def get_attr_of(parent_tag_id)
			@mapa_tags.get_tag(parent_tag_id)["atributos"]
		end

		def create_mapa_tags(from_scratch: false)
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
						dados_tag["filhos"] = []
						dados_tag["atributos"] = []
						mapa_tags["#{tag["id"]}"] = dados_tag

						if mapa_tags.key?(tag["pai"])
							mapa_tags["#{tag["id"]}"]["xpath_namespace"] = mapa_tags[tag["pai"]]["xpath_namespace"] if mapa_tags["#{tag["id"]}"]["xpath_namespace"].nil?
							mapa_tags[tag["pai"]]["filhos"] << tag["id"]
							mapa_tags[tag["pai"]]["atributos"] << tag["id"] if ATRIBUTOS.include?(tag["tipo"])
						end
					end
				end
				@mapa_tags = mapa_tags
				remove_tags_mutex
			else
				@mapa_tags = MapaTags.new(JSON.parse(File.open("#{__dir__}/../mapa_tags.json",'r').read));
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

		def sign_message(xml)
			mensagem = xml.xpath("//*[@Id]").first.canonicalize
			assinatura = xml.xpath("//xs:Signature","xs" => "http://www.w3.org/2000/09/xmldsig#")
			digest = assinatura.xpath("//xs:DigestValue","xs" => "http://www.w3.org/2000/09/xmldsig#").first
			signature_value = assinatura.xpath("//xs:SignatureValue","xs" => "http://www.w3.org/2000/09/xmldsig#").first 
			reference = assinatura.xpath("//xs:Reference","xs"=>"http://www.w3.org/2000/09/xmldsig#").first
			x509_certificate = assinatura.xpath("//xs:X509Certificate","xs"=>"http://www.w3.org/2000/09/xmldsig#").first
			reference['URI'] = "##{xml.xpath("//*[@Id]").first['Id']}"
			digest.content = Base64.encode64(Digest::SHA1.digest(mensagem)).gsub(/\n/,'')
			chave = OpenSSL::PKey::RSA.new(2048)
			signature_value.content = Base64.encode64(chave.sign(OpenSSL::Digest::SHA1.new,mensagem)).gsub(/\n/,'')
			x509_certificate.content = chave.to_pem.gsub(/[-]{5}[\sA-Z]+[-]{5}/,'').gsub(/\n/,'')
			xml
		end

	end
end