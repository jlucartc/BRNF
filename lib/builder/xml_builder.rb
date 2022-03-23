require_relative './../tag_map.rb'

module BRNF
	class XMLBuilder
		REAL_TAGS = ["E","G","CE","CG","Root"]
		AUXILIARY_TAGS = ["GA","CGA"]

		def initialize(fill: true)
			@should_fill_with_data = fill
			@tag_map = BRNF::TagMap.new
		end

		def build_xml(tag,keep_mutex_tags: false)
			@tag_map = BRNF::TagMap.new(keep_mutex_tags: keep_mutex_tags)
			Nokogiri::XML::Document.parse(build_tag(tag).first.to_xml.gsub(/>[\s\n\t]*</,"><"))
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
			tag_xml = create_xml_tag(@tag_map.get_tag(tag_number)["name"])
			tag_tipo = @tag_map.get_tag(tag_number)["type"]
			result = []

			tag_xml = add_namespace(tag_xml,tag_number)
			tag_xml = add_attribute_to(tag_xml,tag_number)

			if has_children(tag_number)
				element_children_tag = @tag_map.get_children_of(tag_number) - @tag_map.get_attributes_of(tag_number)
				if AUXILIARY_TAGS.include?(tag_tipo)
					element_children_tag.each do |child|
						result += build_tag(child)
					end
				elsif REAL_TAGS.include?(tag_tipo)
					element_children_tag.each do |child|
						build_tag(child).each do |item|
							tag_xml.add_child(item)
						end
					end
					result << tag_xml
				end
			else
				tag_xml = fill_tag(tag_xml,tag_number) if @should_fill_with_data
				result << tag_xml
			end
			result
		end

		def add_namespace(xml,tag_id)
			xml['xmlns'] = @tag_map.get_tag(tag_id)["namespace"] if !@tag_map.get_tag(tag_id)["namespace"].nil?
			xml
		end

		def add_attribute_to(xml,tag_id)
			attributes = @tag_map.get_attributes_of(tag_id)
			attributes.each do |attribute|
				attribute = @tag_map.get_tag(attribute)
					if attribute["regex"].nil?
						xml[attribute["name"]] = ""
					else
						xml[attribute["name"]] = Regexp.new(attribute["regex"]).random_example.gsub("\u0000",'') if !attribute["regex"].nil?
					end
			end
			xml
		end

		def has_children(parent_tag_id)
			if @tag_map.get_keys.include?(parent_tag_id)
				!@tag_map.get_tag(parent_tag_id)["children"].empty?
			else
				false
			end
		end

		def fill_tag(xml,tag_id)
			regex = @tag_map.get_tag(tag_id)["regex"]
			xml.content = Regexp.new(regex).random_example.gsub("\u0000",'') unless regex.nil?
			xml
		end
	end
end