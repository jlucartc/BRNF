module BRNF

	class Signer

		def sign_message(xml,pfx_file_path: nil, key_file_path: nil, password: nil, cert_file_path: nil)
			if !pfx_file_path.nil?
				begin
					pfx_file = OpenSSL::PKCS12.new(File.open(pfx_file_path,'r').read,password)
					key = pfx_file.key

					validate_cert(pfx_file.certificate)
				rescue OpenSSL::PKCS12::PKCS12Error
					raise  "Error: wrong password or invalid certificate file."
				end
			else
				if !cert_file_path.nil? and !key_file_path.nil? and !ca_file_path.nil? and !password.nil?
					key = OpenSSL::Pkey::RSA.new(File.open(key_file_path,'r').read)
					cert = OpenSSL::X509::Certificate.new(File.open(cert_file_path,'r').read)
				else
					key = OpenSSL::PKey::RSA.new(2048)
					cert = key.to_pem
				end
			end

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
				signature_value_xml_tag.content = Base64.encode64(key.sign(OpenSSL::Digest::SHA1.new,content)).gsub(/\n/,'')
				x509_certificate_xml_tag.content = cert.gsub(/[-]{5}[\sA-Z]+[-]{5}/,'').gsub(/\n/,'')
				parent_xml_tag.add_child(signature_xml_tag)
			else
				signature = xml.xpath("//xs:Signature","xs" => "http://www.w3.org/2000/09/xmldsig#")
				digest = signature.xpath("//xs:DigestValue","xs" => "http://www.w3.org/2000/09/xmldsig#").first
				signature_value = signature.xpath("//xs:SignatureValue","xs" => "http://www.w3.org/2000/09/xmldsig#").first 
				reference = signature.xpath("//xs:Reference","xs"=>"http://www.w3.org/2000/09/xmldsig#").first
				x509_certificate = signature.xpath("//xs:X509Certificate","xs"=>"http://www.w3.org/2000/09/xmldsig#").first
				reference['URI'] = "##{xml.xpath("//*[@Id]").first['Id']}"
				digest.content = Base64.encode64(Digest::SHA1.digest(content)).gsub(/\n/,'')
				signature_value.content = Base64.encode64(key.sign(OpenSSL::Digest::SHA1.new,content)).gsub(/\n/,'')
				x509_certificate.content = cert.gsub(/[-]{5}[\sA-Z]+[-]{5}/,'').gsub(/\n/,'')
			end

			xml
		end

		private

		def create_xml_tag(tag_name)
			Nokogiri::XML("<#{tag_name}>").elements.first
		end
	end
end