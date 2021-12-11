require 'pry'

module NF

	module Mock

		class Validator

			def initialize
				@mapa_tags = cria_mapa_tags
			end

			def verifica_regras(xml)
				nfref_filho_unico(xml)
				regra_e16a_10(xml)
				regra_x25a_10(xml)
				regra_x25b_10(xml)
				regra_e16a_20(xml)
				xml
			end

			private

				def nfref_filho_unico(xml)
					nfref = xml.xpath("//xs:enviNFe//xs:NFe//xs:ide//xs:NFref","xs" => "http://www.portalfiscal.inf.br/nfe").first
					if nfref.children.length > 1
						nfref.children = nfref.elements.first
					end
				end

				def regra_e16a_10(xml)
					indicador_destinatario = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:indIEDest","xs" => "http://www.portalfiscal.inf.br/nfe").first
					modelo = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:mod","xs" => "http://www.portalfiscal.inf.br/nfe").first
					
					if modelo.content == '65'
						indicador_destinatario.content = "9"
					end
				end

				def regra_x25a_10(xml)
					vagao = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:vagao","xs" => "http://www.portalfiscal.inf.br/nfe").first
					modelo = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:mod","xs" => "http://www.portalfiscal.inf.br/nfe").first
					
					if modelo.content == "65"
						vagao.remove unless vagao.nil?
					end
				end

				def regra_x25b_10(xml)
					balsa = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:balsa","xs" => "http://www.portalfiscal.inf.br/nfe").first
					modelo = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:mod","xs" => "http://www.portalfiscal.inf.br/nfe").first
					
					if modelo.content == "65"
						balsa.remove unless balsa.nil?
					end
				end

				def regra_e16a_20(xml)
					indicador_destinatario = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:indIEDest","xs" => "http://www.portalfiscal.inf.br/nfe").first
					indicador_operacao = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:idDest","xs" => "http://www.portalfiscal.inf.br/nfe").first
					modelo = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:mod","xs" => "http://www.portalfiscal.inf.br/nfe").first

					if modelo.content == "55"
						if indicador_operacao.content == "3"
							indicador_destinatario.content = "9"
						end
					end
				end

				def regra_e16a_30(xml)
				end

				def cria_mapa_tags()
					tags = CSV.read('tags.csv',col_sep:";",headers:true)
					tag_map = {}
					tags.each do |tag|
						dados_tag = {}
						dados_tag["id"] = tag["id"]
						dados_tag["campo"] = tag["campo"]
						dados_tag["elemento"] = tag["elemento"]
						dados_tag["pai"] = tag["pai"]
						dados_tag["min"] = tag["min"]
						dados_tag["max"] = tag["max"]
						dados_tag["regex"] = tag["regex"]
						dados_tag["namespace"] = tag["namespace"]
						dados_tag["filhos"] = []
						tag_map["#{tag["id"]}"] = dados_tag

						if tag_map.key?(tag["pai"])
							tag_map[tag["pai"]]["filhos"] << tag["id"]
						end

					end
					tag_map
				end

		end

	end

end