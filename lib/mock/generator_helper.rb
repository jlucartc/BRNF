require 'csv'
require 'regexp-examples'
require 'pry'
require 'nokogiri'
require 'digest'
require 'base64'
require 'openssl'


module GeneratorHelper

	class XMLGenerator

		TAGS = ["E","G","CE","CG","Raiz"]
		ATRIBUTOS = ["A"]
		OPCIONAIS = ["GO","CGO"]

		def initialize
			cria_mapa_tags
		end

		def consultar_cadastro
			xml = Nokogiri::XML::Document.parse(constroi_tag("56").first.to_xml.gsub(/>[\s\n\t]*</,"><"))
			xml
		end

		def autorizar_nota
			xml = Nokogiri::XML::Document.parse(constroi_tag("1").first.to_xml.gsub(/>[\s\n\t]*</,"><"))
			xml = assina_mensagem(xml)
			xml
		end

		def consultar_status_servico
			xml = Nokogiri::XML::Document.parse(constroi_tag("51").first.to_xml.gsub(/>[\s\n\t]*</,"><"))
			xml
		end

		def consultar_retorno_autorizacao
			xml = Nokogiri::XML::Document.parse(constroi_tag("6").first.to_xml.gsub(/>[\s\n\t]*</,"><"))
			xml
		end

		def inutilizar_numeracao
			xml = Nokogiri::XML::Document.parse(constroi_tag("10").first.to_xml.gsub(/>[\s\n\t]*</,"><"))
			xml = assina_mensagem(xml)
			xml
		end

		def nfe_distribuicao_dfe
			xml = Nokogiri::XML::Document.parse(constroi_tag("64").first.to_xml.gsub(/>[\s\n\t]*</,"><"))
			xml
		end

		def consultar_protocolo
			xml = Nokogiri::XML::Document.parse(constroi_tag("46").first.to_xml.gsub(/>[\s\n\t]*</,"><"))
			xml
		end

		def criar_carta_correcao
			xml = Nokogiri::XML::Document.parse(constroi_tag("76").first.to_xml.gsub(/>[\s\n\t]*</,"><"))
			xml = assina_mensagem(xml)
			xml
		end

		def confirmacao_da_operacao
			xml = Nokogiri::XML::Document.parse(constroi_tag("76").first.to_xml.gsub(/>[\s\n\t]*</,"><"))
			xml = assina_mensagem(xml)
			xml
		end

		def ciencia_da_operacao
			xml = Nokogiri::XML::Document.parse(constroi_tag("76").first.to_xml.gsub(/>[\s\n\t]*</,"><"))
			xml = assina_mensagem(xml)
			xml
		end

		def desconhecimento_da_operacao
			xml = Nokogiri::XML::Document.parse(constroi_tag("76").first.to_xml.gsub(/>[\s\n\t]*</,"><"))
			xml = assina_mensagem(xml)
			xml
		end

		def operacao_nao_realizada
			xml = Nokogiri::XML::Document.parse(constroi_tag("76").first.to_xml.gsub(/>[\s\n\t]*</,"><"))
			xml = assina_mensagem(xml)
			xml
		end

		def emissao_contingencia
			xml = Nokogiri::XML::Document.parse(constroi_tag("76").first.to_xml.gsub(/>[\s\n\t]*</,"><"))
			xml = assina_mensagem(xml)
			xml
		end

		def cancelar_nota_substituicao
			xml = Nokogiri::XML::Document.parse(constroi_tag("76").first.to_xml.gsub(/>[\s\n\t]*</,"><"))
			xml = assina_mensagem(xml)
			xml
		end

		def cancelar_nota
			xml = Nokogiri::XML::Document.parse(constroi_tag("76").first.to_xml.gsub(/>[\s\n\t]*</,"><"))
			xml = assina_mensagem(xml)
			xml
		end

		def prorrogar_prazo_1
			xml = Nokogiri::XML::Document.parse(constroi_tag("76").first.to_xml.gsub(/>[\s\n\t]*</,"><"))
			xml = assina_mensagem(xml)
			xml
		end

		def prorrogar_prazo_2
			xml = Nokogiri::XML::Document.parse(constroi_tag("76").first.to_xml.gsub(/>[\s\n\t]*</,"><"))
			xml = assina_mensagem(xml)
			xml
		end

		def ator_interessado
			xml = Nokogiri::XML::Document.parse(constroi_tag("76").first.to_xml.gsub(/>[\s\n\t]*</,"><"))
			xml = assina_mensagem(xml)
			xml
		end

		def cancelamento_prazo_1
			xml = Nokogiri::XML::Document.parse(constroi_tag("76").first.to_xml.gsub(/>[\s\n\t]*</,"><"))
			xml = assina_mensagem(xml)
			xml
		end

		def cancelamento_prazo_2
			xml = Nokogiri::XML::Document.parse(constroi_tag("76").first.to_xml.gsub(/>[\s\n\t]*</,"><"))
			xml = assina_mensagem(xml)
			xml
		end

		private

			def constroi_tag(tag)
				
				tag_xml = Nokogiri::XML("<#{@mapa_tags[tag]["nome"]}>").elements.first
				tag_tipo = @mapa_tags[tag]["tipo"]
				resultado = []

				tag_xml = adiciona_namespace(tag_xml,tag)
				tag_xml = adiciona_atributos(tag_xml,tag)

				if tem_filhos(tag)
					tag_filhos = busca_filhos_de(tag) - busca_atributos_de(tag)
					if OPCIONAIS.include?(tag_tipo)
						tag_filhos.each do |filho|
							resultado += constroi_tag(filho)
						end
					elsif TAGS.include?(tag_tipo)
						tag_filhos.each do |filho|
							constroi_tag(filho).each do |item|
								tag_xml.add_child(item)
							end
						end
						resultado << tag_xml
					end
				else
					tag_xml = preenche_tag(tag_xml,tag)
					resultado << tag_xml
				end

				resultado

			end

			def adiciona_namespace(xml,tag_id)
				xml['xmlns'] = @mapa_tags[tag_id]["namespace"] if !@mapa_tags[tag_id]["namespace"].nil?
				xml
			end

			def adiciona_atributos(xml,tag_id)
				
				atributos = busca_atributos_de(tag_id)
				
				atributos.each do |atributo|
					atributo = @mapa_tags[atributo]
						if atributo["regex"].nil?
							xml[atributo["nome"]] = ""
						else
							xml[atributo["nome"]] = Regexp.new(atributo["regex"]).random_example.gsub("\u0000",'') if !atributo["regex"].nil?
						end
				end

				xml
			
			end

			def tem_filhos(pai)
				if @mapa_tags.key?(pai)
					!@mapa_tags[pai]["filhos"].empty?
				else
					false
				end
			end

			def preenche_tag(xml,tag_id)
				regex = @mapa_tags[tag_id]["regex"]
				xml.content = Regexp.new(regex).random_example.gsub("\u0000",'') unless regex.nil?
				xml
			end

			def busca_filhos_de(pai)
				@mapa_tags[pai]["filhos"]
			end

			def busca_atributos_de(pai)
				@mapa_tags[pai]["atributos"]
			end

			def cria_mapa_tags()
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
			end

			def remove_tags_mutex
				tags = @mapa_tags.keys
				filhos = {tags_filhos_ce: [],tags_filhos_cg: [],tags_filhos_cgo: [],tags_filhos_normais: []}
				tags.each do |tag_pai|
					lista_filhos = busca_filhos_de(tag_pai)
					lista_filhos.each do |filho|
						dados_filho = @mapa_tags[filho]
						case dados_filho["tipo"]
						when "CE"
							filhos[:tags_filhos_ce] << filho
						when "CG"
							filhos[:tags_filhos_cg] << filho
						when "CGO"
							filhos[:tags_filhos_cgo] << filho
						else
							filhos[:tags_filhos_normais] << filho
						end
					end
					@mapa_tags[tag_pai]["filhos"] = ([filhos[:tags_filhos_ce].sample,filhos[:tags_filhos_cg].sample,filhos[:tags_filhos_cgo].sample].compact + filhos[:tags_filhos_normais]).sort_by{|item| item.to_i}
					filhos = {tags_filhos_ce: [],tags_filhos_cg: [],tags_filhos_cgo: [],tags_filhos_normais: []}
				end
			end

			def assina_mensagem(xml)
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
