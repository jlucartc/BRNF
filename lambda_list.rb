lambda_list = [
	{"id"=>"1", "xpath"=>"//xs:enviNFe", "lambda" => lambda{|msg,xml|}}, # OK
	{"id"=>"2", "xpath"=>"//xs:enviNFe//@versao", "lambda" => lambda{|msg,xml|}}, # OK
	{"id"=>"3", "xpath"=>"//xs:enviNFe//xs:idLote", "lambda" => lambda{|msg,xml|
		lote_xml_tag = xml.xpath("//xs:enviNFe//xs:idLote","xs" => "http://www.portalfiscal.inf.br/nfe").first
		lote_xml_tag.content = msg[:lote] if !lote_xml_tag.nil?
	}},
	{"id"=>"4", "xpath"=>"//xs:enviNFe//xs:indSinc", "lambda" => lambda{|msg,xml|
		indsinc_xml_tag = xml.xpath("//xs:enviNFe//xs:indSinc","xs" => "http://www.portalfiscal.inf.br/nfe").first
		indsinc_xml_tag.content = 1 if !indsinc_xml_tag.nil?
	}},
	{"id"=>"5", "xpath"=>"//xs:enviNFe//xs:NFe", "lambda" => lambda{|msg,xml|}},
	{"id"=>"6", "xpath"=>"//xs:consReciNFe", "lambda" => lambda{|msg,xml|}},
	{"id"=>"7", "xpath"=>"//xs:consReciNFe//@versao", "lambda" => lambda{|msg,xml|}},
	{"id"=>"8", "xpath"=>"//xs:consReciNFe//xs:tpAmb", "lambda" => lambda{|msg,xml|
		ambiente_xml_tag = xml.xpath("//xs:consReciNFe//xs:tpAmb","xs" => "http://www.portalfiscal.inf.br/nfe").first
		ambiente_xml_tag.content = msg[:ambiente] if !ambiente_xml_tag.nil?
	}},
	{"id"=>"9", "xpath"=>"//xs:consReciNFe//xs:nRec", "lambda" => lambda{|msg,xml|
		recibo_xml_tag = xml.xpath("//xs:consReciNFe//xs:nRec","xs" => "http://www.portalfiscal.inf.br/nfe").first
		recibo_xml_tag.content = msg[:recibo] if !recibo_xml_tag.nil?
	}},
	{"id"=>"10", "xpath"=>"//xs:inutNFe", "lambda" => lambda{|msg,xml|}},
	{"id"=>"11", "xpath"=>"//xs:inutNFe//@versao", "lambda" => lambda{|msg,xml|}},
	{"id"=>"12", "xpath"=>"//xs:inutNFe//xs:infInut", "lambda" => lambda{|msg,xml|}},
	{"id"=>"13", "xpath"=>"//xs:inutNFe//xs:infInut//@Id", "lambda" => lambda{|msg,xml|
		id_xml_tag = xml.xpath("//xs:inutNFe//xs:infInut//@Id","xs" => "http://www.portalfiscal.inf.br/nfe").first
		id_xml_tag.content = "ID#{msg[:codigo_uf]}#{msg[:ano]}#{msg[:cnpj]}#{msg[:modelo]}#{msg[:serie]}#{msg[:numero_inicial]}#{msg[:numero_final]}" if !id_xml_tag.nil?
	}},
	{"id"=>"14", "xpath"=>"//xs:inutNFe//xs:infInut//xs:tpAmb", "lambda" => lambda{|msg,xml|
		ambiente_xml_tag = xml.xpath("//xs:inutNFe//xs:infInut//xs:tpAmb","xs" => "http://www.portalfiscal.inf.br/nfe").first
		ambiente_xml_tag.content = msg[:ambiente] if !ambiente_xml_tag.nil?
	}},
	{"id"=>"15", "xpath"=>"//xs:inutNFe//xs:infInut//xs:xServ", "lambda" => lambda{|msg,xml|
		servico_xml_tag = xml.xpath("//xs:inutNFe//xs:infInut//xs:xServ","xs" => "http://www.portalfiscal.inf.br/nfe").first
		servico_xml_tag.content = msg[:servico] if !servico_xml_tag.nil?
	}},
	{"id"=>"16", "xpath"=>"//xs:inutNFe//xs:infInut//xs:cUF", "lambda" => lambda{|msg,xml|
		codigo_uf_xml_tag = xml.xpath("//xs:inutNFe//xs:infInut//xs:cUF","xs" => "http://www.portalfiscal.inf.br/nfe").first
		codigo_uf_xml_tag.content = msg[:codigo_uf] if !codigo_uf_xml_tag.nil?
	}},
	{"id"=>"17", "xpath"=>"//xs:inutNFe//xs:infInut//xs:ano", "lambda" => lambda{|msg,xml|
		ano_xml_tag = xml.xpath("//xs:inutNFe//xs:infInut//xs:ano","xs" => "http://www.portalfiscal.inf.br/nfe").first
		ano_xml_tag.content = msg[:ano] if !ano_xml_tag.nil?
	}},
	{"id"=>"18", "xpath"=>"//xs:inutNFe//xs:infInut//xs:CNPJ", "lambda" => lambda{|msg,xml|
		cnpj_xml_tag = xml.xpath("//xs:inutNFe//xs:infInut//xs:CNPJ","xs" => "http://www.portalfiscal.inf.br/nfe").first
		cnpj_xml_tag.content = msg[:cnpj] if !cnpj_xml_tag.nil?
	}},
	{"id"=>"19", "xpath"=>"//xs:inutNFe//xs:infInut//xs:mod", "lambda" => lambda{|msg,xml|
		modelo_xml_tag = xml.xpath("//xs:inutNFe//xs:infInut//xs:mod","xs" => "http://www.portalfiscal.inf.br/nfe").first
		modelo_xml_tag.content = msg[:modelo] if !modelo_xml_tag.nil?
	}},
	{"id"=>"20", "xpath"=>"//xs:inutNFe//xs:infInut//xs:serie", "lambda" => lambda{|msg,xml|
		serie_xml_tag = xml.xpath("//xs:inutNFe//xs:infInut//xs:serie","xs" => "http://www.portalfiscal.inf.br/nfe").first
		serie_xml_tag.content = msg[:serie] if !serie_xml_tag.nil?
	}},
	{"id"=>"21", "xpath"=>"//xs:inutNFe//xs:infInut//xs:nNFIni", "lambda" => lambda{|msg,xml|
		numero_inicial_xml_tag = xml.xpath("//xs:inutNFe//xs:infInut//xs:nNFIni","xs" => "http://www.portalfiscal.inf.br/nfe").first
		numero_inicial_xml_tag.content = msg[:numero_inicial] if !numero_inicial_xml_tag.nil?
	}},
	{"id"=>"22", "xpath"=>"//xs:inutNFe//xs:infInut//xs:nNFFin", "lambda" => lambda{|msg,xml|
		numero_final_xml_tag = xml.xpath("//xs:inutNFe//xs:infInut//xs:nNFFin","xs" => "http://www.portalfiscal.inf.br/nfe").first
		numero_final_xml_tag.content = msg[:numero_final] if !numero_final_xml_tag.nil?
	}},
	{"id"=>"23", "xpath"=>"//xs:inutNFe//xs:infInut//xs:xJust", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:inutNFe//xs:infInut//xs:xJust","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	#{"id"=>"24", "xpath"=>"//xs:Signature", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"25", "xpath"=>"//xs:Signature//xs:SignedInfo", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"26", "xpath"=>"//xs:Signature//xs:SignedInfo//xs:CanonicalizationMethod", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"27", "xpath"=>"//xs:Signature//xs:SignedInfo//xs:CanonicalizationMethod//@Algorithm", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"28", "xpath"=>"//xs:Signature//xs:SignedInfo//xs:SignatureMethod", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"29", "xpath"=>"//xs:Signature//xs:SignedInfo//xs:SignatureMethod//@Algorithm", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"30", "xpath"=>"//xs:Signature//xs:SignedInfo//xs:Reference", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"31", "xpath"=>"//xs:Signature//xs:SignedInfo//xs:Reference//@URI", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"32", "xpath"=>"//xs:Signature//xs:SignedInfo//xs:Reference//xs:Transforms", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"33", "xpath"=>"//xs:Signature//xs:SignedInfo//xs:Reference//xs:Transforms//xs:Transform", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"34", "xpath"=>"//xs:Signature//xs:SignedInfo//xs:Reference//xs:Transforms//xs:Transform//@Algorithm", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"36", "xpath"=>"//xs:Signature//xs:SignedInfo//xs:Reference//xs:Transforms//xs:Transform", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"37", "xpath"=>"//xs:Signature//xs:SignedInfo//xs:Reference//xs:Transforms//xs:Transform//@Algorithm", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"39", "xpath"=>"//xs:Signature//xs:SignedInfo//xs:Reference//xs:DigestMethod", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"40", "xpath"=>"//xs:Signature//xs:SignedInfo//xs:Reference//xs:DigestMethod//@Algorithm", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"41", "xpath"=>"//xs:Signature//xs:SignedInfo//xs:Reference//xs:DigestValue", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"42", "xpath"=>"//xs:Signature//xs:SignatureValue", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"43", "xpath"=>"//xs:Signature//xs:KeyInfo", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"44", "xpath"=>"//xs:Signature//xs:KeyInfo//xs:X509Data", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"45", "xpath"=>"//xs:Signature//xs:KeyInfo//xs:X509Data//xs:X509Certificate", "lambda" => lambda{|msg,xml|}},
	{"id"=>"46", "xpath"=>"//xs:consSitNFe", "lambda" => lambda{|msg,xml|}},
	{"id"=>"47", "xpath"=>"//xs:consSitNFe//@versao", "lambda" => lambda{|msg,xml|}},
	{"id"=>"48", "xpath"=>"//xs:consSitNFe//xs:tpAmb", "lambda" => lambda{|msg,xml|
		ambiente_xml_tag = xml.xpath("//xs:consSitNFe//xs:tpAmb","xs" => "http://www.portalfiscal.inf.br/nfe").first
		ambiente_xml_tag.content = msg[:ambiente] if !ambiente_xml_tag.nil?
	}},
	{"id"=>"49", "xpath"=>"//xs:consSitNFe//xs:xServ", "lambda" => lambda{|msg,xml|
		servico_xml_tag = xml.xpath("//xs:consSitNFe//xs:xServ","xs" => "http://www.portalfiscal.inf.br/nfe").first
		servico_xml_tag.content = msg[:servico] if !servico_xml_tag.nil?
	}},
	{"id"=>"50", "xpath"=>"//xs:consSitNFe//xs:chNFe", "lambda" => lambda{|msg,xml|
		chave_nota_xml_tag = xml.xpath("//xs:consSitNFe//xs:chNFe","xs" => "http://www.portalfiscal.inf.br/nfe").first
		chave_nota_xml_tag.content = msg[:chave_nota] if !chave_nota_xml_tag.nil?
	}},
	{"id"=>"51", "xpath"=>"//xs:consStatServ", "lambda" => lambda{|msg,xml|}},
	{"id"=>"52", "xpath"=>"//xs:consStatServ//@versao", "lambda" => lambda{|msg,xml|}},
	{"id"=>"53", "xpath"=>"//xs:consStatServ//xs:tpAmb", "lambda" => lambda{|msg,xml|
		ambiente_xml_tag = xml.xpath("//xs:consStatServ//xs:tpAmb","xs" => "http://www.portalfiscal.inf.br/nfe").first
		ambiente_xml_tag.content = msg[:ambiente] if !ambiente_xml_tag.nil?
	}},
	{"id"=>"54", "xpath"=>"//xs:consStatServ//xs:cUF", "lambda" => lambda{|msg,xml|
		codigo_uf_xml_tag = xml.xpath("//xs:consStatServ//xs:cUF","xs" => "http://www.portalfiscal.inf.br/nfe").first
		codigo_uf_xml_tag.content = msg[:codigo_uf] if !codigo_uf_xml_tag.nil?
	}},
	{"id"=>"55", "xpath"=>"//xs:consStatServ//xs:xServ", "lambda" => lambda{|msg,xml|
		servico_xml_tag = xml.xpath("//xs:consStatServ//xs:xServ","xs" => "http://www.portalfiscal.inf.br/nfe").first
		servico_xml_tag.content = msg[:servico] if !servico_xml_tag.nil?
	}},
	{"id"=>"56", "xpath"=>"//xs:ConsCad", "lambda" => lambda{|msg,xml|}},
	{"id"=>"57", "xpath"=>"//xs:ConsCad//@versao", "lambda" => lambda{|msg,xml|}},
	{"id"=>"58", "xpath"=>"//xs:ConsCad//xs:infCons", "lambda" => lambda{|msg,xml| 
			cpf_cnpj = msg[:cpf_cnpj]
			ie = msg[:inscricao_estadual]

			if ie.nil?
				sibling_xml_tag = xml.xpath("//xs:ConsCad//xs:infCons//xs:UF","xs" => "http://www.portalfiscal.inf.br/nfe").first
				
				if cpf_cnpj.length == 9
					child_xml_tag = Nokogiri::XML("<CPF>").elements.first
					cnpj_xml_tag = xml.xpath("//xs:ConsCad//xs:infCons//xs:CNPJ","xs" => "http://www.portalfiscal.inf.br/nfe").first
					cnpj_xml_tag.remove if !cnpj_xml_tag.nil?
				elsif cpf_cnpj.length == 11
					child_xml_tag = Nokogiri::XML("<CNPJ>").elements.first
					cpf_xml_tag = xml.xpath("//xs:ConsCad//xs:infCons//xs:CPF","xs" => "http://www.portalfiscal.inf.br/nfe").first
					cpf_xml_tag.remove if !cpf_xml_tag.nil?
				end

				inscricao_estadual_xml_tag = xml.xpath("//xs:ConsCad//xs:infCons//xs:IE","xs" => "http://www.portalfiscal.inf.br/nfe").first
				inscricao_estadual_xml_tag.remove if !inscricao_estadual_xml_tag.nil?
			else
				child_xml_tag = Nokogiri::XML("<IE>").elements.first
				
				cpf_xml_tag = xml.xpath("//xs:ConsCad//xs:infCons//xs:CPF","xs" => "http://www.portalfiscal.inf.br/nfe").first
				cnpj_xml_tag = xml.xpath("//xs:ConsCad//xs:infCons//xs:CNPJ","xs" => "http://www.portalfiscal.inf.br/nfe").first
				cpf_xml_tag.remove if !cpf_xml_tag.nil?
				cnpj_xml_tag.remove if !cnpj_xml_tag.nil?
			end

			sibling_xml_tag.after(child_xml_tag)
	}},
	{"id"=>"59", "xpath"=>"//xs:ConsCad//xs:infCons//xs:xServ", "lambda" => lambda{|msg,xml|
		servico_xml_tag = xml.xpath("//xs:ConsCad//xs:infCons//xs:xServ","xs" => "http://www.portalfiscal.inf.br/nfe").first
		servico_xml_tag.content = msg[:servico] if !servico_xml_tag.nil?
	}},
	{"id"=>"60", "xpath"=>"//xs:ConsCad//xs:infCons//xs:UF", "lambda" => lambda{|msg,xml|
		uf_xml_tag = xml.xpath("//xs:ConsCad//xs:infCons//xs:UF","xs" => "http://www.portalfiscal.inf.br/nfe").first
		uf_xml_tag.content = msg[:uf] if !uf_xml_tag.nil?
	}},
	{"id"=>"61", "xpath"=>"//xs:ConsCad//xs:infCons//xs:IE", "lambda" => lambda{|msg,xml|
		inscricao_estadual_xml_tag = xml.xpath("//xs:ConsCad//xs:infCons//xs:IE","xs" => "http://www.portalfiscal.inf.br/nfe").first
		inscricao_estadual_xml_tag.content = msg[:inscricao_estadual] if !inscricao_estadual_xml_tag.nil?
	}},
	{"id"=>"62", "xpath"=>"//xs:ConsCad//xs:infCons//xs:CNPJ", "lambda" => lambda{|msg,xml|
		cpf_cnpj_xml_tag = xml.xpath("//xs:ConsCad//xs:infCons//xs:CNPJ","xs" => "http://www.portalfiscal.inf.br/nfe").first
		cpf_cnpj_xml_tag.content = msg[:cpf_cnpj] if !cpf_cnpj_xml_tag.nil? and msg[:cpf_cnpj].length == 11
	}},
	{"id"=>"63", "xpath"=>"//xs:ConsCad//xs:infCons//xs:CPF", "lambda" => lambda{|msg,xml|
		cpf_cnpj_xml_tag = xml.xpath("//xs:ConsCad//xs:infCons//xs:CPF","xs" => "http://www.portalfiscal.inf.br/nfe").first
		cpf_cnpj_xml_tag.content = msg[:cpf_cnpj] if !cpf_cnpj_xml_tag.nil? and msg[:cpf_cnpj].length == 9
	}},
	{"id"=>"64", "xpath"=>"//xs:distDFeInt", "lambda" => lambda{|msg,xml| 
			cpf_cnpj = msg[:cpf_cnpj]
			ultimo_nsu = msg[:ultimo_nsu]
			chave_nota = msg[:chave_nota]
			consulta_nsu = msg[:consulta_nsu]
			
			sibling_xml_tag = xml.xpath("//xs:distDFeInt//xs:cUFAutor","xs" => "http://www.portalfiscal.inf.br/nfe").first

			if cpf_cnpj.length == 9
				child_xml_tag = Nokogiri::XML("<CPF>").elements.first
				cnpj_xml_tag = xml.xpath("//xs:distDFeInt//xs:CNPJ","xs" => "http://www.portalfiscal.inf.br/nfe").first
				cnpj_xml_tag.remove if !cnpj_xml_tag.nil?
			elsif cpf_cnpj.length == 11
				child_xml_tag = Nokogiri::XML("<CNPJ>").elements.first
				cpf_xml_tag = xml.xpath("//xs:distDFeInt//xs:CPF","xs" => "http://www.portalfiscal.inf.br/nfe").first
				cpf_xml_tag.remove if !cpf_xml_tag.nil?
			end

			sibling_xml_tag.add_child(child_xml_tag) if !parent_xml_tag.nil?
			sibling_xml_tag = xml.xpath("//xs:distDFeInt","xs" => "http://www.portalfiscal.inf.br/nfe").children.last

			if !ultimo_nsu.nil? and consulta_nsu.nil? and chave_nota.nil?
				dist_nsu_xml_tag = Nokogiri::XML("<distNSU>").elements.first
				sibling_xml_tag.after(dist_nsu_xml_tag)

				cons_nsu_xml_tag = xml.xpath("//xs:distDFeInt//xs:consNSU","xs" => "http://www.portalfiscal.inf.br/nfe").first
				cons_nsu_xml_tag.remove if !cons_nsu_xml_tag.nil?
				
				cons_chnfe_xml_tag = xml.xpath("//xs:distDFeInt//xs:consChNFe","xs" => "http://www.portalfiscal.inf.br/nfe").first
				cons_chnfe_xml_tag.remove if !cons_chnfe_xml_tag.nil?
			elsif ultimo_nsu.nil? and !consulta_nsu.nil? and chave_nota.nil?
				cons_nsu_xml_path = Nokogiri::XML("<consNSU>").elements.first
				sibling_xml_tag.after(cons_nsu_xml_path)

				dist_nsu_xml_tag = xml.xpath("//xs:distDFeInt//xs:distNSU","xs" => "http://www.portalfiscal.inf.br/nfe").first
				dist_nsu_xml_tag.remove if !cons_nsu_xml_tag.nil?
				
				cons_chnfe_xml_tag = xml.xpath("//xs:distDFeInt//xs:consChNFe","xs" => "http://www.portalfiscal.inf.br/nfe").first
				cons_chnfe_xml_tag.remove if !cons_chnfe_xml_tag.nil?
			elsif ultimo_nsu.nil? and consulta_nsu.nil? and !chave_nota.nil?
				cons_chnfe_xml_tag = Nokogiri::XML("<consChNFe>").elements.first
				sibling_xml_tag.after(cons_chnfe_xml_tag)

				cons_nsu_xml_tag = xml.xpath("//xs:distDFeInt//xs:consNSU","xs" => "http://www.portalfiscal.inf.br/nfe").first
				cons_nsu_xml_tag.remove if !cons_nsu_xml_tag.nil?
				
				dist_nsu_xml_tag = xml.xpath("//xs:distDFeInt//xs:distNSU","xs" => "http://www.portalfiscal.inf.br/nfe").first
				dist_nsu_xml_tag.remove if !dist_nsu_xml_tag.nil?
			end
	}},
	{"id"=>"65", "xpath"=>"//xs:distDFeInt//@versao", "lambda" => lambda{|msg,xml|}},
	{"id"=>"66", "xpath"=>"//xs:distDFeInt//xs:tpAmb", "lambda" => lambda{|msg,xml|
		ambiente_xml_tag = xml.xpath("//xs:distDFeInt//xs:tpAmb","xs" => "http://www.portalfiscal.inf.br/nfe").first
		ambiente_xml_tag.content = msg[:ambiente] if !ambiente_xml_tag.nil?
	}},
	{"id"=>"67", "xpath"=>"//xs:distDFeInt//xs:cUFAutor", "lambda" => lambda{|msg,xml|
		codigo_uf_autor_xml_tag = xml.xpath("//xs:distDFeInt//xs:cUFAutor","xs" => "http://www.portalfiscal.inf.br/nfe").first
		codigo_uf_autor_xml_tag.content = msg[:codigo_uf_autor] if !codigo_uf_autor_xml_tag.nil?
	}},
	{"id"=>"68", "xpath"=>"//xs:distDFeInt//xs:CNPJ", "lambda" => lambda{|msg,xml|
		cpf_cnpj_xml_tag = xml.xpath("//xs:distDFeInt//xs:CNPJ","xs" => "http://www.portalfiscal.inf.br/nfe").first
		cpf_cnpj_xml_tag.content = msg[:cpf_cnpj] if !cpf_cnpj_xml_tag.nil? and msg[:cpf_cnpj].length == 11
	}},
	{"id"=>"69", "xpath"=>"//xs:distDFeInt//xs:CPF", "lambda" => lambda{|msg,xml|
		cpf_cnpj_xml_tag = xml.xpath("//xs:distDFeInt//xs:CPF","xs" => "http://www.portalfiscal.inf.br/nfe").first
		cpf_cnpj_xml_tag.content = msg[:cpf_cnpj] if !cpf_cnpj_xml_tag.nil? and msg[:cpf_cnpj].length == 9
	}},
	{"id"=>"70", "xpath"=>"//xs:distDFeInt//xs:distNSU", "lambda" => lambda{|msg,xml|}},
	{"id"=>"71", "xpath"=>"//xs:distDFeInt//xs:distNSU//xs:ultNSU", "lambda" => lambda{|msg,xml|
		ultimo_nsu_xml_tag = xml.xpath("//xs:distDFeInt//xs:distNSU//xs:ultNSU","xs" => "http://www.portalfiscal.inf.br/nfe").first
		ultimo_nsu_xml_tag.content = msg[:ultimo_nsu] if !ultimo_nsu_xml_tag.nil?
	}},
	{"id"=>"72", "xpath"=>"//xs:distDFeInt//xs:consNSU", "lambda" => lambda{|msg,xml|}},
	{"id"=>"73", "xpath"=>"//xs:distDFeInt//xs:consNSU//xs:NSU", "lambda" => lambda{|msg,xml|
		consulta_nsu_xml_tag = xml.xpath("//xs:distDFeInt//xs:consNSU//xs:NSU","xs" => "http://www.portalfiscal.inf.br/nfe").first
		consulta_nsu_xml_tag.content = msg[:consulta_nsu] if !consulta_nsu_xml_tag.nil?
	}},
	{"id"=>"74", "xpath"=>"//xs:distDFeInt//xs:consChNFe", "lambda" => lambda{|msg,xml|}},
	{"id"=>"75", "xpath"=>"//xs:distDFeInt//xs:consChNFe//xs:chNFe", "lambda" => lambda{|msg,xml|
		chave_nota_xml_tag = xml.xpath("//xs:distDFeInt//xs:consChNFe//xs:chNFe","xs" => "http://www.portalfiscal.inf.br/nfe").first
		chave_nota_xml_tag.content = msg[:chave_nota] if !chave_nota_xml_tag.nil?
	}},
	{"id"=>"76", "xpath"=>"//xs:envEvento", "lambda" => lambda{|msg,xml|}},
	{"id"=>"77", "xpath"=>"//xs:envEvento//@versao", "lambda" => lambda{|msg,xml|}},
	{"id"=>"78", "xpath"=>"//xs:envEvento//xs:idLote", "lambda" => lambda{|msg,xml|
		lote_xml_tag = xml.xpath("//xs:envEvento//xs:idLote","xs" => "http://www.portalfiscal.inf.br/nfe").first
		lote_xml_tag.content = msg[:lote] if !lote_xml_tag.nil?
	}},
	{"id"=>"79", "xpath"=>"//xs:envEvento//xs:evento", "lambda" => lambda{|msg,xml|}},
	{"id"=>"80", "xpath"=>"//xs:envEvento//xs:evento//@versao", "lambda" => lambda{|msg,xml|}},
	{"id"=>"81", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento", "lambda" => lambda{|msg,xml| 
		cpf_cnpj = msg[:cpf_cnpj]

		sibling_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:tpAmb","xs" => "http://www.portalfiscal.inf.br/nfe").first
		
		if cpf_cnpj.length == 9
			child_xml_tag = Nokogiri::XML("<CPF>").elements.first
			cnpj_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:CNPJ","xs" => "http://www.portalfiscal.inf.br/nfe").first
			cnpj_xml_tag.remove if !cnpj_xml_tag.nil?
		elsif cpf_cnpj.length == 11
			child_xml_tag = Nokogiri::XML("<CNPJ>").elements.first
			cpf_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//:CPF","xs" => "http://www.portalfiscal.inf.br/nfe").first
			cpf_xml_tag.remove if !cpf_xml_tag.nil?
		end

		sibling_xml_tag.after(child_xml_tag)
	}},
	{"id"=>"82", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//@Id", "lambda" => lambda{|msg,xml|
		id_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//@Id","xs" => "http://www.portalfiscal.inf.br/nfe").first
		id_xml_tag.content = "ID#{msg[:tipo_evento]}#{msg[:chave_nota]}#{msg[:numero_sequencial_evento]}" if !id_xml_tag.nil?
	}},
	{"id"=>"83", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:cOrgao", "lambda" => lambda{|msg,xml|
		codigo_orgao_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:cOrgao","xs" => "http://www.portalfiscal.inf.br/nfe").first
		codigo_orgao_xml_tag.content = msg[:codigo_orgao] if !codigo_orgao_xml_tag.nil?
	}},
	{"id"=>"84", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:tpAmb", "lambda" => lambda{|msg,xml|
		ambiente_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:tpAmb","xs" => "http://www.portalfiscal.inf.br/nfe").first
		ambiente_xml_tag.content = msg[:ambiente] if !ambiente_xml_tag.nil?
	}},
	{"id"=>"85", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:CNPJ", "lambda" => lambda{|msg,xml|
		cpf_cnpj_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:CNPJ","xs" => "http://www.portalfiscal.inf.br/nfe").first
		cpf_cnpj_xml_tag.content = msg[:cpf_cnpj] if !cpf_cnpj_xml_tag.nil? and msg[:cpf_cnpj].length == 11
	}},
	{"id"=>"86", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:CPF", "lambda" => lambda{|msg,xml|
		cpf_cnpj_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:CPF","xs" => "http://www.portalfiscal.inf.br/nfe").first
		cpf_cnpj_xml_tag.content = msg[:cpf_cnpj] if !cpf_cnpj_xml_tag.nil? and msg[:cpf_cnpj].length == 9
	}},
	{"id"=>"87", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:chNFe", "lambda" => lambda{|msg,xml|
		chave_nota_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:chNFe","xs" => "http://www.portalfiscal.inf.br/nfe").first
		chave_nota_xml_tag.content = msg[:chave_nota] if !chave_nota_xml_tag.nil?
	}},
	{"id"=>"88", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:dhEvento", "lambda" => lambda{|msg,xml|
		dhEvento_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:dhEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		dhEvento_xml_tag.content = Time.now.strftime("%Y-%m-%dT%T%:z") if !dhEvento_xml_tag.nil?
	}},
	{"id"=>"89", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:tpEvento", "lambda" => lambda{|msg,xml|
		tipo_evento_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:tpEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		tipo_evento_xml_tag.content = msg[:tipo_evento] if !tipo_evento_xml_tag.nil?
	}},
	{"id"=>"90", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:nSeqEvento", "lambda" => lambda{|msg,xml|
		numero_sequencial_evento_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:nSeqEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		numero_sequencial_evento_xml_tag.content = msg[:numero_sequencial_evento] if !numero_sequencial_evento_xml_tag.nil?
	}},
	{"id"=>"91", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:verEvento", "lambda" => lambda{|msg,xml|
		versao_evento_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:verEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		versao_evento_xml_tag.content = msg[:versao_evento] if !versao_evento_xml_tag.nil?
	}},
	{"id"=>"92", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"93", "xpath"=>"//xs:Signature", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"94", "xpath"=>"//xs:Signature//xs:SignedInfo", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"95", "xpath"=>"//xs:Signature//xs:SignedInfo//xs:CanonicalizationMethod", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"96", "xpath"=>"//xs:Signature//xs:SignedInfo//xs:CanonicalizationMethod//@Algorithm", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"97", "xpath"=>"//xs:Signature//xs:SignedInfo//xs:SignatureMethod", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"98", "xpath"=>"//xs:Signature//xs:SignedInfo//xs:SignatureMethod//@Algorithm", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"99", "xpath"=>"//xs:Signature//xs:SignedInfo//xs:Reference", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"100", "xpath"=>"//xs:Signature//xs:SignedInfo//xs:Reference//@URI", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"101", "xpath"=>"//xs:Signature//xs:SignedInfo//xs:Reference//xs:Transforms", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"102", "xpath"=>"//xs:Signature//xs:SignedInfo//xs:Reference//xs:Transforms//xs:Transform", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"103", "xpath"=>"//xs:Signature//xs:SignedInfo//xs:Reference//xs:Transforms//xs:Transform//@Algorithm", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"105", "xpath"=>"//xs:Signature//xs:SignedInfo//xs:Reference//xs:Transforms//xs:Transform", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"106", "xpath"=>"//xs:Signature//xs:SignedInfo//xs:Reference//xs:Transforms//xs:Transform//@Algorithm", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"108", "xpath"=>"//xs:Signature//xs:SignedInfo//xs:Reference//xs:DigestMethod", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"109", "xpath"=>"//xs:Signature//xs:SignedInfo//xs:Reference//xs:DigestMethod//@Algorithm", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"110", "xpath"=>"//xs:Signature//xs:SignedInfo//xs:Reference//xs:DigestValue", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"111", "xpath"=>"//xs:Signature//xs:SignatureValue", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"112", "xpath"=>"//xs:Signature//xs:KeyInfo", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"113", "xpath"=>"//xs:Signature//xs:KeyInfo//xs:X509Data", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"114", "xpath"=>"//xs:Signature//xs:KeyInfo//xs:X509Data//xs:X509Certificate", "lambda" => lambda{|msg,xml|}},
	{"id"=>"115", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@versao", "lambda" => lambda{|msg,xml|

	}},
	{"id"=>"116", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento", "lambda" => lambda{|msg,xml|
		descricao_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		descricao_xml_tag.content = msg[:descricao] if !descricao_xml_tag.nil?
	}},
	{"id"=>"117", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:cOrgaoAutor", "lambda" => lambda{|msg,xml|
		codigo_orgao_autor_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:cOrgaoAutor","xs" => "http://www.portalfiscal.inf.br/nfe").first
		codigo_orgao_autor_xml_tag.content = msg[:codigo_orgao_autor] if !codigo_orgao_autor_xml_tag.nil?
	}},
	{"id"=>"118", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpAutor", "lambda" => lambda{|msg,xml|
		tipo_autor_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpAutor","xs" => "http://www.portalfiscal.inf.br/nfe").first
		tipo_autor_xml_tag.content = msg[:tipo_autor] if !tipo_autor_xml_tag.nil?
	}},
	{"id"=>"119", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:verAplic", "lambda" => lambda{|msg,xml|
		versao_aplicacao_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:verAplic","xs" => "http://www.portalfiscal.inf.br/nfe").first
		versao_aplicacao_xml_tag.content = msg[:versao_aplicacao] if !versao_aplicacao_xml_tag.nil?
	}},
	{"id"=>"120", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:nProt", "lambda" => lambda{|msg,xml|
		protocolo_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:nProt","xs" => "http://www.portalfiscal.inf.br/nfe").first
		protocolo_xml_tag.content = msg[:protocolo] if !protocolo_xml_tag.nil?
	}},
	{"id"=>"121", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xJust", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xJust","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"122", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:chNFeRef", "lambda" => lambda{|msg,xml|
		chave_nota_referenciada_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:chNFeRef","xs" => "http://www.portalfiscal.inf.br/nfe").first
		chave_nota_referenciada_xml_tag.content = msg[:chave_nota_referenciada] if !chave_nota_referenciada_xml_tag.nil?
	}},
	{"id"=>"123", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@versao", "lambda" => lambda{|msg,xml|
		versao_evento_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
		versao_evento_xml_tag.content = msg[:versao_evento] if !versao_evento_xml_tag.nil?
	}},
	{"id"=>"124", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento", "lambda" => lambda{|msg,xml|
		descricao_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		descricao_xml_tag.content = msg[:descricao] if !descricao_xml_tag.nil?
	}},
	{"id"=>"125", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xCorrecao", "lambda" => lambda{|msg,xml|
		correcao_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xCorrecao","xs" => "http://www.portalfiscal.inf.br/nfe").first
		correcao_xml_tag.content = msg[:correcao] if !correcao_xml_tag.nil?
	}},
	{"id"=>"126", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xCondUso", "lambda" => lambda{|msg,xml|}},
	{"id"=>"127", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@versao", "lambda" => lambda{|msg,xml|
		versao_evento_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
		versao_evento_xml_tag.content = msg[:versao_evento] if !versao_evento_xml_tag.nil?
	}},
	{"id"=>"128", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento", "lambda" => lambda{|msg,xml|
		descricao_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		descricao_xml_tag.content = msg[:descricao] if !descricao_xml_tag.nil?
	}},
	{"id"=>"129", "xpath"=>"//xs:envEvsento//xs:evento//xs:infEvento//xs:detEvento//xs:xJust", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvsento//xs:evento//xs:infEvento//xs:detEvento//xs:xJust","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"130", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@versao", "lambda" => lambda{|msg,xml|
		versao_evento_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
		versao_evento_xml_tag.content = msg[:versao_evento] if !versao_evento_xml_tag.nil?
	}},
	{"id"=>"131", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento", "lambda" => lambda{|msg,xml|
		descricao_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		descricao_xml_tag.content = msg[:descricao] if !descricao_xml_tag.nil?
	}},
	{"id"=>"132", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:cOrgaoAutor", "lambda" => lambda{|msg,xml|
		codigo_orgao_autor_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:cOrgaoAutor","xs" => "http://www.portalfiscal.inf.br/nfe").first
		codigo_orgao_autor_xml_tag.content = msg[:codigo_orgao_autor] if !codigo_orgao_autor_xml_tag.nil?
	}},
	{"id"=>"133", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpAutor", "lambda" => lambda{|msg,xml|
		tipo_autor_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpAutor","xs" => "http://www.portalfiscal.inf.br/nfe").first
		tipo_autor_xml_tag.content = msg[:tipo_autor] if !tipo_autor_xml_tag.nil?
	}},
	{"id"=>"134", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:verAplic", "lambda" => lambda{|msg,xml|
		versao_aplicacao_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:verAplic","xs" => "http://www.portalfiscal.inf.br/nfe").first
		versao_aplicacao_xml_tag.content = msg[:versao_aplicacao] if !versao_aplicacao_xml_tag.nil?
	}},
	{"id"=>"135", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dhEmi", "lambda" => lambda{|msg,xml|
		dhemi_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dhEmi","xs" => "http://www.portalfiscal.inf.br/nfe").first
		dhemi_xml_tag.content = Time.now.strftime("%Y-%m-%dT%T%:z") if !dhemi_xml_tag.nil?
	}},
	{"id"=>"136", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpNF", "lambda" => lambda{|msg,xml|
		tipo_nota_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpNF","xs" => "http://www.portalfiscal.inf.br/nfe").first
		tipo_nota_xml_tag.content = msg[:tipo_nota] if !tipo_nota_xml_tag.nil?
	}},
	{"id"=>"137", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:IE", "lambda" => lambda{|msg,xml|
		inscricao_estadual_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:IE","xs" => "http://www.portalfiscal.inf.br/nfe").first
		inscricao_estadual_xml_tag.content = msg[:inscricao_estadual] if !inscricao_estadual_xml_tag.nil?
	}},
	{"id"=>"138", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest", "lambda" => lambda{|msg,xml| 
		cpf_cnpj = msg[:cpf_cnpj]
		id_estrangeiro = msg[:id_estrangeiro]

		sibling_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest//xs:UF","xs" => "http://www.portalfiscal.inf.br/nfe").first
		
		if id_estrangeiro.nil?
			if cpf_cnpj.length == 9
				child_xml_tag = Nokogiri::XML("<CPF>").elements.first

				cnpj_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest//xs:CNPJ","xs" => "http://www.portalfiscal.inf.br/nfe").first
				cnpj_xml_tag.remove if !cnpj_xml_tag.nil?

				id_estrangeiro_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest//xs:idEstrangeiro","xs" => "http://www.portalfiscal.inf.br/nfe").first
				id_estrangeiro_xml_tag.remove if !id_estrangeiro_xml_tag.nil?
			elsif cpf_cnpj.length == 11
				child_xml_tag = Nokogiri::XML("<CNPJ>").elements.first

				cpf_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest//xs:CPF","xs" => "http://www.portalfiscal.inf.br/nfe").first
				cpf_xml_tag.remove if !cpf_xml_tag.nil?

				id_estrangeiro_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest//xs:idEstrangeiro","xs" => "http://www.portalfiscal.inf.br/nfe").first
				id_estrangeiro_xml_tag.remove if !id_estrangeiro_xml_tag.nil?
			end
		else
			child_xml_tag = Nokogiri::XML("<idEstrangeiro>").elements.first

			cnpj_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest//xs:CNPJ","xs" => "http://www.portalfiscal.inf.br/nfe").first
			cnpj_xml_tag.remove if !cnpj_xml_tag.nil?

			cpf_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest//xs:CPF","xs" => "http://www.portalfiscal.inf.br/nfe").first
			cpf_xml_tag.remove if !cpf_xml_tag.nil?
		end

		sibling_xml_tag.after(child_xml_tag)
	}},
	{"id"=>"139", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest//xs:UF", "lambda" => lambda{|msg,xml|
		uf_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest//xs:UF","xs" => "http://www.portalfiscal.inf.br/nfe").first
		uf_xml_tag.content = msg[:uf] if !uf_xml_tag.nil?
	}},
	{"id"=>"140", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest//xs:CNPJ", "lambda" => lambda{|msg,xml|
		cpf_cnpj_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest//xs:CNPJ","xs" => "http://www.portalfiscal.inf.br/nfe").first
		cpf_cnpj_xml_tag.content = msg[:cpf_cnpj] if !cpf_cnpj_xml_tag.nil? and msg[:cpf_cnpj].length == 11
	}},
	{"id"=>"141", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest//xs:CPF", "lambda" => lambda{|msg,xml|
		cpf_cnpj_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest//xs:CPF","xs" => "http://www.portalfiscal.inf.br/nfe").first
		cpf_cnpj_xml_tag.content = msg[:cpf_cnpj] if !cpf_cnpj_xml_tag.nil?
	}},
	{"id"=>"142", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest//xs:idEstrangeiro", "lambda" => lambda{|msg,xml|
		id_estrangeiro_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest//xs:idEstrangeiro","xs" => "http://www.portalfiscal.inf.br/nfe").first
		id_estrangeiro_xml_tag.content = msg[:id_estrangeiro] if !id_estrangeiro_xml_tag.nil?
	}},
	{"id"=>"143", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest//xs:IE", "lambda" => lambda{|msg,xml|
		ie_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest//xs:IE","xs" => "http://www.portalfiscal.inf.br/nfe").first
		ie_xml_tag.content = msg[:ie] if !ie_xml_tag.nil?
	}},
	{"id"=>"144", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest//xs:vNF", "lambda" => lambda{|msg,xml|
		valor_total_nota_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest//xs:vNF","xs" => "http://www.portalfiscal.inf.br/nfe").first
		valor_total_nota_xml_tag.content = msg[:valor_total_nota] if !valor_total_nota_xml_tag.nil?
	}},
	{"id"=>"145", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest//xs:vICMS", "lambda" => lambda{|msg,xml|
		valor_total_icms_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest//xs:vICMS","xs" => "http://www.portalfiscal.inf.br/nfe").first
		valor_total_icms_xml_tag.content = msg[:valor_total_icms] if !valor_total_icms_xml_tag.nil?
	}},
	{"id"=>"146", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest//xs:vST", "lambda" => lambda{|msg,xml|
		valor_total_icms_substituicao_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest//xs:vST","xs" => "http://www.portalfiscal.inf.br/nfe").first
		valor_total_icms_substituicao_xml_tag.content = msg[:valor_total_icms_substituicao] if !valor_total_icms_substituicao_xml_tag.nil?
	}},
	{"id"=>"147", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@versao", "lambda" => lambda{|msg,xml|
		versao_evento_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
		versao_evento_xml_tag.content = msg[:versao_evento] if !versao_evento_xml_tag.nil?
	}},
	{"id"=>"148", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento", "lambda" => lambda{|msg,xml|
		descricao_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		descricao_xml_tag.content = msg[:descricao] if !descricao_xml_tag.nil?
	}},
	{"id"=>"149", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:nProt", "lambda" => lambda{|msg,xml|
		protocolo_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:nProt","xs" => "http://www.portalfiscal.inf.br/nfe").first
		protocolo_xml_tag.content = msg[:protocolo] if !protocolo_xml_tag.nil?
	}},
	{"id"=>"150", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:itemPedido", "lambda" => lambda{|msg,xml|
		itens_pedido = msg[:itens_pedido]
		itens_pedido_xml_tags = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:itemPedido","xs" => "http://www.portalfiscal.inf.br/nfe")
		itens_pedido_xml_tags.each{|item_pedido| item_pedido.remove }
		sibling_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:nProt","xs" => "http://www.portalfiscal.inf.br/nfe")

		itens_pedido.each do |item_pedido|
			item_pedido_xml_tag = Nokogiri::XML("<itemPedido>").elements.first
			quantidade_item_xml_tag = Nokogiri::XML("<qtdeItem>").elements.first

			item_pedido_xml_tag.add_child(quantidade_item_xml_tag)

			ultimo_item_pedido_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:itemPedido","xs" => "http://www.portalfiscal.inf.br/nfe").last
			if ultimo_item_pedido_xml_tag.nil?
				sibling_xml_tag.after(item_pedido_xml_tag)
			else
				ultimo_item_pedido_xml_tag.after(item_pedido_xml_tag)
			end
		end
	}},
	{"id"=>"151", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:itemPedido//@numItem", "lambda" => lambda{|msg,xml|
		itens_pedido = msg[:itens_pedido]

		itens_pedido.each_with_index do |item_pedido,index|
			item_pedido_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:itemPedido","xs" => "http://www.portalfiscal.inf.br/nfe")[index]
			item_pedido_xml_tag["numItem"] = msg[:numero_item] if !numero_item_xml_tag.nil?
		end
	}},
	{"id"=>"152", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:itemPedido//xs:qtdeItem", "lambda" => lambda{|msg,xml|
		itens_pedido = msg[:itens_pedido]		

		itens_pedido.each_with_index do |item_pedido,index|
			quantidade_item_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:itemPedido//xs:itemPedido//xs:qtdeItem","xs" => "http://www.portalfiscal.inf.br/nfe")[index]
			quantidade_item_xml_tag.content = msg[:quantidade_item] if !quantidade_item_xml_tag.nil?
		end
	}},
	{"id"=>"153", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@versao", "lambda" => lambda{|msg,xml|
		versao_evento_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
		versao_evento_xml_tag.content = msg[:versao_evento] if !versao_evento_xml_tag.nil?
	}},
	{"id"=>"154", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento", "lambda" => lambda{|msg,xml|
		descricao_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		descricao_xml_tag.content = msg[:descricao] if !descricao_xml_tag.nil?
	}},
	{"id"=>"155", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:cOrgaoAutor", "lambda" => lambda{|msg,xml|
		codigo_orgao_autor_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:cOrgaoAutor","xs" => "http://www.portalfiscal.inf.br/nfe").first
		codigo_orgao_autor_xml_tag.content = msg[:codigo_orgao_autor] if !codigo_orgao_autor_xml_tag.nil?
	}},
	{"id"=>"156", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpAutor", "lambda" => lambda{|msg,xml|
		tipo_autor_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpAutor","xs" => "http://www.portalfiscal.inf.br/nfe").first
		tipo_autor_xml_tag.content = msg[:tipo_autor] if !tipo_autor_xml_tag.nil?
	}},
	{"id"=>"157", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:verAplic", "lambda" => lambda{|msg,xml|
		versao_aplicacao_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:verAplic","xs" => "http://www.portalfiscal.inf.br/nfe").first
		versao_aplicacao_xml_tag.content = msg[:versao_aplicacao] if !versao_aplicacao_xml_tag.nil?
	}},
	{"id"=>"158", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:autXML", "lambda" => lambda{|msg,xml| 
		cpf_cnpj = msg[:cpf_cnpj]

		parent_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:autXML","xs" => "http://www.portalfiscal.inf.br/nfe").first

		if cpf_cnpj.length == 9
			child_xml_tag = Nokogiri::XML("<CPF>").elements.first

			cnpj_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:autXML//xs:CNPJ","xs" => "http://www.portalfiscal.inf.br/nfe").first
			cnpj_xml_tag.remove if !cnpj_xml_tag.nil?
		elsif cpf_cnpj.length == 11
			child_xml_tag = Nokogiri::XML("<CNPJ>").elements.first

			cpf_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:autXML//xs:CPF","xs" => "http://www.portalfiscal.inf.br/nfe").first
			cpf_xml_tag.remove if !cpf_xml_tag.nil?
		end

		parent_xml_tag.add_child(child_xml_tag)
	}},
	{"id"=>"159", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:autXML//xs:CNPJ", "lambda" => lambda{|msg,xml|
		cpf_cnpj_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:autXML//xs:CNPJ","xs" => "http://www.portalfiscal.inf.br/nfe").first
		cpf_cnpj_xml_tag.content = msg[:cpf_cnpj] if !cpf_cnpj_xml_tag.nil? and msg[:cpf_cnpj].length == 11
	}},
	{"id"=>"160", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:autXML//xs:CPF", "lambda" => lambda{|msg,xml|
		cpf_cnpj_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:autXML//xs:CPF","xs" => "http://www.portalfiscal.inf.br/nfe").first
		cpf_cnpj_xml_tag.content = msg[:cpf_cnpj] if !cpf_cnpj_xml_tag.nil? and msg[:cpf_cnpj].length == 9
	}},
	{"id"=>"161", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpAutorizacao", "lambda" => lambda{|msg,xml|
		tipo_autorizacao_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpAutorizacao","xs" => "http://www.portalfiscal.inf.br/nfe").first
		tipo_autorizacao_xml_tag.content = msg[:tipo_autorizacao] if !tipo_autorizacao_xml_tag.nil?
	}},
	{"id"=>"162", "xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xCondUso", "lambda" => lambda{|msg,xml|}},
	{"id"=>"163", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe", "lambda" => lambda{|msg,xml|}},
	{"id"=>"164", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//@versao", "lambda" => lambda{|msg,xml|
		versao_evento_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
		versao_evento_xml_tag.content = msg[:versao_evento] if !versao_evento_xml_tag.nil?
	}},
	{"id"=>"165", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//@Id", "lambda" => lambda{|msg,xml|}},
	{"id"=>"166", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide", "lambda" => lambda{|msg,xml|}},
	{"id"=>"167", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:cUF", "lambda" => lambda{|msg,xml|
		codigo_uf_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:cUF","xs" => "http://www.portalfiscal.inf.br/nfe").first
		codigo_uf_xml_tag.content = msg[:codigo_uf] if !codigo_uf_xml_tag.nil?
	}},
	{"id"=>"168", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:cNF", "lambda" => lambda{|msg,xml|
		codigo_numerico_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:cNF","xs" => "http://www.portalfiscal.inf.br/nfe").first
		codigo_numerico_xml_tag.content = msg[:codigo_numerico] if !codigo_numerico_xml_tag.nil?
	}},
	{"id"=>"169", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:natOp", "lambda" => lambda{|msg,xml|
		natureza_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:natOp","xs" => "http://www.portalfiscal.inf.br/nfe").first
		natureza_xml_tag.content = msg[:natureza] if !natureza_xml_tag.nil?
	}},
	{"id"=>"170", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:mod", "lambda" => lambda{|msg,xml|
		modelo_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:mod","xs" => "http://www.portalfiscal.inf.br/nfe").first
		modelo_xml_tag.content = msg[:modelo] if !modelo_xml_tag.nil?
	}},
	{"id"=>"171", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:serie", "lambda" => lambda{|msg,xml|
		serie_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:serie","xs" => "http://www.portalfiscal.inf.br/nfe").first
		serie_xml_tag.content = msg[:serie] if !serie_xml_tag.nil?
	}},
	{"id"=>"172", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:nNF", "lambda" => lambda{|msg,xml|
		numero_nota_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:nNF","xs" => "http://www.portalfiscal.inf.br/nfe").first
		numero_nota_xml_tag.content = msg[:numero_nota] if !numero_nota_xml_tag.nil?
	}},
	{"id"=>"173", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:dhEmi", "lambda" => lambda{|msg,xml|
		dhemi_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:dhEmi","xs" => "http://www.portalfiscal.inf.br/nfe").first
		dhemi_xml_tag.content = Time.now.strftime("%Y-%m-%dT%T%:z") if !dhemi_xml_tag.nil?
	}},
	{"id"=>"174", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:dhSaiEnt", "lambda" => lambda{|msg,xml|
		dhsaient_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:dhSaiEnt","xs" => "http://www.portalfiscal.inf.br/nfe").first
		dhsaient_xml_tag.content = Time.now.strftime("%Y-%m-%dT%T%:z") if !dhsaient_xml_tag.nil?
	}},
	{"id"=>"175", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:tpNF", "lambda" => lambda{|msg,xml|
		tipo_operacao_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:tpNF","xs" => "http://www.portalfiscal.inf.br/nfe").first
		tipo_operacao_xml_tag.content = msg[:tipo_operacao] if !tipo_operacao_xml_tag.nil?
	}},
	{"id"=>"176", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:idDest", "lambda" => lambda{|msg,xml|
		destino_operacao_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:idDest","xs" => "http://www.portalfiscal.inf.br/nfe").first
		
		if msg[:emissor][:uf] == msg[:destinatario][:uf]
			destino_operacao_xml_tag.content = 1 if !destino_operacao_xml_tag.nil?
		elsif  msg[:emissor][:cpais] == msg[:destinatario][:cpais]
			destino_operacao_xml_tag.content = 2 if !destino_operacao_xml_tag.nil?
		else
			destino_operacao_xml_tag.content = 3 if !destino_operacao_xml_tag.nil?
		end
	}},
	{"id"=>"177", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:cMunFG", "lambda" => lambda{|msg,xml|
		codigo_municipio_fato_gerador_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:cMunFG","xs" => "http://www.portalfiscal.inf.br/nfe").first
		codigo_municipio_fato_gerador_xml_tag.content = msg[:emissor][:codigo_municipio] if !codigo_municipio_fato_gerador_xml_tag.nil?
	}},
	{"id"=>"178", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:tpImp", "lambda" => lambda{|msg,xml|
		formato_impressao_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:tpImp","xs" => "http://www.portalfiscal.inf.br/nfe").first
		formato_impressao_xml_tag.content = 1 if !formato_impressao_xml_tag.nil?
	}},
	{"id"=>"179", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:tpEmis", "lambda" => lambda{|msg,xml|
		tipo_emissao_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:tpEmis","xs" => "http://www.portalfiscal.inf.br/nfe").first
		tipo_emissao_xml_tag.content = !msg[:justificativa_contingencia].nil? ? : 1 if !tipo_emissao_xml_tag.nil?

		if !msg[:justificativa_contingencia].nil?
			if msg[:modelo] == "55"
				tipo_emissao_xml_tag.content = !msg[:justificativa_contingencia].nil? ? : 9 if !tipo_emissao_xml_tag.nil?
			elsif msg[:modelo] == "65"
				tipo_emissao_xml_tag.content = !msg[:justificativa_contingencia].nil? ? : 9 if !tipo_emissao_xml_tag.nil?
			end
		else
			tipo_emissao_xml_tag.content = 1 if !tipo_emissao_xml_tag.nil?			
		end
	}},
	{"id"=>"180", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:cDV", "lambda" => lambda{|msg,xml|}},
	{"id"=>"181", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:tpAmb", "lambda" => lambda{|msg,xml|
		ambiente_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:tpAmb","xs" => "http://www.portalfiscal.inf.br/nfe").first
		ambiente_xml_tag.content = msg[:ambiente] if !ambiente_xml_tag.nil?
	}},
	{"id"=>"182", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:finNFe", "lambda" => lambda{|msg,xml|
		finalidade_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:finNFe","xs" => "http://www.portalfiscal.inf.br/nfe").first
		finalidade_xml_tag.content = msg[:finalidade] if !finalidade_xml_tag.nil?
	}},
	{"id"=>"183", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:indFinal", "lambda" => lambda{|msg,xml|
		consumidor_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:indFinal","xs" => "http://www.portalfiscal.inf.br/nfe").first
		consumidor_xml_tag.content = msg[:consumidor] if !consumidor_xml_tag.nil?
	}},
	{"id"=>"184", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:indPres", "lambda" => lambda{|msg,xml|
		indicador_presencial_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		indicador_presencial_xml_tag.content = msg[:indicador_presencial] if !indicador_presencial_xml_tag.nil?
	}},
	{"id"=>"186", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:procEmi", "lambda" => lambda{|msg,xml|
		processo_emissao_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:procEmi","xs" => "http://www.portalfiscal.inf.br/nfe").first
		processo_emissao_xml_tag.content = 0 if !processo_emissao_xml_tag.nil?
	}},
	{"id"=>"187", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:verProc", "lambda" => lambda{|msg,xml|
		versao_aplicacao_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:verProc","xs" => "http://www.portalfiscal.inf.br/nfe").first
		versao_aplicacao_xml_tag.content = msg[:versao_aplicacao] if !versao_aplicacao_xml_tag.nil?
	}},
	{"id"=>"188", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide", "lambda" => lambda{|msg,xml|}},
	{"id"=>"189", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:dhCont", "lambda" => lambda{|msg,xml|
		data_contingencia_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:dhCont","xs" => "http://www.portalfiscal.inf.br/nfe").first
		data_contingencia_xml_tag.content = Time.now.strftime("%Y-%m-%dT%T%:z") if !data_contingencia_xml_tag.nil?
	}},
	{"id"=>"190", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:xJust", "lambda" => lambda{|msg,xml|
		justificativa_contingencia_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:xJust","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_contingencia_xml_tag.content = msg[:justificativa_contingencia] if !justificativa_contingencia_xml_tag.nil?
	}},
	{"id"=>"191", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref", "lambda" => lambda{|msg,xml| 
		ano_mes = msg[:ano_mes_referenciado]
		cpf_cnpj = msg[:cpf_cnpj_referenciado]
		inscricao_estadual = msg[:inscricao_estadual_referenciada]
		modelo = msg[:modelo_referenciado]
		serie = msg[:serie_referenciada]
		chave_nota = msg[:chave_nota_referenciada]
		codigo_uf = msg[:codigo_uf_referenciado]
		numero_documento = msg[:numero_documento_referenciado]
		chave_cte = msg[:chave_cte]
		numero_ecf = msg[:numero_ecf]
		numero_coo = msg[:numero_coo]

		refnfe_present = !chave_nota.nil?
		refnf_present = !codigo_uf.nil? and !ano_mes.nil? and !cpf_cnpj.nil? and !modelo.nil? and !serie.nil? and !numero_documento.nil?
		refnfp_present = codigo_uf and ano_mes and cpf_cnpj and inscricao_estadual and modelo and serie and numero_documento
		refecf_present = modelo and numero_ecf and numero_coo

		parent_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref","xs" => "http://www.portalfiscal.inf.br/nfe").first

		parent_xml_tag.children.each do |child|
			child.remove
		end

		if refnfe_present
			refnfe_tag_xml = Nokogiri::XML("<refNFe>").elements.first
			parent_xml_tag.add_child(refnfe_xml_tag)
		elsif refnf_present
			refnf_xml_tag = Nokogiri::XML("<refNF>").elements.first
			parent_xml_tag.add_child(refnf_xml_tag)
		elsif refnfp_present
			refnfp_xml_tag = Nokogiri::XML("<refNFP>").elements.first
			parent_xml_tag.add_child(refnfp_xml_tag)
		elsif refcte_present
			refcte_tag_xml = Nokogiri::XML("<refCTe>").elements.first
			parent_xml_tag.add_child(refcte_xml_tag)
		elsif refecf_present
			refecf_xml_tag = Nokogiri::XML("<refECF>").elements.first
			parent_xml_tag.add_child(refecf_xml_tag)
		end
	}},
	{"id"=>"192", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNFe", "lambda" => lambda{|msg,xml|}},
	{"id"=>"193", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNF", "lambda" => lambda{|msg,xml|}},
	{"id"=>"194", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNF//xs:cUF", "lambda" => lambda{|msg,xml|
		codigo_uf_referenciado_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNF//xs:cUF").first
		codigo_uf_referenciado_xml_tag.content = msg[:codigo_uf_referenciado] if !codigo_uf_referenciado_xml_tag.nil?
	}},
	{"id"=>"195", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNF//xs:AAMM", "lambda" => lambda{|msg,xml|
		ano_mes_referenciado_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNF//xs:AAMM","xs" => "http://www.portalfiscal.inf.br/nfe").first
		ano_mes_referenciado_xml_tag.content = msg[:ano_mes_referenciado] if !ano_mes_referenciado_xml_tag.nil?
	}},
	{"id"=>"196", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNF//xs:CNPJ", "lambda" => lambda{|msg,xml|
		cpf_cnpj_referenciado_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNF//xs:CNPJ","xs" => "http://www.portalfiscal.inf.br/nfe").first
		cpf_cnpj_referenciado_xml_tag.content = msg[:cpf_cnpj_referenciado] if !cpf_cnpj_referenciado_xml_tag.nil? and msg[:cpf_cnpj_referenciado].length == 11
	}},
	{"id"=>"197", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNF//xs:mod", "lambda" => lambda{|msg,xml|
		modelo_referenciado_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNF//xs:mod","xs" => "http://www.portalfiscal.inf.br/nfe").first
		modelo_referenciado_xml_tag.content = msg[:modelo_referenciado] if !modelo_referenciado_xml_tag.nil?
	}},
	{"id"=>"198", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNF//xs:serie", "lambda" => lambda{|msg,xml|
		serie_referenciada_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNF//xs:serie","xs" => "http://www.portalfiscal.inf.br/nfe").first
		serie_referenciada_xml_tag.content = msg[:serie_referenciada] if !serie_referenciada_xml_tag.nil?
	}},
	{"id"=>"199", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNF//xs:nNF", "lambda" => lambda{|msg,xml|
		numero_documento_referenciado_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNF//xs:nNF","xs" => "http://www.portalfiscal.inf.br/nfe").first
		numero_documento_referenciado_xml_tag.content = msg[:numero_documento_referenciado] if !numero_documento_referenciado_xml_tag.nil?
	}},
	{"id"=>"200", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNFP", "lambda" => lambda{|msg,xml|
		cpf_cnpj = msg[:cpf_cnpj_referenciado]

		parent_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNFP","xs" => "http://www.portalfiscal.inf.br/nfe").first

		if !cpf_cnpj.nil?
			codigo_uf_xml_tag = Nokogiri::XML("<cUF>").elements.first
			ano_mes_xml_tag = Nokogiri::XML("<AAMM>").elements.first
			inscricao_estadual_xml_tag = Nokogiri::XML("<IE>").elements.first
			modelo_xml_tag = Nokogiri::XML("<mod>").elements.first
			serie_xml_tag = Nokogiri::XML("<serie>").elements.first
			numero_documento_xml_tag = Nokogiri::XML("<nNF>").elements.first

			if cpf_cnpj.length == 11
				cpf_cnpj_xml_tag = Nokogiri::XML("<CNPJ>").elements.first
			elsif cpf_cnpj.length == 9
				cpf_cnpj_xml_tag = Nokogiri::XML("<CPF>").elements.first
			end
			
			parent_xml_tag.add_child(codigo_uf_xml_tag)
			parent_xml_tag.add_child(ano_mes_xml_tag)
			parent_xml_tag.add_child(cpf_cnpj_xml_tag)
			parent_xml_tag.add_child(inscricao_estadual_xml_tag)
			parent_xml_tag.add_child(modelo_xml_tag)
			parent_xml_tag.add_child(serie_xml_tag)
			parent_xml_tag.add_child(numero_documento_xml_tag)
		end
	}},
	{"id"=>"201", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNFP//xs:cUF", "lambda" => lambda{|msg,xml|
		codigo_uf_referenciado_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNFP//xs:cUF","xs" => "http://www.portalfiscal.inf.br/nfe").first
		codigo_uf_referenciado_xml_tag.content = msg[:codigo_uf_referenciado] if !codigo_uf_referenciado_xml_tag.nil?
	}},
	# PAREI AQUI !!!
	{"id"=>"202", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNFP//xs:AAMM", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"203", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNFP//xs:CNPJ", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"204", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNFP//xs:CPF", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"205", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNFP//xs:IE", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"206", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNFP//xs:mod", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"207", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNFP//xs:serie", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"208", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNFP//xs:nNF", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"209", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNFP//xs:refCTe", "lambda" => lambda{|msg,xml|}},
	{"id"=>"210", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refECF", "lambda" => lambda{|msg,xml|}},
	{"id"=>"211", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refECF//xs:mod", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"212", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refECF//xs:nECF", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"213", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refECF//xs:nCOO", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"214", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit", "lambda" => lambda{|msg,xml| 
		cpf_cnpj = msg[:emissor][:cpf_cnpj]

		sibling_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:xNome","xs" => "http://www.portalfiscal.inf.br/nfe").first
		
		if cpf_cnpj.length == 9
			child_xml_tag = Nokogiri::XML("<CPF>").elements.first
			cnpj_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:CNPJ","xs" => "http://www.portalfiscal.inf.br/nfe").first
			cnpj_xml_tag.remove if !cnpj_xml_tag.nil?
		elsif cpf_cnpj.length == 11
			child_xml_tag = Nokogiri::XML("<CNPJ>").elements.first
			cpf_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:CNPJ","xs" => "http://www.portalfiscal.inf.br/nfe").first
			cpf_xml_tag.remove if !cpf_xml_tag.nil?
		end

		sibling_xml_tag.before(child_xml_tag)
	}},
	{"id"=>"215", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:CNPJ", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"216", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:CPF", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"217", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:xNome", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"218", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:xFant", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"219", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:enderEmit", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"220", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:enderEmit//xs:xLgr", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"221", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:enderEmit//xs:nro", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"222", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:enderEmit//xs:xCpl", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"223", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:enderEmit//xs:xBairro", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"224", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:enderEmit//xs:cMun", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"225", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:enderEmit//xs:xMun", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"226", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:enderEmit//xs:UF", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"227", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:enderEmit//xs:CEP", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"228", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:enderEmit//xs:cPais", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"229", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:enderEmit//xs:xPais", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"230", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:enderEmit//xs:fone", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"231", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:IE", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"232", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:IEST", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"233", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"234", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:IM", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"235", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:CNAE", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"236", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:CRT", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"237", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:avulsa", "lambda" => lambda{|msg,xml|}},
	{"id"=>"238", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:avulsa//xs:CNPJ", "lambda" => lambda{|msg,xml|}},
	{"id"=>"239", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:avulsa//xs:xOrgao", "lambda" => lambda{|msg,xml|}},
	{"id"=>"240", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:avulsa//xs:matr", "lambda" => lambda{|msg,xml|}},
	{"id"=>"241", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:avulsa//xs:xAgente", "lambda" => lambda{|msg,xml|}},
	{"id"=>"242", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:avulsa//xs:fone", "lambda" => lambda{|msg,xml|}},
	{"id"=>"243", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:avulsa//xs:UF", "lambda" => lambda{|msg,xml|}},
	{"id"=>"244", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:avulsa//xs:nDAR", "lambda" => lambda{|msg,xml|}},
	{"id"=>"245", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:avulsa//xs:dEmi", "lambda" => lambda{|msg,xml|}},
	{"id"=>"246", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:avulsa//xs:vDAR", "lambda" => lambda{|msg,xml|}},
	{"id"=>"247", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:avulsa//xs:repEmi", "lambda" => lambda{|msg,xml|}},
	{"id"=>"248", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:avulsa//xs:dPag", "lambda" => lambda{|msg,xml|}},
	{"id"=>"249", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest", "lambda" => lambda{|msg,xml| 
		cpf_cnpj = msg[:destinatario][:cpf_cnpj]
		id_estrangeiro = msg[:destinatario][:id_estrangeiro]

		sibling_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:xNome","xs" => "http://www.portalfiscal.inf.br/nfe").first
		
		if id_estrangeiro.nil?
			if cpf_cnpj.length == 9
				child_xml_tag = Nokogiri::XML("<CPF>").elements.first

				cnpj_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:CNPJ","xs" => "http://www.portalfiscal.inf.br/nfe").first
				cnpj_xml_tag.remove if !cnpj_xml_tag.nil?

				id_estrangeiro_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:idEstrangeiro","xs" => "http://www.portalfiscal.inf.br/nfe").first
				id_estrangeiro_xml_tag.remove if !id_estrangeiro_xml_tag.nil?
			elsif cpf_cnpj.length == 11
				child_xml_tag = Nokogiri::XML("<CNPJ>").elements.first

				cpf_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:CPF","xs" => "http://www.portalfiscal.inf.br/nfe").first
				cpf_xml_tag.remove if !cpf_xml_tag.nil?

				id_estrangeiro_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:idEstrangeiro","xs" => "http://www.portalfiscal.inf.br/nfe").first
				id_estrangeiro_xml_tag.remove if !id_estrangeiro_xml_tag.nil?
			end
		else
			child_xml_tag = Nokogiri::XML("<idEstrangeiro>").elements.first

			cnpj_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:CNPJ","xs" => "http://www.portalfiscal.inf.br/nfe").first
			cnpj_xml_tag.remove if !cnpj_xml_tag.nil?

			cpf_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:CPF","xs" => "http://www.portalfiscal.inf.br/nfe").first
			cpf_xml_tag.remove if !cpf_xml_tag.nil?
		end

		sibling_xml_tag.before(child)
	}},
	{"id"=>"250", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:CNPJ", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"251", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:CPF", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"252", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:idEstrangeiro", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"253", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:xNome", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"254", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:enderDest", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"255", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:enderDest//xs:xLgr", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"256", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:enderDest//xs:nro", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"257", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:enderDest//xs:xCpl", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"258", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:enderDest//xs:xBairro", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"259", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:enderDest//xs:cMun", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"260", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:enderDest//xs:xMun", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"261", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:enderDest//xs:UF", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"262", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:enderDest//xs:CEP", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"263", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:enderDest//xs:cPais", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"264", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:enderDest//xs:xPais", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"265", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:enderDest//xs:fone", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"266", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:indIEDest", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"267", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:IE", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"268", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:ISUF", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"269", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:IM", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"270", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:email", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"271", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:retirada", "lambda" => lambda{|msg,xml| 
		retirada = msg[:retirada]

		if !retirada.nil?
			cpf_cnpj = retirada[:cpf_cnpj]

			sibling_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:retirada//xs:xNome","xs" => "http://www.portalfiscal.inf.br/nfe").first
			
			if cpf_cnpj.length == 9
				child_xml_tag = Nokogiri::XML("<CPF>").elements.first
				cnpj_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:retirada//xs:CNPJ","xs" => "http://www.portalfiscal.inf.br/nfe").first
				cnpj_xml_tag.remove if !cnpj_xml_tag.nil?
			elsif cpf_cnpj.length == 11
				child_xml_tag = Nokogiri::XML("<CNPJ>").elements.first
				cpf_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:retirada//xs:CPF","xs" => "http://www.portalfiscal.inf.br/nfe").first
				cpf_xml_tag.remove if !cpf_xml_tag.nil?
			end

			sibling_xml_tag.before(child_xml_tag)
		end
	}},
	{"id"=>"272", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:retirada//xs:CNPJ", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"273", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:retirada//xs:CPF", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"275", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:retirada//xs:xLgr", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"276", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:retirada//xs:nro", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"277", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:retirada//xs:xCpl", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"278", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:retirada//xs:xBairro", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"279", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:retirada//xs:cMun", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"280", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:retirada//xs:xMun", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"281", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:retirada//xs:UF", "lambda" => lambda{|msg,xml|}},
	{"id"=>"288", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:entrega", "lambda" => lambda{|msg,xml|
		entrega = msg[:entrega]

		if !entrega.nil?
			cpf_cnpj = entrega[:cpf_cnpj]
			
			sibling_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:entrega//xs:xNome","xs" => "http://www.portalfiscal.inf.br/nfe").first

			if cpf_cnpj.length == 9
				child_xml_tag = Nokogiri::XML("<CPF>").elements.first
				cnpj_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:entrega//xs:CNPJ","xs" => "http://www.portalfiscal.inf.br/nfe").first
				cnpj_xml_tag.remove if !cnpj_xml_tag.nil?
			elsif cpf_cnpj.length == 11
				child_xml_tag = Nokogiri::XML("<CNPJ>").elements.first
				cpf_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:entrega//xs:xNome","xs" => "http://www.portalfiscal.inf.br/nfe").first
				cpf_xml_tag.remove if !cpf_xml_tag.nil?
			end

			sibling_xml_tag.add_child(child_xml_tag)
		end
	}},
	{"id"=>"289", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:entrega//xs:CNPJ", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"290", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:entrega//xs:CPF", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"292", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:entrega//xs:xLgr", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"293", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:entrega//xs:nro", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"294", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:entrega//xs:xCpl", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"295", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:entrega//xs:xBairro", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"296", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:entrega//xs:cMun", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"297", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:entrega//xs:xMun", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"298", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:entrega//xs:UF", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"305", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:autXML", "lambda" => lambda{|msg,xml|
		autorizacoes = msg[:autorizacoes]

		if !autorizacoes.nil?

			autorizacoes_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:autXML","xs" => "http://www.portalfiscal.inf.br/nfe")
			autorizacoes_xml_tags.each do |autorizacao_xml_tag|
				autorizacao_xml_tag.remove
			end

			sibling_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det","xs" => "http://www.portalfiscal.inf.br/nfe").first
			
			autorizacoes.each do |autorizacao|
				cpf_cnpj = autorizacao[:cpf_cnpj]

				autorizacao_xml_tag = Nokogiri::XML("<autXML>").elements.first

				if cpf_cnpj.length == 9
					child_xml_tag = Nokogiri::XML("<CPF>").elements.first
				elsif cpf_cnpj.length == 11
					child_xml_tag = Nokogiri::XML("<CNPJ>").elements.first
				end

				autorizacao_xml_tag.add_child(child_xml_tag)
				sibling_xml_tag.before(autorizacao_xml_tag)
			end
		end
	}},
	{"id"=>"306", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:entrega//xs:IE//xs:CNPJ", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"307", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:autXML//xs:CPF", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"308", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"309", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//@nItem", "lambda" => lambda{|msg,xml|
		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
		justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
	}},
	{"id"=>"310", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		produtos_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det","xs"=>"http://www.portalfiscal.inf.br/nfe")
		produtos_xml_tags.each{|produto| produto.remove }

		produtos.each_with_index do |produto,index|
			nves = produto[:nves]
			importacoes = produto[:importacoes]
			exportacoes = produto[:exportacoes]
			rastreamento = produto[:rastreamento]
			veiculos = produto[:veiculos]
			medicamentos = produto[:medicamentos]
			armas = produto[:armas]
			combustiveis = produto[:combustiveis]
			papel = produto[:papel]

			codigo_produto_xml_tag = Nokogiri::XML("<cProd>").elements.first
			codigo_ean_xml_tag = Nokogiri::XML("<cEAN>").elements.first
			descricao_produto_xml_tag = Nokogiri::XML("<xProd>").elements.first
			ncm_xml_tag = Nokogiri::XML("<NCM>").elements.first
			nves_xml_tag = Nokogiri::XML("<NVE>").elements.first
			cest_xml_tag = Nokogiri::XML("<CEST>").elements.first
			indicador_escala_xml_tag = Nokogiri::XML("<indEscala>").elements.first
			cnpj_fabricante_xml_tag = Nokogiri::XML("<CNPJFab>").elements.first
			codigo_beneficiario_xml_tag = Nokogiri::XML("<cBenef>").elements.first
			extipi_xml_tag = Nokogiri::XML("<EXTIPI>").elements.first
			cfop_xml_tag = Nokogiri::XML("<CFOP>").elements.first
			unidade_comercial_xml_tag = Nokogiri::XML("<uCom>").elements.first
			quantidade_xml_tag = Nokogiri::XML("<qCom>").elements.first
			preco_xml_tag = Nokogiri::XML("<vUnCom>").elements.first
			valor_produto_xml_tag = Nokogiri::XML("<vProd>").elements.first 
			codigo_ean_tributo_xml_tag = Nokogiri::XML("<cEANTrib>").elements.first
			unidade_tributada_xml_tag = Nokogiri::XML("<uTrib>").elements.first
			quantidade_tributada_xml_tag = Nokogiri::XML("<qTrib>").elements.first
			preco_tributado_xml_tag = Nokogiri::XML("<vUnTrib>").elements.first
			valor_frete_xml_tag = Nokogiri::XML("<vFrete>").elements.first
			valor_seguro_xml_tag = Nokogiri::XML("<vSeg>").elements.first
			valor_desconto_xml_tag = Nokogiri::XML("<vDesc>").elements.first
			valor_outro_xml_tag = Nokogiri::XML("<vOutro>").elements.first
			indicador_total_xml_tag = Nokogiri::XML("<indTot>").elements.first
			numero_pedido_xml_tag = Nokogiri::XML("<xPed>").elements.first
			numero_item_pedido_xml_tag = Nokogiri::XML("<nItemPed>").elements.first
			numero_fci_xml_tag = Nokogiri::XML("<nFCI>").elements.first

			ultimo_produto = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det","xs"=>"http://www.portalfiscal.inf.br/nfe").last
			det_xml_tag = Nokogiri::XML("<det>").elements.first 
			prod_xml_tag = Nokogiri::XML("<prod>").elements.first
			imposto_xml_tag = Nokogiri::XML("<imposto>").elements.first
			imposto_devol_xml_tag = Nokogiri::XML("<impostoDevol>").elements.first
			infadprod_xml_tag = Nokogiri::XML("<infAdProd>").elements.first
			grand_prod_xml_tag["nItem"] = index+1
			total = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:total","xs" => "http://www.portalfiscal.inf.br/nfe").first
			
			prod_xml_tag.add_child(codigo_produto_xml_tag)
			prod_xml_tag.add_child(codigo_ean_xml_tag)
			prod_xml_tag.add_child(descricao_produto_xml_tag)
			prod_xml_tag.add_child(ncm_xml_tag)
			
			nves.each do |nve|
				nve_xml_tag = Nokogiri::XML("<NVE>").elements.first
				prod_xml_tag.add_child(nve_xml_tag)
			end

			prod_xml_tag.add_child(cest_xml_tag)
			prod_xml_tag.add_child(indicador_escala_xml_tag)
			prod_xml_tag.add_child(cnpj_fabricante_xml_tag)
			prod_xml_tag.add_child(codigo_beneficiario_xml_tag)
			prod_xml_tag.add_child(extipi_xml_tag)
			prod_xml_tag.add_child(cfop_xml_tag)
			prod_xml_tag.add_child(unidade_comercial_xml_tag)
			prod_xml_tag.add_child(quantidade_xml_tag)
			prod_xml_tag.add_child(preco_xml_tag)
			prod_xml_tag.add_child(valor_produto_xml_tag)
			prod_xml_tag.add_child(codigo_ean_tributo_xml_tag)
			prod_xml_tag.add_child(unidade_tributada_xml_tag)
			prod_xml_tag.add_child(quantidade_tributada_xml_tag)
			prod_xml_tag.add_child(preco_tributado_xml_tag)
			prod_xml_tag.add_child(valor_frete_xml_tag)
			prod_xml_tag.add_child(valor_seguro_xml_tag)
			prod_xml_tag.add_child(valor_desconto_xml_tag)
			prod_xml_tag.add_child(valor_outro_xml_tag)
			prod_xml_tag.add_child(indicador_total_xml_tag)

			importacoes.each do |importacao|
				importacao_xml_tag = Nokogiri::XML("<DI>").elements.first
				numero_documento_xml_tag = Nokogiri::XML("<nDi>").elements.first
				data_registro_documento_xml_tag = Nokogiri::XML("<dDI>").elements.first
				local_desembaraco_xml_tag = Nokogiri::XML("<xLocDesemb>").elements.first
				uf_desembaraco_xml_tag = Nokogiri::XML("<UFDesemb>").elements.first
				data_desembaraco_xml_tag = Nokogiri::XML("<dDesemb>").elements.first
				tipo_transporte_xml_tag = Nokogiri::XML("<tpViaTransp>").elements.first
				valor_afrmm_xml_tag = Nokogiri::XML("<vAFRMM>").elements.first
				tipo_intermedio_xml_tag = Nokogiri::XML("<tpIntermedio>").elements.first
				cnpj_xml_tag = Nokogiri::XML("<CNPJ>").elements.first
				uf_terceiro_xml_tag = Nokogiri::XML("<UFTerceiro>").elements.first
				codigo_exportador_xml_tag = Nokogiri::XML("<cExportador>").elements.first

				importacao_xml_tag.add_child(numero_documento_xml_tag)
				importacao_xml_tag.add_child(data_registro_documento_xml_tag)
				importacao_xml_tag.add_child(local_desembaraco_xml_tag)
				importacao_xml_tag.add_child(uf_desembaraco_xml_tag)
				importacao_xml_tag.add_child(data_desembaraco_xml_tag)
				importacao_xml_tag.add_child(tipo_transporte_xml_tag)
				importacao_xml_tag.add_child(valor_afrmm_xml_tag)
				importacao_xml_tag.add_child(tipo_intermedio_xml_tag)
				importacao_xml_tag.add_child(cnpj_xml_tag)
				importacao_xml_tag.add_child(uf_terceiro_xml_tag)
				importacao_xml_tag.add_child(codigo_exportador_xml_tag)

				adicoes.each do |adicao|
					adicao_xml_tag = Nokogiri::XML("<adi>").elements.first
					numero_adicao_xml_tag = Nokogiri::XML("<nAdicao>").elements.first
					numero_sequencial_adicao_xml_tag = Nokogiri::XML("<nSeqAdic>").elements.first
					codigo_fabricante_xml_tag = Nokogiri::XML("<cFabricante>").elements.first
					valor_desconto_xml_tag = Nokogiri::XML("<vDescDI>").elements.first
					numero_drawback_xml_tag = Nokogiri::XML("<nDraw>").elements.first

					adicao_xml_tag.add_child(numero_adicao_xml_tag)
					adicao_xml_tag.add_child(numero_sequencial_adicao_xml_tag)
					adicao_xml_tag.add_child(codigo_fabricante_xml_tag)
					adicao_xml_tag.add_child(valor_desconto_xml_tag)
					adicao_xml_tag.add_child(numero_drawback_xml_tag)

					importacao_xml_tag.add_child(adicao_xml_tag)
				end

				prod_xml_tag.add_child(importacao_xml_tag)
			end

			exportacoes.each do |exportacao|
				exportacao_xml_tag = Nokogiri::XML("<detExport>").elements.first
				numero_drawback_xml_tag = Nokogiri::XML("<nDraw>").elements.first
				grupo_exportind_xml_tag = Nokogiri::XML("<exportInd>").elements.first
				numero_registro_exportacao_xml_tag = Nokogiri::XML("<nRE>").elements.first
				chave_nota_xml_tag = Nokogiri::XML("<chNFe>").elements.first
				quantidade_xml_tag = Nokogiri::XML("<qExport>").elements.first

				grupo_exportind_xml_tag.add_child(numero_registro_exportacao_xml_tag)
				grupo_exportind_xml_tag.add_child(chave_nota_xml_tag)
				grupo_exportind_xml_tag.add_child(quantidade_xml_tag)

				exportacao_xml_tag.add_child(numero_drawback_xml_tag)
				exportacao_xml_tag.add_child(grupo_exportind_xml_tag)

				prod_xml_tag.add_child(exportacao_xml_tag)
			end
			
			rastreamento.each do |rastro|
				rastreio_xml_tag = Nokogiri::XML("<rastro>").elements.first
				lote_xml_tag = Nokogiri::XML("<nLote>").elements.first
				quantidade_xml_tag = Nokogiri::XML("<>").elements.first
				fabricacao_xml_tag = Nokogiri::XML("<qExport>").elements.first
				validade_xml_tag = Nokogiri::XML("<qExport>").elements.first
				codigo_agregacao_xml_tag = Nokogiri::XML("<qExport>").elements.first

				rastreio_xml_tag.add_child(lote_xml_tag)
				rastreio_xml_tag.add_child(quantidade_xml_tag)
				rastreio_xml_tag.add_child(fabricacao_xml_tag)
				rastreio_xml_tag.add_child(validade_xml_tag)
				rastreio_xml_tag.add_child(codigo_agregacao_xml_tag)

				prod_xml_tag.add_child(rastreio_xml_tag)
			end

			prod_xml_tag.add_child(numero_pedido_xml_tag)
			prod_xml_tag.add_child(numero_item_pedido_xml_tag)
			prod_xml_tag.add_child(numero_fci_xml_tag)

			if !veiculos.nil?
				veiculos_xml_tag = Nokogiri::XML("<veicProd>").elements.first
				tipo_operacao_xml_tag = Nokogiri::XML("<tpOp>").elements.first
				chassi_xml_tag = Nokogiri::XML("<chassi>").elements.first
				codigo_cor_xml_tag = Nokogiri::XML("<cCor>").elements.first
				descricao_cor_xml_tag = Nokogiri::XML("<xCor>").elements.first
				potencia_xml_tag = Nokogiri::XML("<pot>").elements.first
				cilindradas_xml_tag = Nokogiri::XML("<cilin>").elements.first
				peso_liquido_xml_tag = Nokogiri::XML("<pesoL>").elements.first
				peso_bruto_xml_tag = Nokogiri::XML("<pesoB>").elements.first
				serie_xml_tag = Nokogiri::XML("<nSerie>").elements.first
				tipo_combustivel_xml_tag = Nokogiri::XML("<tpComb>").elements.first
				numero_motor_xml_tag = Nokogiri::XML("<nMotor>").elements.first
				capacidade_maxima_tracao_xml_tag = Nokogiri::XML("<CMT>").elements.first
				distancia_eixos_xml_tag = Nokogiri::XML("<dist>").elements.first
				ano_modelo_xml_tag = Nokogiri::XML("<anoMod>").elements.first
				ano_fabricante_xml_tag = Nokogiri::XML("<anoFab>").elements.first
				tipo_pintura_xml_tag = Nokogiri::XML("<tpPint>").elements.first
				tipo_veiculo_xml_tag = Nokogiri::XML("<tpVeic>").elements.first
				especie_veiculo_xml_tag = Nokogiri::XML("<espVeic>").elements.first
				condicao_vin_xml_tag = Nokogiri::XML("<VIN>").elements.first
				condicao_veiculo_xml_tag = Nokogiri::XML("<condVeic>").elements.first
				codigo_marca_modelo_xml_tag = Nokogiri::XML("<cMod>").elements.first
				codigo_cor_denatran_xml_tag = Nokogiri::XML("<cCorDENATRAN>").elements.first
				lotacao_xml_tag = Nokogiri::XML("<lota>").elements.first
				restricao_xml_tag = Nokogiri::XML("<tpRest>").elements.first

				veiculos_xml_tag.add_child(tipo_operacao_xml_tag)
				veiculos_xml_tag.add_child(chassi_xml_tag)
				veiculos_xml_tag.add_child(codigo_cor_xml_tag)
				veiculos_xml_tag.add_child(descricao_cor_xml_tag)
				veiculos_xml_tag.add_child(potencia_xml_tag)
				veiculos_xml_tag.add_child(cilindradas_xml_tag)
				veiculos_xml_tag.add_child(peso_liquido_xml_tag)
				veiculos_xml_tag.add_child(peso_bruto_xml_tag)
				veiculos_xml_tag.add_child(serie_xml_tag)
				veiculos_xml_tag.add_child(tipo_combustivel_xml_tag)
				veiculos_xml_tag.add_child(numero_motor_xml_tag)
				veiculos_xml_tag.add_child(capacidade_maxima_tracao_xml_tag)
				veiculos_xml_tag.add_child(distancia_eixos_xml_tag)
				veiculos_xml_tag.add_child(ano_modelo_xml_tag)
				veiculos_xml_tag.add_child(ano_fabricante_xml_tag)
				veiculos_xml_tag.add_child(tipo_pintura_xml_tag)
				veiculos_xml_tag.add_child(tipo_veiculo_xml_tag)
				veiculos_xml_tag.add_child(especie_veiculo_xml_tag)
				veiculos_xml_tag.add_child(condicao_vin_xml_tag)
				veiculos_xml_tag.add_child(condicao_veiculo_xml_tag)
				veiculos_xml_tag.add_child(codigo_marca_modelo_xml_tag)
				veiculos_xml_tag.add_child(codigo_cor_denatran_xml_tag)
				veiculos_xml_tag.add_child(lotacao_xml_tag)
				veiculos_xml_tag.add_child(restricao_xml_tag)

				prod_xml_tag.add_child(veiculos_xml_tag)
			elsif !medicamentos.nil?
				medicamentos_xml_tag = Nokogiri::XML("<med>").elements.first
				codigo_produto_anvisa_xml_tag = Nokogiri::XML("<cProdANVISA>").elements.first
				motivo_isencao_xml_tag = Nokogiri::XML("<xMotivoIsencao>").elements.first
				preco_maximo_consumidor_xml_tag = Nokogiri::XML("<vPMC>").elements.first

				medicamentos_xml_tag.add_child(codigo_produto_anvisa_xml_tag)
				medicamentos_xml_tag.add_child(motivo_isencao_xml_tag)
				medicamentos_xml_tag.add_child(preco_maximo_consumidor_xml_tag)

				prod_xml_tag.add_child(medicamentos_xml_tag)
			elsif !armas.nil?
				armas_xml_tag = Nokogiri::XML("<arma>").elements.first
				tipo_arma_xml_tag = Nokogiri::XML("<tpArma>").elements.first
				numero_serie_xml_tag = Nokogiri::XML("<nSerie>").elements.first
				numero_cano_xml_tag = Nokogiri::XML("<nCano>").elements.first
				descricao_xml_tag = Nokogiri::XML("<descr>").elements.first

				armas_xml_tag.add_child(tipo_arma_xml_tag)
				armas_xml_tag.add_child(numero_serie_xml_tag)
				armas_xml_tag.add_child(numero_cano_xml_tag)
				armas_xml_tag.add_child(descricao_xml_tag)

				prod_xml_tag.add_child(armas_xml_tag)
			elsif !combustiveis.nil?
				combustiveis_xml_tag = Nokogiri::XML("<comb>").elements.first
				codigo_produto_anp_xml_tag  = Nokogiri::XML("<cProdANP>").elements.first
				descricao_anp_xml_tag  = Nokogiri::XML("<descANP>").elements.first
				percentual_glp_xml_tag  = Nokogiri::XML("<pGLP>").elements.first
				percentual_gnv_xml_tag  = Nokogiri::XML("<pGNn>").elements.first
				percentual_gni_xml_tag  = Nokogiri::XML("<pGNi>").elements.first
				valor_partida_xml_tag  = Nokogiri::XML("<vPart>").elements.first
				codif_xml_tag  = Nokogiri::XML("<CODIF>").elements.first
				quantidade_temperatura_ambiente_xml_tag  = Nokogiri::XML("<qTemp>").elements.first
				uf_consumo_xml_tag  = Nokogiri::XML("<UFCons>").elements.first
				grupo_cide_xml_tag  = Nokogiri::XML("<CIDE>").elements.first
				quantidade_cide_xml_tag  = Nokogiri::XML("<qBCProd>").elements.first
				aliquota_cide_xml_tag  = Nokogiri::XML("<vAliqProd>").elements.first
				valor_cide_xml_tag = Nokogiri::XML("vCIDE").elements.first
				grupo_encerrante_xml_tag  = Nokogiri::XML("<encerrante>").elements.first
				numero_bico_xml_tag  = Nokogiri::XML("<nBico>").elements.first
				numero_bomba_xml_tag  = Nokogiri::XML("<nBomba>").elements.first
				numero_tanque_xml_tag  = Nokogiri::XML("<nTanque>").elements.first
				valor_encerrante_inicio_xml_tag  = Nokogiri::XML("<vEncIni>").elements.first
				valor_encerrante_fim_xml_tag  = Nokogiri::XML("<vEncFin>").elements.first

				grupo_cide_xml_tag.add_child(quantidade_cide_xml_tag)
				grupo_cide_xml_tag.add_child(aliquota_cide_xml_tag)
				grupo_cide_xml_tag.add_child(valor_cide_xml_tag)

				grupo_encerrante_xml_tag.add_child(numero_bico_xml_tag)
				grupo_encerrante_xml_tag.add_child(numero_bomba_xml_tag)
				grupo_encerrante_xml_tag.add_child(numero_tanque_xml_tag)
				grupo_encerrante_xml_tag.add_child(valor_encerrante_inicio)
				grupo_encerrante_xml_tag.add_child(valor_encerrante_fim)

				combustiveis_xml_tag.add_child(codigo_produto_anp_xml_tag)
				combustiveis_xml_tag.add_child(descricao_anp_xml_tag)
				combustiveis_xml_tag.add_child(percentual_glp_xml_tag)
				combustiveis_xml_tag.add_child(percentual_gnv_xml_tag)
				combustiveis_xml_tag.add_child(percentual_gni_xml_tag)
				combustiveis_xml_tag.add_child(valor_partida)
				combustiveis_xml_tag.add_child(codif)
				combustiveis_xml_tag.add_child(quantidade_temperatura_ambiente)
				combustiveis_xml_tag.add_child(uf_consumo)
				combustiveis_xml_tag.add_child(grupo_cide_xml_tag)
				combustiveis_xml_tag.add_child(grupo_encerrante_xml_tag)

				prod_xml_tag.add_child(combustiveis_xml_tag)
			elsif !papel.nil?
				papel_xml_tag = Nokogiri::XML("<nRECOPI>").elements.first
				prod_xml_tag.add_child(papel_xml_tag)
			end

			vtot_trib_xml_tag = Nokogiri::XML("<vTotTrib>").elements.first
			pis_xml_tag = Nokogiri::XML("<PIS>").elements.first
			pisst_xml_tag = Nokogiri::XML("<PISST>").elements.first
			vpis_xml_tag = Nokogiri::XML("<vPIS>").elements.first
			cofins_xml_tag = Nokogiri::XML("<COFINS>").elements.first]
			cofinsst_xml_tag = Nokogiri::XML("<COFINSST>").elements.first
			vcofins_xml_tag = Nokogiri::XML("<vCOFINS>").elements.first
			icmsufdest_xml_tag = Nokogiri::XML("<ICMSUFDest>").elements.first
			vbcufdest_xml_tag = Nokogiri::XML("<vBCUFDEST>").elements.first
			vbcfcpufdest_xml_tag = Nokogiri::XML("<vBCFCPUPDest>").elements.first
			pfcpufdest_xml_tag = Nokogiri::XML("<pFCPUFDest>").elements.first
			picmsufdest_xml_tag = Nokogiri::XML("<pICMSUFDest>").elements.first
			picmsinter_xml_tag = Nokogiri::XML("<pICMSInter>").elements.first
			picmsinterpart_xml_tag = Nokogiri::XML("<pICMSInterPart>").elements.first
			vfcpufdest_xml_tag = Nokogiri::XML("<vFCPUFDest>").elements.first
			vicmsufdest_xml_tag = Nokogiri::XML("<vICMSUFDest>").elements.first
			vicmsufremet_xml_tag = Nokogiri::XML("<vICMSUFRemet>").elements.first
			pdevol_xml_tag = Nokogiri::XML("<pDevol>").elements.first
			ipi_devol_xml_tag = Nokogiri::XML("<IPI>").elements.first
			vipi_devol_xml_tag = Nokogiri::XML("<vIPIDevol>").elements.first
			infadprod_xml_tag = Nokogiri::XML("<infAdProd>").elements.first

			pisst_xml_tag.add_child(vpis_xml_tag)
			cofinsst_xml_tag.add_child(vcofins_xml)
			icmsufdest_xml_tag.add_child(vbcufdest_xml_tag)
			icmsufdest_xml_tag.add_child(vbcfcpufdest_xml_tag)
			icmsufdest_xml_tag.add_child(pfcpufdest_xml_tag)
			icmsufdest_xml_tag.add_child(picmsufdest_xml_tag)
			icmsufdest_xml_tag.add_child(picmsinter_xml_tag)
			icmsufdest_xml_tag.add_child(picmsinterpart_xml_tag)
			icmsufdest_xml_tag.add_child(vfcpufdest_xml_tag)
			icmsufdest_xml_tag.add_child(vicmsufdest_xml_tag)
			icmsufdest_xml_tag.add_child(vicmsufremet_xml_tag)
			imposto_xml_tag.add_child(vtot_trib_xml_tag)
			imposto_xml_tag.add_child(pis_xml_tag)
			imposto_xml_tag.add_child(pisst_xml_tag)
			imposto_xml_tag.add_child(cofins_xml_tag)
			imposto_xml_tag.add_child(cofinsst_xml_tag)
			imposto_xml_tag.add_child(icmsufdest_xml_tag)
			ipi_devol_xml_tag.add_child(vipi_devol_xml_tag)
			imposto_devol_xml_tag.add_child(pdevol_xml_tag)
			imposto_devol_xml_tag.add_child(ipi_devol_xml_tag)
			det_xml_tag.add_child(prod_xml_tag)
			det_xml_tag.add_child(imposto_xml_tag)
			det_xml_tag.add_child(imposto_devol_xml_tag)
			det_xml_tag.add_child(infadprod_xml_tag)

			if !ultimo_produto.nil?
				ultimo_produto.after(det_xml_tag)
			else
				total.before(det_xml_tag)
			end
		end
	}},
	{"id"=>"311", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:cProd", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"312", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:cEAN", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"313", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:xProd", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"314", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:NCM", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"315", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:NVE", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"317", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:CEST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"318", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:indEscala", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"319", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:CNPJFab", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"321", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:EXTIPI", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"322", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:CFOP", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"323", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:uCom", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"324", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:qCom", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"325", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:vUnCom", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"326", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:vProd", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"327", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:cEANTrib", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"328", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:uTrib", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"329", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:qTrib", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"330", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:vUnTrib", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"331", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:vFrete", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"332", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:vSeg", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"333", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:vDesc", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"334", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:vOutro", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"335", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:indTot", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"336", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI", "lambda" => lambda{|msg,xml|}},
	{"id"=>"337", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI//xs:nDI", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"338", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI//xs:dDI", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"339", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI//xs:xLocDesemb", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"340", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI//xs:UFDesemb", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"341", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI//xs:dDesemb", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"342", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI//xs:tpViaTransp", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"343", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI//xs:vAFRMM", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"344", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI//xs:tpIntermedio", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"345", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI//xs:CNPJ", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"346", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI//xs:UFTerceiro", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"347", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI//xs:cExportador", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"348", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI//xs:adi", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"349", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI//xs:adi//xs:nAdicao", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"350", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI//xs:adi//xs:nSeqAdic", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"351", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI//xs:adi//xs:cFabricante", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"352", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI//xs:adi//xs:vDescDI", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"353", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI//xs:adi//xs:nDraw", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"354", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:detExport", "lambda" => lambda{|msg,xml|}},
	{"id"=>"355", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:detExport//xs:nDraw", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"356", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:detExport//xs:exportInd", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"357", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:detExport//xs:exportInd//xs:nRE", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"358", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:detExport//xs:exportInd//xs:chNFe", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"359", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:detExport//xs:exportInd//xs:qExport", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"360", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:xPed", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"361", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:nItemPed", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"362", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:nFCI", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"363", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:rastro", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"364", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:rastro//xs:nLote", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"365", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:rastro//xs:qLote", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"366", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:rastro//xs:dFab", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"367", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:rastro//xs:dVal", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"369", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"370", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"371", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"372", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"373", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd", "lambda" => lambda{|msg,xml|}},
	{"id"=>"374", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd//xs:tpOp", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"375", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd//xs:chassi", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"376", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd//xs:cCor", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"377", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd//xs:xCor", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"378", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd//xs:pot", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"379", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd//xs:cilin", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"380", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd//xs:pesoL", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"381", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd//xs:pesoB", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"382", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd//xs:nSerie", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"383", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd//xs:tpComb", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"384", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd//xs:nMotor", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"385", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd//xs:CMT", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"386", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd//xs:dist", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"387", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd//xs:anoMod", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"388", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd//xs:anoFab", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"389", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd//xs:tpPint", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"390", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd//xs:tpVeic", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"391", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd//xs:espVeic", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"392", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd//xs:VIN", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"393", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd//xs:condVeic", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"394", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd//xs:cMod", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"395", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd//xs:cCorDENATRAN", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"396", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd//xs:lota", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"397", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd//xs:tpRest", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"398", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:med", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"399", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:med//xs:cProdANVISA", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"405", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:med//xs:vPMC", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"406", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:arma", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"407", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:arma//xs:tpArma", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"408", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:arma//xs:nSerie", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"409", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:arma//xs:nCano", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"410", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:arma//xs:descr", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"411", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"412", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb//xs:cProdANP", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"414", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb//xs:descANP", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"415", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb//xs:pGLP", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"416", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb//xs:pGNn", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"417", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb//xs:pGNi", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"418", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb//xs:vPart", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"419", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb//xs:CODIF", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"420", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb//xs:qTemp", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"421", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb//xs:UFCons", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"422", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb//xs:CIDE", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"423", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb//xs:CIDE//xs:qBCProd", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"424", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb//xs:CIDE//xs:vAliqProd", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"425", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb//xs:CIDE//xs:vCIDE", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"426", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb//xs:encerrante", "lambda" => lambda{|msg,xml|}},
	{"id"=>"427", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb//xs:encerrante//xs:nBico", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"428", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb//xs:encerrante//xs:nBomba", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"429", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb//xs:encerrante//xs:nTanque", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"430", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb//xs:encerrante//xs:vEncIni", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"431", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb//xs:encerrante//xs:vEncFin", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"432", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod", "lambda" => lambda{|msg,xml|}},
	{"id"=>"433", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:nRECOPI", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"434", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		produtos.each_with_index do |produto,index|
			vtot_trib_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:imposto//xs:vTotTrib","xs"=>"http://www.portalfiscal.inf.br/nfe").first 

			icms = produto[:icms]
			issqn = produto[:issqn]
			ii = produto[:ii]
			pis = produto[:pis]
			cofins = produto[:cofins]
			ipi = produto[:ipi]

			if !icms.nil?
				icms_xml_tag = Nokogiri::XML("<ICMS>").elements.first
				ipi_xml_tag = Nokogiri::XML("<IPI>").elements.first
				ii_xml_tag = Nokogiri::XML("<II>").elements.first

				vtot_trib_xml_tag.after(ii_xml_tag)
				vtot_trib_xml_tag.after(ipi_xml_tag)
				vtot_trib_xml_tag.after(icms_xml_tag)
			elsif !issqn.nil?
				issqn_xml_tag = Nokogiri::XML("<ICMS>").elements.first
				ipi_xml_tag = Nokogiri::XML("<ICMS>").elements.first

				vtot_trib_xml_tag.after(issqn_xml_tag)
				vtot_trib_xml_tag.after(ipi_xml_tag)
			end
		end
	}},
	{"id"=>"435", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:vTotTrib", "lambda" => lambda{|msg,xml|}},
	{"id"=>"436", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto", "lambda" => lambda{|msg,xml|}},
	{"id"=>"437", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		produtos.each_with_index do |produto,index|

			icms = produto[:icms]
			codigo = icms[:codigo]

			icms_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:imposto//xs:ICMS","xs"=>"http://www.portalfiscal.inf.br/nfe").first
			icms00_xml_tag = Nokogiri::XML("<ICMS00>").elements.first
			icms10_xml_tag = Nokogiri::XML("<ICMS10>").elements.first
			icms20_xml_tag = Nokogiri::XML("<ICMS20>").elements.first
			icms30_xml_tag = Nokogiri::XML("<ICMS30>").elements.first
			icms40_xml_tag = Nokogiri::XML("<ICMS40>").elements.first
			icms51_xml_tag = Nokogiri::XML("<ICMS51>").elements.first
			icms60_xml_tag = Nokogiri::XML("<ICMS60>").elements.first
			icms70_xml_tag = Nokogiri::XML("<ICMS70>").elements.first
			icms80_xml_tag = Nokogiri::XML("<ICMS90>").elements.first
			icms_part_xml_tag = Nokogiri::XML("<ICMSPart>").elements.first
			icmsst_xml_tag = Nokogiri::XML("<ICMSST>").elements.first
			icmssn101_xml_tag = Nokogiri::XML("<ICMSSN101>").elements.first
			icmssn102_xml_tag = Nokogiri::XML("<ICMSSN102>").elements.first
			icmssn201_xml_tag = Nokogiri::XML("<ICMSSN201>").elements.first
			icmssn202_xml_tag = Nokogiri::XML("<ICMSSN202>").elements.first
			icmssn500_xml_tag = Nokogiri::XML("<ICMSSN500>").elements.first
			icmssn900_xml_tag = Nokogiri::XML("<ICMSSN900>").elements.first

			case codigo
			when "00"
				icms_xml_tag.add_child(icms00_xml_tag)
			when "10"
				icms_xml_tag.add_child(icms10_xml_tag)
				icms_xml_tag.add_child(icms_part_xml_tag)
			when "20"
				icms_xml_tag.add_child(icms20_xml_tag)
			when "30"
				icms_xml_tag.add_child(icms30_xml_tag)
			when "40"
				icms_xml_tag.add_child(icms40_xml_tag)
			when "41"
				icms_xml_tag.add_child(icms40_xml_tag)
				icms_xml_tag.add_child(icmsst_xml_tag)
			when "50"
				icms_xml_tag.add_child(icms40_xml_tag)
			when "51"
				icms_xml_tag.add_child(icms51_xml_tag)
			when "60"
				icms_xml_tag.add_child(icms60_xml_tag)
				icms_xml_tag.add_child(icmsst_xml_tag)
			when "70"
				icms_xml_tag.add_child(icms70_xml_tag)
			when "90"
				icms_xml_tag.add_child(icms90_xml_tag)
				icms_xml_tag.add_child(icms_part_xml_tag)
			when "101"
				icms_xml_tag.add_child(icmssn101_xml_tag)
			when "102"
				icms_xml_tag.add_child(icmssn102_xml_tag)
			when "103"
				icms_xml_tag.add_child(icmssn102_xml_tag)
			when "201"
				icms_xml_tag.add_child(icmssn201_xml_tag)
			when "202"
				icms_xml_tag.add_child(icmssn202_xml_tag)
			when "203"
				icms_xml_tag.add_child(icmssn203_xml_tag)
			when "300"
				icms_xml_tag.add_child(icmssn102_xml_tag)
			when "400"
				icms_xml_tag.add_child(icmssn102_xml_tag)
			when "500"
				icms_xml_tag.add_child(icmssn500_xml_tag)
			when "900"
				icms_xml_tag.add_child(icmssn900_xml_tag)
			end
		end
	}},
	{"id"=>"438", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS00", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"439", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS00//xs:orig", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"440", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS00//xs:CST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"441", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS00//xs:modBC", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"442", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS00//xs:vBC", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"443", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS00//xs:pICMS", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"444", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS00//xs:vICMS", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"445", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS00", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"446", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS00//xs:pFCP", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"447", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS00//xs:vFCP", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"448", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10", "lambda" => lambda{|msg,xml|}},
	{"id"=>"449", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10//xs:orig", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"450", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10//xs:CST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"451", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10//xs:modBC", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"452", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10//xs:vBC", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"453", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10//xs:pICMS", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"454", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10//xs:vICMS", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"456", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10//xs:vBCFCP", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"457", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10//xs:pFCP", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"458", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10//xs:vFCP", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"459", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10//xs:modBCST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"460", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10//xs:pMVAST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"461", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10//xs:pRedBCST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"462", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10//xs:vBCST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"463", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10//xs:pICMSST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"464", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10//xs:vICMSST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"465", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10", "lambda" => lambda{|msg,xml|}},
	{"id"=>"466", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10//xs:vBCFCPST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"467", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10//xs:pFCPST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"468", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10//xs:vFCPST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"469", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10", "lambda" => lambda{|msg,xml|}},
	{"id"=>"470", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10//xs:vICMSSTDeson", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"471", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10//xs:motDesICMSST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"472", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS20", "lambda" => lambda{|msg,xml|}},
	{"id"=>"473", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS20//xs:orig", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"474", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS20//xs:CST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"475", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS20//xs:modBC", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"476", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS20//xs:pRedBC", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"477", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS20//xs:vBC", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"478", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS20//xs:pICMS", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"479", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS20//xs:vICMS", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"480", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS20", "lambda" => lambda{|msg,xml|}},
	{"id"=>"481", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS20//xs:vBCFCP", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"482", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS20//xs:pFCP", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"483", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS20//xs:vFCP", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"484", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS20", "lambda" => lambda{|msg,xml|}},
	{"id"=>"485", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS20//xs:vICMSDeson", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"486", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS20//xs:motDesICMS", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"487", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS30", "lambda" => lambda{|msg,xml|}},
	{"id"=>"488", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS30//xs:orig", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"489", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS30//xs:CST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"490", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS30//xs:modBCST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"491", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS30//xs:pMVAST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"492", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS30//xs:pRedBCST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"493", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS30//xs:vBCST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"494", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS30//xs:pICMSST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"495", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS30//xs:vICMSST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"496", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS30", "lambda" => lambda{|msg,xml|}},
	{"id"=>"497", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS30//xs:vBCFCPST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"498", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS30//xs:pFCPST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"499", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS30//xs:vFCPST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"500", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS30", "lambda" => lambda{|msg,xml|}},
	{"id"=>"501", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS30//xs:vICMSDeson", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"502", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS30//xs:motDesICMS", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"503", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS40", "lambda" => lambda{|msg,xml|}},
	{"id"=>"504", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS40//xs:orig", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"505", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS40//xs:CST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"506", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS40", "lambda" => lambda{|msg,xml|}},
	{"id"=>"507", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS40//xs:vICMSDeson", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"508", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS40//xs:motDesICMS", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"509", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS51", "lambda" => lambda{|msg,xml|}},
	{"id"=>"510", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS51//xs:orig", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"511", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS51//xs:CST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"512", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS51//xs:modBC", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"513", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS51//xs:pRedBC", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"514", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS51//xs:vBC", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"515", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS51//xs:pICMS", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"516", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS51//xs:vICMSOp", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"517", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS51//xs:pDif", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"518", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS51//xs:vICMSDif", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"519", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS51//xs:vICMS", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"520", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS51", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"521", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS51//xs:vBCFCP", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"522", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS51//xs:pFCP", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"523", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS51//xs:vFCP", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"524", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS60", "lambda" => lambda{|msg,xml|}},
	{"id"=>"525", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS60//xs:orig", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"526", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS60//xs:CST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"527", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS60", "lambda" => lambda{|msg,xml|}},
	{"id"=>"528", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS60//xs:vBCSTRet", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"529", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS60//xs:pST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"531", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS60//xs:vICMSSTRet", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"532", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS60", "lambda" => lambda{|msg,xml|}},
	{"id"=>"533", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS60//xs:vBCFCPSTRet", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"534", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS60//xs:pFCPSTRet", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"535", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS60//xs:vFCPSTRet", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"537", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS60//xs:pRedBCEfet", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"538", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS60//xs:vBCEfet", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"539", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS60//xs:pICMSEfet", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"540", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS60//xs:vICMSEfet", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"541", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70", "lambda" => lambda{|msg,xml|}},
	{"id"=>"542", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70//xs:orig", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"543", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70//xs:CST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"544", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70//xs:modBC", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"545", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70//xs:pRedBC", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"546", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70//xs:vBC", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"547", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70//xs:pICMS", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"548", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70//xs:vICMS", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"549", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70//xs:modBCST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"550", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70//xs:pMVAST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"551", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70//xs:pRedBCST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"552", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70//xs:vBCST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"553", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70//xs:pICMSST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"554", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70//xs:vICMSST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"556", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70//xs:vBCFCP", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"557", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70//xs:pFCP", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"558", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70//xs:vFCP", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"559", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70", "lambda" => lambda{|msg,xml|}},
	{"id"=>"560", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70//xs:vBCFCPST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"561", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70//xs:pFCPST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"562", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70//xs:vFCPST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"563", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"564", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70//xs:vICMSDeson", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"565", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70//xs:motDesICMS", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"566", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90", "lambda" => lambda{|msg,xml|}},
	{"id"=>"567", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90//xs:orig", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"568", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90//xs:CST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"569", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90", "lambda" => lambda{|msg,xml|}},
	{"id"=>"570", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90//xs:modBC", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"571", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90//xs:vBC", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"572", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90//xs:pRedBC", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"573", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90//xs:pICMS", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"574", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90//xs:vICMS", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"575", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90", "lambda" => lambda{|msg,xml|}},
	{"id"=>"576", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90//xs:vBCFCP", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"577", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90//xs:pFCP", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"578", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90//xs:vFCP", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"579", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90", "lambda" => lambda{|msg,xml|}},
	{"id"=>"580", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90//xs:modBCST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"581", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90//xs:pMVAST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"582", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90//xs:pRedBCST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"583", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90//xs:vBCST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"584", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90//xs:pICMSST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"585", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90//xs:vICMSST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"586", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90", "lambda" => lambda{|msg,xml|}},
	{"id"=>"587", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90//xs:vBCFCPST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"588", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90//xs:pFCPST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"589", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90//xs:vFCPST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"590", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90", "lambda" => lambda{|msg,xml|}},
	{"id"=>"591", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90//xs:vICMSDeson", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"592", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90//xs:motDesICMS", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"593", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart", "lambda" => lambda{|msg,xml|}},
	{"id"=>"594", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart//xs:orig", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"595", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart//xs:CST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"596", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart//xs:modBC", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"597", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart//xs:vBC", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"598", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart//xs:pRedBC", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"599", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart//xs:pICMS", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"600", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart//xs:vICMS", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"601", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart//xs:modBCST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"602", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart//xs:pMVAST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"603", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart//xs:pRedBCST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"604", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart//xs:vBCST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"605", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart//xs:pICMSST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"606", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart//xs:vICMSST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"607", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart", "lambda" => lambda{|msg,xml|}},
	{"id"=>"608", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart//xs:vBCFCPST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"609", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart//xs:pFCPST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"610", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart//xs:vFCPST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"611", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart//xs:pBCOp", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"612", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart//xs:UFST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"613", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSST", "lambda" => lambda{|msg,xml|}},
	{"id"=>"614", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSST//xs:orig", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"615", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSST//xs:CST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"616", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSST//xs:vBCSTRet", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"619", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSST//xs:vICMSSTRet", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"621", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSST//xs:vBCFCPSTRet", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"622", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSST//xs:pFCPSTRet", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"623", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSST//xs:vFCPSTRet", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"624", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSST//xs:vBCSTDest", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"625", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSST//xs:vICMSSTDest", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"627", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSST//xs:pRedBCEfet", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"628", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSST//xs:vBCEfet", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"629", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSST//xs:pICMSEfet", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"630", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSST//xs:vICMSEfet", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"631", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN101", "lambda" => lambda{|msg,xml|}},
	{"id"=>"632", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN101//xs:orig", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"633", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN101//xs:CSOSN", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"634", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN101//xs:pCredSN", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"635", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN101//xs:vCredICMSSN", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"636", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN102", "lambda" => lambda{|msg,xml|}},
	{"id"=>"637", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN102//xs:orig", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"638", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN102//xs:CSOSN", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"639", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN201", "lambda" => lambda{|msg,xml|}},
	{"id"=>"640", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN201//xs:orig", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"641", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN201//xs:CSOSN", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"642", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN201//xs:modBCST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"643", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN201//xs:pMVAST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"644", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN201//xs:pRedBCST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"645", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN201//xs:vBCST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"646", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN201//xs:pICMSST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"647", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN201//xs:vICMSST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"648", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN201", "lambda" => lambda{|msg,xml|}},
	{"id"=>"649", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN201//xs:vBCFCPST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"650", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN201//xs:pFCPST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"651", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN201//xs:vFCPST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"652", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN201//xs:pCredSN", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"653", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN201//xs:vCredICMSSN", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"654", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN202", "lambda" => lambda{|msg,xml|}},
	{"id"=>"655", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN202//xs:orig", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"656", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN202//xs:CSOSN", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"657", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN202//xs:modBCST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"658", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN202//xs:pMVAST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"659", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN202//xs:pRedBCST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"660", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN202//xs:vBCST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"661", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN202//xs:pICMSST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"662", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN202//xs:vICMSST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"663", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN202", "lambda" => lambda{|msg,xml|}},
	{"id"=>"664", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN202//xs:vBCFCPST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"665", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN202//xs:pFCPST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"666", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN202//xs:vFCPST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"667", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN500", "lambda" => lambda{|msg,xml|}},
	{"id"=>"668", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN500//xs:orig", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"669", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN500//xs:CSOSN", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"670", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN500", "lambda" => lambda{|msg,xml|}},
	{"id"=>"671", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN500//xs:vBCSTRet", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"672", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN500//xs:pST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"673", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN500//xs:vICMSSubstituto", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"674", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN500//xs:vICMSSTRet", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"675", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN500", "lambda" => lambda{|msg,xml|}},
	{"id"=>"676", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN500//xs:vBCFCPSTRet", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"677", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN500//xs:pFCPSTRet", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"678", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN500//xs:vFCPSTRet", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"679", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN500", "lambda" => lambda{|msg,xml|}},
	{"id"=>"680", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN500//xs:pRedBCEfet", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"681", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN500//xs:vBCEfet", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"682", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN500//xs:pICMSEfet", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"683", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN500//xs:vICMSEfet", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"684", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900", "lambda" => lambda{|msg,xml|}},
	{"id"=>"685", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900//xs:orig", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"686", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900//xs:CSOSN", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"687", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900", "lambda" => lambda{|msg,xml|}},
	{"id"=>"688", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900//xs:modBC", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"689", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900//xs:vBC", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"690", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900//xs:pRedBC", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"691", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900//xs:pICMS", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"692", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900//xs:vICMS", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"693", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900", "lambda" => lambda{|msg,xml|}},
	{"id"=>"694", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900//xs:modBCST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"695", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900//xs:pMVAST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"696", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900//xs:pRedBCST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"697", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900//xs:vBCST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"698", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900//xs:pICMSST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"699", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900//xs:vICMSST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"700", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900", "lambda" => lambda{|msg,xml|}},
	{"id"=>"701", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900//xs:vBCFCPST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"702", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900//xs:pFCPST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"703", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900//xs:vFCPST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"704", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900", "lambda" => lambda{|msg,xml|}},
	{"id"=>"705", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900//xs:pCredSN", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"706", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900//xs:vCredICMSSN", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"707", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		produtos.each_with_index do |produto,index|

			ipi = produto[:imposto][:ipi]
			ipi_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:imposto//xs:IPI","xs"=>"http://www.portalfiscal.inf.br/nfe").first
			
			if !ipi_xml_tag.nil?
				
				cnpj_produtor_xml_tag = Nokogiri::XML("<CNPJProd>").elements.first
				selo_xml_tag = Nokogiri::XML("<cSelo>").elements.first
				quantidade_selo_xml_tag = Nokogiri::XML("<qSelo>").elements.first
				codigo_enquadramento_xml_tag = Nokogiri::XML("<cEnq>").elements.first
				ipi_trib_xml_tag = Nokogiri::XML("<IPITrib>").elements.first
				ipi_nt_xml_tag = Nokogiri::XML("<IPINT>").elements.first

				ipi_xml_tag.add_child(cnpj_produtor_xml_tag)
				ipi_xml_tag.add_child(selo_xml_tag)
				ipi_xml_tag.add_child(quantidade_selo_xml_tag)
				ipi_xml_tag.add_child(codigo_enquadramento_xml_tag)

				case ipi[:codigo]
				when "00"
					ipi_xml_tag.add_child(ipi_trib_xml_tag)
				when "49"
					ipi_xml_tag.add_child(ipi_trib_xml_tag)
				when "50"
					ipi_xml_tag.add_child(ipi_trib_xml_tag)
				when "99"
					ipi_xml_tag.add_child(ipi_trib_xml_tag)
				when "01"
					ipi_xml_tag.add_child(ipi_nt_xml_tag)
				when "02"
					ipi_xml_tag.add_child(ipi_nt_xml_tag)
				when "03"
					ipi_xml_tag.add_child(ipi_nt_xml_tag)
				when "01"
					ipi_xml_tag.add_child(ipi_nt_xml_tag)
				when "02"
					ipi_xml_tag.add_child(ipi_nt_xml_tag)
				when "03"
					ipi_xml_tag.add_child(ipi_nt_xml_tag)
				when "04"
					ipi_xml_tag.add_child(ipi_nt_xml_tag)
				when "05"
					ipi_xml_tag.add_child(ipi_nt_xml_tag)
				when "51"
					ipi_xml_tag.add_child(ipi_nt_xml_tag)
				when "52"
					ipi_xml_tag.add_child(ipi_nt_xml_tag)
				when "53"
					ipi_xml_tag.add_child(ipi_nt_xml_tag)
				when "54"
					ipi_xml_tag.add_child(ipi_nt_xml_tag)
				when "55"
					ipi_xml_tag.add_child(ipi_nt_xml_tag)
				end
			end
		end
	}},
	{"id"=>"709", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:CNPJProd", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"710", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:cSelo", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"711", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:qSelo", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"712", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:cEnq", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"713", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:IPITrib", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		produtos.each_with_index do |produto,index|
			ipi = produto[:imposto][:ipi]
			ipi_trib_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:imposto//xs:IPI//xs:IPITrib","xs"=>"http://www.portalfiscal.inf.br/nfe").first

			if !ipi_trib_xml_tag.nil?
				codigo_xml_tag = Nokogiri::XML("<CST>").elements.first
				base_calculo_xml_tag = Nokogiri::XML("<vBC>").elements.first
				aliquota_percentual_xml_tag = Nokogiri::XML("<pIPI>").elements.first
				quantidade_xml_tag = Nokogiri::XML("<qUnid>").elements.first
				aliquota_valor_xml_tag = Nokogiri::XML("<vUnid>").elements.first
				vipi_xml_tag = Nokogiri::XML("<vIPI>").elements.first

				ipi_trib_xml_tag.add_child(codigo_xml_tag)
				
				if !ipi[:aliquota_percentual].nil?
					ipi_trib_xml_tag.add_child(base_calculo_xml_tag)
					ipi_trib_xml_tag.add_child(aliquota_percentual)
				elsif !ipi[:aliquota_valor].nil?
					ipi_trib_xml_tag.add_child(quantidade_xml_tag)
					ipi_trib_xml_tag.add_child(aliquota_valor_xml_tag)
				end

				ipi_trib_xml_tag.add_child(vipi_xml_tag)
			end
		end
	}},
	{"id"=>"714", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:IPITrib//xs:CST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"715", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:IPITrib", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"716", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:IPITrib//xs:vBC", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"717", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:IPITrib//xs:pIPI", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"718", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:IPITrib", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"719", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:IPITrib//xs:qUnid", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"720", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:IPITrib//xs:vUnid", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"721", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:IPITrib//xs:vIPI", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"722", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:IPINT", "lambda" => lambda{|msg,xml|}},
	{"id"=>"723", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:IPINT//xs:CST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"724", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:II", "lambda" => lambda{|msg,xml|}},
	{"id"=>"725", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:II//xs:vBC", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"726", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:II//xs:vDespAdu", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"727", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:II//xs:vII", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"728", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:II//xs:vIOF", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"729", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto", "lambda" => lambda{|msg,xml|}},
	{"id"=>"731", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:clEnq", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"732", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:CNPJProd", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"733", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:cSelo", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"734", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:qSelo", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"735", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:cEnq", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"736", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:IPITrib", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		produtos.each_with_index do |produto,index|
			ipi = produto[:imposto][:ipi]
			ipi_trib_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:imposto//xs:IPI//xs:IPITrib","xs"=>"http://www.portalfiscal.inf.br/nfe").first

			if !ipi_trib_xml_tag.nil?
				codigo_xml_tag = Nokogiri::XML("<CST>").elements.first
				base_calculo_xml_tag = Nokogiri::XML("<vBC>").elements.first
				aliquota_percentual_xml_tag = Nokogiri::XML("<pIPI>").elements.first
				quantidade_xml_tag = Nokogiri::XML("<qUnid>").elements.first
				aliquota_valor_xml_tag = Nokogiri::XML("<vUnid>").elements.first
				vipi_xml_tag = Nokogiri::XML("<vIPI>").elements.first

				ipi_trib_xml_tag.add_child(codigo_xml_tag)
				
				if !ipi[:aliquota_percentual].nil?
					ipi_trib_xml_tag.add_child(base_calculo_xml_tag)
					ipi_trib_xml_tag.add_child(aliquota_percentual)
				elsif !ipi[:aliquota_valor].nil?
					ipi_trib_xml_tag.add_child(quantidade_xml_tag)
					ipi_trib_xml_tag.add_child(aliquota_valor_xml_tag)
				end

				ipi_trib_xml_tag.add_child(vipi_xml_tag)
			end
		end
	}},	
	{"id"=>"737", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:IPITrib//xs:CST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"738", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:IPITrib", "lambda" => lambda{|msg,xml|}},
	{"id"=>"739", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:IPITrib//xs:vBC", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"740", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:IPITrib//xs:pIPI", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"741", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:IPITrib", "lambda" => lambda{|msg,xml|}},
	{"id"=>"742", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:IPITrib//xs:qUnid", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"743", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:IPITrib//xs:vUnid", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"744", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:IPITrib//xs:vIPI", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"745", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:IPINT", "lambda" => lambda{|msg,xml|}},
	{"id"=>"746", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:IPINT//xs:CST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"747", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN", "lambda" => lambda{|msg,xml|}},
	{"id"=>"748", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN//xs:vBC", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"749", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN//xs:vAliq", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"750", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN//xs:vISSQN", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"751", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN//xs:cMunFG", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"752", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN//xs:cListServ", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"753", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN//xs:vDeducao", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"754", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN//xs:vOutro", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"755", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN//xs:vDescIncond", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"756", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN//xs:vDescCond", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"757", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN//xs:vISSRet", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"758", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN//xs:indISS", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"759", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN//xs:cServico", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"760", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN//xs:cMun", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"761", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN//xs:cPais", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"762", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN//xs:nProcesso", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"763", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN//xs:indIncentivo", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"764", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		produtos.each_with_index do |produto,index|

			pis = produto[:imposto][:pis]
			pis_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:imposto//xs:PIS","xs"=>"http://www.portalfiscal.inf.br/nfe").first

			if !pis_xml_tag.nil?
				
				pisaliq_xml_tag = Nokogiri::XML("<PISAliq>").elements.first
				pisqtde_xml_tag = Nokogiri::XML("<PISQtde>").elements.first
				pisnt_xml_tag = Nokogiri::XML("<PISNT>").elements.first
				pisoutr_xml_tag = Nokogiri::XML("<PISOutr>").elements.first

				case pis[:codigo]
				when "01"
					pis_xml_tag.add_child(pisaliq_xml_tag)
				when "02"
					pis_xml_tag.add_child(pisaliq_xml_tag)
				when "03"
					pis_xml_tag.add_child(pisqtde_xml_tag)
				when "04"
					pis_xml_tag.add_child(pisnt_xml_tag)
				when "05"
					pis_xml_tag.add_child(pisnt_xml_tag)
				when "06"
					pis_xml_tag.add_child(pisnt_xml_tag)
				when "07"
					pis_xml_tag.add_child(pisnt_xml_tag)
				when "08"
					pis_xml_tag.add_child(pisnt_xml_tag)
				when "09"
					pis_xml_tag.add_child(pisnt_xml_tag)
				when "49"
					pis_xml_tag.add_child(pisoutr_xml_tag)
				when "50"
					pis_xml_tag.add_child(pisoutr_xml_tag)
				when "51"
					pis_xml_tag.add_child(pisoutr_xml_tag)
				when "52"
					pis_xml_tag.add_child(pisoutr_xml_tag)
				when "53"
					pis_xml_tag.add_child(pisoutr_xml_tag)
				when "54"
					pis_xml_tag.add_child(pisoutr_xml_tag)
				when "55"
					pis_xml_tag.add_child(pisoutr_xml_tag)
				when "56"
					pis_xml_tag.add_child(pisoutr_xml_tag)
				when "60"
					pis_xml_tag.add_child(pisoutr_xml_tag)
				when "61"
					pis_xml_tag.add_child(pisoutr_xml_tag)
				when "62"
					pis_xml_tag.add_child(pisoutr_xml_tag)
				when "63"
					pis_xml_tag.add_child(pisoutr_xml_tag)
				when "64"
					pis_xml_tag.add_child(pisoutr_xml_tag)
				when "65"
					pis_xml_tag.add_child(pisoutr_xml_tag)
				when "66"
					pis_xml_tag.add_child(pisoutr_xml_tag)
				when "67"
					pis_xml_tag.add_child(pisoutr_xml_tag)
				when "70"
					pis_xml_tag.add_child(pisoutr_xml_tag)
				when "71"
					pis_xml_tag.add_child(pisoutr_xml_tag)
				when "72"
					pis_xml_tag.add_child(pisoutr_xml_tag)
				when "73"
					pis_xml_tag.add_child(pisoutr_xml_tag)
				when "74"
					pis_xml_tag.add_child(pisoutr_xml_tag)
				when "75"
					pis_xml_tag.add_child(pisoutr_xml_tag)
				when "98"
					pis_xml_tag.add_child(pisoutr_xml_tag)
				when "99"
					pis_xml_tag.add_child(pisoutr_xml_tag)
				end
			end
		end
	}},
	{"id"=>"765", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISAliq", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"766", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISAliq//xs:CST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"767", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISAliq//xs:vBC", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"768", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISAliq//xs:pPIS", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"769", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISAliq//xs:vPIS", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"770", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISQtde", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"771", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISQtde//xs:CST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"772", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISQtde//xs:qBCProd", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"773", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISQtde//xs:vAliqProd", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"774", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISQtde//xs:vPIS", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"775", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISNT", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"776", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISNT//xs:CST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"777", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISOutr", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"777", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISOutr", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		produtos.each_with_index do |produto,index|

			pis = produto[:imposto][:pis]
			pis_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:imposto//xs:PIS//xs:PISOutr","xs"=>"http://www.portalfiscal.inf.br/nfe").first

			if !pis_xml_tag.nil?
				base_calculo_xml_tag = Nokogiri::XML("<vBC>").elements.first
				aliquota_percentual_xml_tag = Nokogiri::XML("<pPIS>").elements.first
				quantidade_xml_tag = Nokogiri::XML("<qBCProd>").elements.first
				aliquota_valor_xml_tag = Nokogiri::XML("<vAliqProd>").elements.first
				vpis_xml_tag = Nokogiri::XML("<vPIS>").elements.first

				if !pis[:aliquota_percentual].nil?
					pis_xml_tag.add_child(base_calculo_xml_tag)
					pis_xml_tag.add_child(aliquota_percentual_xml_tag)
				elsif !pis[:aliquota_valor].nil?
					pis_xml_tag.add_child(quantidade_xml_tag)
					pis_xml_tag.add_child(aliquota_valor_xml_tag)
				end

				pis_xml_tag.add_child(vpis_xml_tag)
			end
		end
	}},
	{"id"=>"778", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISOutr//xs:CST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"779", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISOutr", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"780", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISOutr//xs:vBC", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"781", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISOutr//xs:pPIS", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"782", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISOutr", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"783", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISOutr//xs:qBCProd", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"784", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISOutr//xs:vAliqProd", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"785", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISOutr//xs:vPIS", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"786", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PISST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		produtos.each_with_index do |produto,index|

			pis = produto[:imposto][:pis]
			pisst_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:imposto//xs:PISST","xs"=>"http://www.portalfiscal.inf.br/nfe").first

			if !pisst_xml_tag.nil?
				base_calculo_xml_tag = Nokogiri::XML("<vBC>").elements.first
				aliquota_percentual = Nokogiri::XML("<pPIS>").elements.first
				quantidade_xml_tag = Nokogiri::XML("<qBCProd>").elements.first
				aliquota_valor_xml_tag = Nokogiri::XML("<vAliqProd>").elements.first
				vpis_xml_tag = Nokogiri::XML("<vPIS>").elements.first

				if !pis[:aliquota_percentual].nil?
					pisst_xml_tag.add_child(base_calculo_xml_tag)
					pisst_xml_tag.add_child(aliquota_percentual_xml_tag)
					pisst_xml_tag.add_child(vpis_xml_tag)
				elsif !pis[:aliquota_valor].nil?
					pisst_xml_tag.add_child(quantidade_xml_tag)
					pisst_xml_tag.add_child(aliquota_valor)
					pisst_xml_tag.add_child(vpis_xml_tag)
				end

			end
		end
	}},
	{"id"=>"787", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PISST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"788", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PISST//xs:vBC", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"789", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PISST//xs:pPIS", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"790", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PISST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"791", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PISST//xs:qBCProd", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"792", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PISST//xs:vAliqProd", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"793", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PISST//xs:vPIS", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"794", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		produtos.each_with_index do |produto,index|

			cofins = produto[:imposto][:cofins]
			cofins_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:imposto//xs:COFINS","xs"=>"http://www.portalfiscal.inf.br/nfe").first

			if !cofins_xml_tag.nil?
				cofins_aliq_xml_tag = Nokogiri::XML("<COFINSAliq>").elements.first
				cofins_qtde_xml_tag = Nokogiri::XML("<COFINSQtde>").elements.first
				cofins_nt_xml_tag = Nokogiri::XML("<COFINSNT>").elements.first
				cofins_outr_xml_tag = Nokogiri::XML("<COFINSOutr>").elements.first

				case cofins[:codigo]
				when "01"
					cofins_xml_tag.add_child(cofins_aliq_xml_tag)
				when "02"
					cofins_xml_tag.add_child(cofins_aliq_xml_tag)
				when "03"
					cofins_xml_tag.add_child(cofins_qtde_xml_tag)
				when "04"
					cofins_xml_tag.add_child(cofins_nt_xml_tag)
				when "05"
					cofins_xml_tag.add_child(cofins_nt_xml_tag)
				when "06"
					cofins_xml_tag.add_child(cofins_nt_xml_tag)
				when "07"
					cofins_xml_tag.add_child(cofins_nt_xml_tag)
				when "08"
					cofins_xml_tag.add_child(cofins_nt_xml_tag)
				when "09"
					cofins_xml_tag.add_child(cofins_nt_xml_tag)
				when "49"
					cofins_xml_tag.add_child(cofins_outr_xml_tag)
				when "50"
					cofins_xml_tag.add_child(cofins_outr_xml_tag)
				when "51"
					cofins_xml_tag.add_child(cofins_outr_xml_tag)
				when "52"
					cofins_xml_tag.add_child(cofins_outr_xml_tag)
				when "53"
					cofins_xml_tag.add_child(cofins_outr_xml_tag)
				when "54"
					cofins_xml_tag.add_child(cofins_outr_xml_tag)
				when "55"
					cofins_xml_tag.add_child(cofins_outr_xml_tag)
				when "56"
					cofins_xml_tag.add_child(cofins_outr_xml_tag)
				when "60"
					cofins_xml_tag.add_child(cofins_outr_xml_tag)
				when "61"
					cofins_xml_tag.add_child(cofins_outr_xml_tag)
				when "62"
					cofins_xml_tag.add_child(cofins_outr_xml_tag)
				when "63"
					cofins_xml_tag.add_child(cofins_outr_xml_tag)
				when "64"
					cofins_xml_tag.add_child(cofins_outr_xml_tag)
				when "65"
					cofins_xml_tag.add_child(cofins_outr_xml_tag)
				when "66"
					cofins_xml_tag.add_child(cofins_outr_xml_tag)
				when "67"
					cofins_xml_tag.add_child(cofins_outr_xml_tag)
				when "70"
					cofins_xml_tag.add_child(cofins_outr_xml_tag)
				when "71"
					cofins_xml_tag.add_child(cofins_outr_xml_tag)
				when "72"
					cofins_xml_tag.add_child(cofins_outr_xml_tag)
				when "73"
					cofins_xml_tag.add_child(cofins_outr_xml_tag)
				when "74"
					cofins_xml_tag.add_child(cofins_outr_xml_tag)
				when "75"
					cofins_xml_tag.add_child(cofins_outr_xml_tag)
				when "98"
					cofins_xml_tag.add_child(cofins_outr_xml_tag)
				when "99"
					cofins_xml_tag.add_child(cofins_outr_xml_tag)
				end
			end
		end
	}},
	{"id"=>"795", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSAliq", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"796", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSAliq//xs:CST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"797", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSAliq//xs:vBC", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"798", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSAliq//xs:pCOFINS", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"799", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSAliq//xs:vCOFINS", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"800", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSQtde", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"801", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSQtde//xs:CST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"802", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSQtde//xs:qBCProd", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"803", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSQtde//xs:vAliqProd", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"804", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSQtde//xs:vCOFINS", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"805", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSNT", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"806", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSNT//xs:CST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"807", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSOutr", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		produtos.each_with_index do |produto,index|

			cofins = produto[:imposto][:cofins]
			cofins_outr_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:imposto//xs:COFINS//xs:COFINSOutr","xs"=>"http://www.portalfiscal.inf.br/nfe").first

			if !cofins_outr_xml_tag.nil?
				codigo_xml_tag = Nokogiri::XML("<CST>").elements.first
				base_calculo_xml_tag = Nokogiri::XML("<vBC>").elements.first
				aliquota_percentual_xml_tag = Nokogiri::XML("<pCOFINS>").elements.first
				quantidade_xml_tag = Nokogiri::XML("<qBCProd>").elements.first
				aliquota_valor_xml_tag = Nokogiri::XML("<vAliqProd>").elements.first
				valor_cofins_xml_tag = Nokogiri::XML("<vCOFINS>").elements.first

				cofins_outr_xml_tag.add_child(codigo_xml_tag)

				if !cofins[:aliquota_percentual].nil?
					cofins_outr_xml_tag.add_child(base_calculo_xml_tag)
					cofins_outr_xml_tag.add_child(aliquota_percentual_xml_tag)
				elsif !cofins[:aliquota_valor].nil?
					cofins_outr_xml_tag.add_child(quantidade_xml_tag)
					cofins_outr_xml_tag.add_child(aliquota_valor_xml_tag)
				end

				cofins_outr_xml_tag.add_child(valor_cofins_xml_tag)
			end
		end
	}},
	{"id"=>"808", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSOutr//xs:CST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"809", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSOutr", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"810", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSOutr//xs:vBC", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"811", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSOutr//xs:pCOFINS", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"812", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSOutr", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"813", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSOutr//xs:qBCProd", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"814", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSOutr//xs:vAliqProd", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"815", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSOutr//xs:vCOFINS", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"816", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINSST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		produtos.each_with_index do |produto,index|

			cofins = produto[:imposto][:cofins]
			cofinsst_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:imposto//xs:COFINS//xs:COFINSST","xs"=>"http://www.portalfiscal.inf.br/nfe").first

			if !cofinsst_xml_tag.nil?
				base_calculo_xml_tag = Nokogiri::XML("<vBC>").elements.first
				aliquota_percentual_xml_tag = Nokogiri::XML("<pCOFINS>").elements.first
				quantidade_xml_tag = Nokogiri::XML("<qBCProd>").elements.first
				aliquota_valor_xml_tag = Nokogiri::XML("<vAliqProd>").elements.first
				valor_cofins_xml_tag = Nokogiri::XML("<vCOFINS>").elements.first

				if !cofins[:aliquota_percentual].nil?
					cofinsst_xml_tag.add_child(base_calculo_xml_tag)
					cofinsst_xml_tag.add_child(aliquota_percentual_xml_tag)
				elsif !cofins[:aliquota_valor].nil?
					cofinsst_xml_tag.add_child(quantidade_xml_tag)
					cofinsst_xml_tag.add_child(aliquota_valor_xml_tag)
				end

				cofinsst_xml_tag.add_child(valor_cofins_xml_tag)
			end
		end
	}},
	{"id"=>"817", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINSST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"818", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINSST//xs:vBC", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"819", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINSST//xs:pCOFINS", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"820", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINSST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"821", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINSST//xs:qBCProd", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"822", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINSST//xs:vAliqProd", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"823", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINSST//xs:vCOFINS", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"824", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMSUFDest", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"825", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMSUFDest//xs:vBCUFDest", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"826", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMSUFDest//xs:vBCFCPUFDest", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"827", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMSUFDest//xs:pFCPUFDest", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"828", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMSUFDest//xs:pICMSUFDest", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"829", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMSUFDest//xs:pICMSInter", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"830", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMSUFDest//xs:pICMSInterPart", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"831", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMSUFDest//xs:vFCPUFDest", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"832", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMSUFDest//xs:vICMSUFDest", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"833", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMSUFDest//xs:vICMSUFRemet", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"834", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:impostoDevol", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"835", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:impostoDevol//xs:pDevol", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"836", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:impostoDevol//xs:IPI", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"837", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:impostoDevol//xs:IPI//xs:vIPIDevol", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"838", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:infAdProd", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"839", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"840", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"841", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vBC", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"842", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vICMS", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"843", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vICMSDeson", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"844", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vFCPUFDest", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"845", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vICMSUFDest", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"846", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vICMSUFRemet", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"847", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vFCP", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"848", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vBCST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"849", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"850", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vFCPST", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"851", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vFCPSTRet", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"852", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vProd", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"853", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vFrete", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"854", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vSeg", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"855", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vDesc", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"856", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vII", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"857", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vIPI", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"858", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vIPIDevol", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"859", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vPIS", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"860", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vCOFINS", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"861", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vOutro", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"862", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vNF", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"863", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vTotTrib", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"864", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ISSQNtot", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"865", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ISSQNtot//xs:vServ", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"866", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ISSQNtot//xs:vBC", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"867", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ISSQNtot//xs:vISS", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"868", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ISSQNtot//xs:vPIS", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"869", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ISSQNtot//xs:vCOFINS", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"870", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ISSQNtot//xs:dCompet", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"871", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ISSQNtot//xs:vDeducao", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"872", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ISSQNtot//xs:vOutro", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"873", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ISSQNtot//xs:vDescIncond", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"874", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ISSQNtot//xs:vDescCond", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"875", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ISSQNtot//xs:vISSRet", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"876", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ISSQNtot//xs:cRegTrib", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"877", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:retTrib", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"878", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:retTrib//xs:vRetPIS", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"879", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:retTrib//xs:vRetCOFINS", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"880", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:retTrib//xs:vRetCSLL", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"881", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:retTrib//xs:vBCIRRF", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"882", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:retTrib//xs:vIRRF", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"883", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:retTrib//xs:vBCRetPrev", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"884", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:retTrib//xs:vRetPrev", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"885", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp", "lambda" => lambda{|msg,xml|

		transporte = msg[:transporte]
		reboques = transporte[:reboques]
		volumes = transporte[:volumes]
		lacres = volumes[:lacres]

		transporte_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp","xs"=>"http://www.portalfiscal.inf.br/nfe").first
		modalidade_frete_xml_tag = Nokogiri::XML("<modFrete>").elements.first
		grupo_transporta_xml_tag = Nokogiri::XML("<transporta>").elements.first
		grupo_ret_transp_xml_tag = Nokogiri::XML("<retTransp>").elements.first
		grupo_veic_transp_xml_tag = Nokogiri::XML("<veicTransp>").elements.first
		vagao_xml_tag = Nokogiri::XML("<vagao>").elements.first
		balsa_xml_tag = Nokogiri::XML("<balsa>").elements.first

		transporte_xml_tag.add_child(modalidade_frete_xml_tag)
		transporte_xml_tag.add_child(grupo_transporta_xml_tag)
		transporte_xml_tag.add_child(grupo_ret_transp_xml_tag)

		if !transporte[:placa].nil?
			transporte_xml_tag.add_child(grupo_veic_transp_xml_tag)
			
			reboques.each do |reboque|
				reboque_xml_tag = Nokogiri::XML("<reboque>").elements.first
				transporte_xml_tag.add_child(reboque_xml_tag)
			end
		if !transporte[:vagao].nil?
			transporte_xml_tag.add_child(vagao_xml_tag)
		elsif !transporte[:balsa].nil?
			transporte_xml_tag.add_child(balsa_xml_tag)
		end

		volumes.each do |volume|
			volume_xml_tag = Nokogiri::XML("<vol>").elements.first
			transporte_xml_tag.add_child(volume_xml_tag)
		end
	}},	
	{"id"=>"886", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:modFrete", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"887", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:transporta", "lambda" => lambda{|msg,xml|
		cpf_cnpj = msg[:transporte][:cpf_cnpj]
		transporta_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:transporta","xs"=>"http://www.portalfiscal.inf.br/nfe").first
		
		if !transporta_xml_tag.nil?

			if cpf_cnpj.length == 11
				cpf_cnpj_xml_tag = Nokogiri::XML("<CNPJ>").elements.first
			elsif cpf_cnpj.length == 9
				cpf_cnpj_xml_tag = Nokogiri::XML("<CPF>").elements.first
			end
			
			nome_fantasia_xml_tag = Nokogiri::XML("<xNome>").elements.first
			inscricao_estadual_xml_tag = Nokogiri::XML("<IE>").elements.first
			endereco_xml_tag = Nokogiri::XML("<xEnder>").elements.first
			nome_municipio_xml_tag = Nokogiri::XML("<xMun>").elements.first
			uf_transportador_xml_tag = Nokogiri::XML("<UF>").elements.first

			transporta_xml_tag.add_child(cpf_cnpj_xml_tag)
			transporta_xml_tag.add_child(nome_fantasia_xml_tag)
			transporta_xml_tag.add_child(inscricao_estadual_xml_tag)
			transporta_xml_tag.add_child(endereco_xml_tag)
			transporta_xml_tag.add_child(nome_municipio_xml_tag)
			transporta_xml_tag.add_child(uf_transportador_xml_tag)
		end	
	}}
	{"id"=>"888", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:transporta//xs:CNPJ", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"889", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:transporta//xs:CPF", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"890", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:transporta//xs:xNome", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"891", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:transporta//xs:IE", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"892", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:transporta//xs:xEnder", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"893", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:transporta//xs:xMun", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"894", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:transporta//xs:UF", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"895", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:retTransp", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"896", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:retTransp//xs:vServ", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"897", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:retTransp//xs:vBCRet", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"898", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:retTransp//xs:pICMSRet", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"899", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:retTransp//xs:vICMSRet", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"900", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:retTransp//xs:CFOP", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"901", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:retTransp//xs:cMunFG", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"902", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"903", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:veicTransp", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"904", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:veicTransp//xs:placa", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"905", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:veicTransp//xs:UF", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"906", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:veicTransp//xs:RNTC", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"907", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:reboque", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"908", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:reboque//xs:placa", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"909", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:reboque//xs:UF", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"910", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:reboque//xs:RNTC", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"911", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"912", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:vagao", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"913", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"914", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:balsa", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"915", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:vol", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"916", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:vol//xs:qVol", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"917", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:vol//xs:esp", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"918", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:vol//xs:marca", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"919", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:vol//xs:nVol", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"920", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:vol//xs:pesoL", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"921", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:vol//xs:pesoB", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"922", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:vol//xs:lacres", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"923", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:vol//xs:lacres//xs:nLacre", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"924", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:cobr", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"925", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:cobr//xs:fat", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"926", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:cobr//xs:fat//xs:nFat", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"927", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:cobr//xs:fat//xs:vOrig", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"928", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:cobr//xs:fat//xs:vDesc", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"929", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:cobr//xs:fat//xs:vLiq", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"930", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:cobr//xs:dup", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"931", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:cobr//xs:dup//xs:nDup", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"932", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:cobr//xs:dup//xs:dVenc", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"933", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:cobr//xs:dup//xs:vDup", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"934", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:pag", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"935", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:pag//xs:detPag", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"937", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:pag//xs:detPag//xs:tPag", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"938", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:pag//xs:detPag//xs:vPag", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"939", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:pag//xs:detPag//xs:card", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"940", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:pag//xs:detPag//xs:card//xs:tpIntegra", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"941", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:pag//xs:detPag//xs:card//xs:CNPJ", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"942", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:pag//xs:detPag//xs:card//xs:tBand", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"943", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:pag//xs:detPag//xs:card//xs:cAut", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"944", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:pag//xs:vTroco", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"946", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:infIntermed//xs:CNPJ", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"947", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:infIntermed//xs:idCadIntTtran", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"948", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:infAdic", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"949", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:infAdic//xs:infAdFisco", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"950", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:infAdic//xs:infCpl", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"951", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:infAdic//xs:obsCont", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"952", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:infAdic//xs:obsCont//@xCampo", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"953", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:infAdic//xs:obsCont//xs:xTexto", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"954", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:infAdic//xs:obsFisco", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"955", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:infAdic//xs:obsFisco//@xCampo", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"956", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:infAdic//xs:obsFisco//xs:xTexto", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"957", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:infAdic//xs:procRef", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"958", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:infAdic//xs:procRef//xs:nProc", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"959", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:infAdic//xs:procRef//xs:indProc", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"960", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:infAdic//xs:procRef//xs:tpAto", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"961", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:exporta", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"962", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:exporta//xs:UFSaidaPais", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"963", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:exporta//xs:xLocExporta", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"964", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:exporta//xs:xLocDespacho", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"965", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:compra", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"966", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:compra//xs:xNEmp", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"967", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:compra//xs:xPed", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"968", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:compra//xs:xCont", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"969", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:cana", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"970", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:cana//xs:safra", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"971", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:cana//xs:ref", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"972", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:cana//xs:forDia", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"973", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:cana//xs:forDia//@dia", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"974", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:cana//xs:forDia//xs:qtde", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"975", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:cana//xs:qTotMes", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"976", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:cana//xs:qTotAnt", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"977", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:cana//xs:qTotGer", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"978", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:cana//xs:deduc", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"979", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:cana//xs:deduc//xs:xDed", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"980", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:cana//xs:deduc//xs:vDed", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"981", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:cana//xs:vFor", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"982", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:cana//xs:vTotDed", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"983", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:cana//xs:vLiqFor", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"984", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:infRespTec", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"985", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:infRespTec//xs:CNPJ", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"986", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:infRespTec//xs:xContato", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"987", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:infRespTec//xs:email", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"988", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:infRespTec//xs:fone", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"989", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:infRespTec", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"990", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:infRespTec//xs:idCSRT", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"991", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:infRespTec//xs:hashCSRT", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"993", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFeSupl//xs:qrCode", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	{"id"=>"994", "xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFeSupl//xs:urlChave", "lambda" => lambda{|msg,xml|
		produtos = msg[:produtos]

		if !produtos.nil?
			produtos.each_with_index do |produto,index|

			justificativa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:prod//xs:indEscala","xs" => "http://www.portalfiscal.inf.br/nfe").first
			justificativa_xml_tag.content = msg[:justificativa] if !justificativa_xml_tag.nil?
		end
	}},
	#{"id"=>"995", "xpath"=>"//xs:Signature", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"996", "xpath"=>"//xs:Signature//xs:SignedInfo", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"997", "xpath"=>"//xs:Signature//xs:SignedInfo//xs:CanonicalizationMethod", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"998", "xpath"=>"//xs:Signature//xs:SignedInfo//xs:CanonicalizationMethod//@Algorithm", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"999", "xpath"=>"//xs:Signature//xs:SignedInfo//xs:SignatureMethod", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"1000", "xpath"=>"//xs:Signature//xs:SignedInfo//xs:SignatureMethod//@Algorithm", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"1001", "xpath"=>"//xs:Signature//xs:SignedInfo//xs:Reference", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"1002", "xpath"=>"//xs:Signature//xs:SignedInfo//xs:Reference//@URI", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"1003", "xpath"=>"//xs:Signature//xs:SignedInfo//xs:Reference//xs:Transforms", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"1004", "xpath"=>"//xs:Signature//xs:SignedInfo//xs:Reference//xs:Transforms//xs:Transform", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"1005", "xpath"=>"//xs:Signature//xs:SignedInfo//xs:Reference//xs:Transforms//xs:Transform//@Algorithm", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"1007", "xpath"=>"//xs:Signature//xs:SignedInfo//xs:Reference//xs:Transforms//xs:Transform", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"1008", "xpath"=>"//xs:Signature//xs:SignedInfo//xs:Reference//xs:Transforms//xs:Transform//@Algorithm", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"1010", "xpath"=>"//xs:Signature//xs:SignedInfo//xs:Reference//xs:DigestMethod", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"1011", "xpath"=>"//xs:Signature//xs:SignedInfo//xs:Reference//xs:DigestMethod//@Algorithm", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"1012", "xpath"=>"//xs:Signature//xs:SignedInfo//xs:Reference//xs:DigestValue", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"1013", "xpath"=>"//xs:Signature//xs:SignatureValue", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"1014", "xpath"=>"//xs:Signature//xs:KeyInfo", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"1015", "xpath"=>"//xs:Signature//xs:KeyInfo//xs:X509Data", "lambda" => lambda{|msg,xml|}},
	#{"id"=>"1016", "xpath"=>"//xs:Signature//xs:KeyInfo//xs:X509Data//xs:X509Certificate", "lambda" => lambda{|msg,xml|}}]