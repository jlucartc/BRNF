module NF

	class Validator

		def initialize
			@errors = []
		end

		def verifica_regras(xml)
			regra_B25c_10(xml)
			regra_B25c_20(xml)
		end

		def regra_B25c_10(xml)
			ind_pres = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:indIntermed","xs" => "http://www.portalfiscal.inf.br/nfe").first
			ind_intermed = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:indIntermed","xs" => "http://www.portalfiscal.inf.br/nfe").first

			if !ind_pres.nil?
				if [2,3,4,9].include?(ind_pres.content.to_i)
					@errors << {codigo: "B25c_10", mensagem: "Quando indPres == [2,3,4,9], a tag indIntermed deve ser informada."} if ind_intermed.content.nil?
				end
			end
		end

		def regra_B25c_20(xml)
			ind_pres = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:indIntermed","xs" => "http://www.portalfiscal.inf.br/nfe").first
			ind_intermed = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:indIntermed","xs" => "http://www.portalfiscal.inf.br/nfe").first

			if !ind_pres.nil?
				if ![2,3,4,9].include?(ind_pres.content.to_i)
					@errors << {codigo: "B25c_20", mensagem: "Quando indPres <> [2,3,4,9], a tag indIntermed não pode ser informada."}
				end
			end
		end

	end

end