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

		def sign_message(xml,certfile: nil)
			content = xml.xpath("//*[@Id]").first.canonicalize

			if xml.xpath("//xs:Signature","xs" => "http://www.w3.org/2000/09/xmldsig#").empty?
				parent_xml_tag = xml.xpath("//*[@Id]").first.parent
				signature_xml_tag = create_xml_tag("Signature")
				signed_info_xml_tag = create_xml_tag("SignedInfo")
				canonicalization_method_xml_tag = create_xml_tag("CanonicalizationMethod")
				signature_method_xml_tag = create_xml_tag("SignatureMethod")
				reference_xml_tag = create_xml_tag("Reference")
				transforms_xml_tag = create_xml_tag("Transforms")
				transform_xml_tag_1 = create_xml_tag("Transform")
				xpath_xml_tag_1 = create_xml_tag("XPath")
				transform_xml_tag_2 = create_xml_tag("Transform")
				xpath_xml_tag_2 = create_xml_tag("XPath")
				digest_method_xml_tag = create_xml_tag("DigestMethod")
				digest_value_xml_tag = create_xml_tag("DigestValue")
				signature_value_xml_tag = create_xml_tag("SignatureValue")
				key_info_xml_tag = create_xml_tag("KeyInfo")
				x509_data_xml_tag = create_xml_tag("X509Data")
				x509_certificate_xml_tag = create_xml_tag("X509Certificate")
				algorithm_1 = "http://www.w3.org/TR/2001/REC-xml-c14n-20010315"
				algorithm_2 = "http://www.w3.org/2000/09/xmldsig#rsa-sha1"
				algorithm_3 = "http://www.w3.org/2000/09/xmldsig#sha1"
				algorithm_4 = "http://www.w3.org/2000/09/xmldsig#enveloped-signature"
				algorithm_5 = "http://www.w3.org/TR/2001/REC-xml-c14n-20010315"

				signature_xml_tag.default_namespace = "http://www.w3.org/2000/09/xmldsig#"

				canonicalization_method_xml_tag["Algorithm"] = algorithm_1
				signature_method_xml_tag["Algorithm"] = algorithm_2
				digest_method_xml_tag["Algorithm"] = algorithm_3
				transform_xml_tag_1["Algorithm"] = algorithm_4
				transform_xml_tag_2["Algorithm"] = algorithm_5

				transforms_xml_tag.add_child(transform_xml_tag_1)
				transforms_xml_tag.add_child(transform_xml_tag_2)
				
				reference_xml_tag['URI'] = "##{xml.xpath("//*[@Id]").first['Id']}"
				reference_xml_tag.add_child(transforms_xml_tag)
				reference_xml_tag.add_child(digest_method_xml_tag)
				reference_xml_tag.add_child(digest_value_xml_tag)

				x509_data_xml_tag.add_child(x509_certificate_xml_tag)
				key_info_xml_tag.add_child(x509_data_xml_tag)

				signed_info_xml_tag.add_child(canonicalization_method_xml_tag)
				signed_info_xml_tag.add_child(signature_method_xml_tag)
				signed_info_xml_tag.add_child(reference_xml_tag)

				signature_xml_tag.add_child(signed_info_xml_tag)
				signature_xml_tag.add_child(signature_value_xml_tag)
				signature_xml_tag.add_child(key_info_xml_tag)

				digest_value_xml_tag.content = Base64.encode64(Digest::SHA1.digest(content)).gsub(/\n/,'')
				key = OpenSSL::PKey::RSA.new(2048)
				signature_value_xml_tag.content = Base64.encode64(key.sign(OpenSSL::Digest::SHA1.new,content)).gsub(/\n/,'')
				x509_certificate_xml_tag.content = key.to_pem.gsub(/[-]{5}[\sA-Z]+[-]{5}/,'').gsub(/\n/,'')
				parent_xml_tag.add_child(signature_xml_tag)
			else
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
			end

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