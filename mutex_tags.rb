module BRNF

	module MutexTags
	
		MUTEX_PARENTS = [
			{
				"id"=>"58",
				"name"=>"infCons",
				"type"=>"G",
				"parent"=>"56",
				"min"=>"1",
				"max"=>"1",
				"regex"=>nil, "namespace"=>nil, "xpath_namespace"=>"http://www.portalfiscal.inf.br/nfe",
				"inferrable"=>"0",
				"xpath"=>"//xs:ConsCad//xs:infCons",
				"message_field"=>nil,
				"children"=>["59",
				"60",
				"61"],
				"attributes"=>[],
				"lambda" => lambda {|msg,map,xml|}
			},
			{
				"id"=>"64",
				"name"=>"distDFeInt",
				"type"=>"Raiz",
				"parent"=>nil, "min"=>nil, "max"=>nil, "regex"=>nil, "namespace"=>"http://www.portalfiscal.inf.br/nfe",
				"xpath_namespace"=>"http://www.portalfiscal.inf.br/nfe",
				"inferrable"=>"0",
				"xpath"=>"//xs:distDFeInt",
				"message_field"=>nil, "children"=>["65",
				"66",
				"67",
				"68",
				"72"], "attributes"=>["65"],
				"lambda" => lambda {|msg,map,xml|}
			},
			{
				"id"=>"81",
				"name"=>"infEvento",
				"type"=>"G",
				"parent"=>"79",
				"min"=>"1",
				"max"=>"1",
				"regex"=>nil, "namespace"=>nil, "xpath_namespace"=>"http://www.portalfiscal.inf.br/nfe",
				"inferrable"=>"0",
				"xpath"=>"//xs:envEvento//xs:evento//xs:infEvento",
				"message_field"=>nil, "children"=>["82",
				"83",
				"84",
				"86",
				"87",
				"88",
				"89",
				"90",
				"91",
				"92"], "attributes"=>["82"]
				"lambda" => lambda {|msg,map,xml|}
			},
			{
				"id"=>"138",
				"name"=>"dest",
				"type"=>"G",
				"parent"=>"92",
				"min"=>"1",
				"max"=>"1",
				"regex"=>nil, "namespace"=>nil, "xpath_namespace"=>"http://www.portalfiscal.inf.br/nfe",
				"inferrable"=>"0",
				"xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest",
				"message_field"=>"destinatario", "children"=>["139",
				"140",
				"143",
				"144",
				"145",
				"146"], "attributes"=>[]
				"lambda" => lambda {|msg,map,xml|}
			},
			{
				"id"=>"158",
				"name"=>"autXML",
				"type"=>"G",
				"parent"=>"92",
				"min"=>"1",
				"max"=>"1",
				"regex"=>nil, "namespace"=>nil, "xpath_namespace"=>"http://www.portalfiscal.inf.br/nfe",
				"inferrable"=>"0",
				"xpath"=>"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:autXML",
				"message_field"=>"autorizacoes", "children"=>["159"], "attributes"=>[]
				"lambda" => lambda {|msg,map,xml|}},
			{
				"id"=>"191",
				"name"=>"NFref",
				"type"=>"G",
				"parent"=>"166",
				"min"=>"0",
				"max"=>"500",
				"regex"=>nil, "namespace"=>nil, "xpath_namespace"=>"http://www.portalfiscal.inf.br/nfe",
				"inferrable"=>"0",
				"xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref",
				"message_field"=>nil, "children"=>["192",
				"193"], "attributes"=>[]
				"lambda" => lambda {|msg,map,xml|}
			},
			{
				"id"=>"200",
				"name"=>"refNFP",
				"type"=>"CG",
				"parent"=>"191",
				"min"=>"1",
				"max"=>"1",
				"regex"=>nil, "namespace"=>nil, "xpath_namespace"=>"http://www.portalfiscal.inf.br/nfe",
				"inferrable"=>"0",
				"xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNFP",
				"message_field"=>nil, "children"=>["201",
				"202",
				"205",
				"206",
				"207",
				"208",
				"209"], "attributes"=>[]
				"lambda" => lambda {|msg,map,xml|}
			},
			{
				"id"=>"214",
				"name"=>"emit",
				"type"=>"G",
				"parent"=>"163",
				"min"=>"1",
				"max"=>"1",
				"regex"=>nil, "namespace"=>nil, "xpath_namespace"=>"http://www.portalfiscal.inf.br/nfe",
				"inferrable"=>"0",
				"xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit",
				"message_field"=>"emissor",
				"children"=>["216",
				"217",
				"218",
				"219",
				"231",
				"232",
				"233",
				"236"], "attributes"=>[]
				"lambda" => lambda {|msg,map,xml|}
			},
			{
				"id"=>"249",
				"name"=>"dest",
				"type"=>"G",
				"parent"=>"163",
				"min"=>"0",
				"max"=>"1",
				"regex"=>nil, "namespace"=>nil, "xpath_namespace"=>"http://www.portalfiscal.inf.br/nfe",
				"inferrable"=>"0",
				"xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest",
				"message_field"=>"destinatario",
				"children"=>["250",
				"253",
				"254",
				"266",
				"267",
				"268",
				"269",
				"270"], "attributes"=>[]
				"lambda" => lambda {|msg,map,xml|}
			},
			{
				"id"=>"271",
				"name"=>"retirada",
				"type"=>"G",
				"parent"=>"163",
				"min"=>"0",
				"max"=>"1",
				"regex"=>nil, "namespace"=>nil, "xpath_namespace"=>"http://www.portalfiscal.inf.br/nfe",
				"inferrable"=>"0",
				"xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:retirada",
				"message_field"=>"retirada",
				"children"=>["272",
				"275",
				"276",
				"277",
				"278",
				"279",
				"280",
				"281"], "attributes"=>[]
				"lambda" => lambda {|msg,map,xml|}
			},
			{
				"id"=>"288",
				"name"=>"entrega",
				"type"=>"G",
				"parent"=>"163",
				"min"=>"0",
				"max"=>"1",
				"regex"=>nil, "namespace"=>nil, "xpath_namespace"=>"http://www.portalfiscal.inf.br/nfe",
				"inferrable"=>"0",
				"xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:entrega",
				"message_field"=>"entrega",
				"children"=>["290",
				"292",
				"293",
				"294",
				"295",
				"296",
				"297",
				"298"], "attributes"=>[]
				"lambda" => lambda {|msg,map,xml|}
			},
			{
				"id"=>"305",
				"name"=>"autXML",
				"type"=>"G",
				"parent"=>"163",
				"min"=>"0",
				"max"=>"10",
				"regex"=>nil, "namespace"=>nil, "xpath_namespace"=>"http://www.portalfiscal.inf.br/nfe",
				"inferrable"=>"0",
				"xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:autXML",
				"message_field"=>"autorizacoes",
				"children"=>["306"], "attributes"=>[]
				"lambda" => lambda {|msg,map,xml|}
			},
			{
				"id"=>"310",
				"name"=>"prod",
				"type"=>"G",
				"parent"=>"308",
				"min"=>"1",
				"max"=>"1",
				"regex"=>nil, "namespace"=>nil, "xpath_namespace"=>"http://www.portalfiscal.inf.br/nfe",
				"inferrable"=>"0",
				"xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod",
				"message_field"=>nil, "children"=>["311",
				"312",
				"313",
				"314",
				"315",
				"321",
				"322",
				"323",
				"324",
				"325",
				"326",
				"327",
				"328",
				"329",
				"330",
				"331",
				"332",
				"333",
				"334",
				"335",
				"336",
				"354",
				"360",
				"361",
				"362",
				"363",
				"372"], "attributes"=>[]
				"lambda" => lambda {|msg,map,xml|}
			},
			{
				"id"=>"434",
				"name"=>"imposto",
				"type"=>"G",
				"parent"=>"308",
				"min"=>"1",
				"max"=>"1",
				"regex"=>nil, "namespace"=>nil, "xpath_namespace"=>"http://www.portalfiscal.inf.br/nfe",
				"inferrable"=>"0",
				"xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto",
				"message_field"=>"imposto",
				"children"=>["435",
				"436",
				"764",
				"786",
				"794",
				"816",
				"824"], "attributes"=>[]
				"lambda" => lambda {|msg,map,xml|}
			},
			{
				"id"=>"437",
				"name"=>"ICMS",
				"type"=>"G",
				"parent"=>"436",
				"min"=>"1",
				"max"=>"1",
				"regex"=>nil, "namespace"=>nil, "xpath_namespace"=>"http://www.portalfiscal.inf.br/nfe",
				"inferrable"=>"0",
				"xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS",
				"message_field"=>"icms",
				"children"=>["472"], "attributes"=>[]
				"lambda" => lambda {|msg,map,xml|}
			},
			{
				"id"=>"707",
				"name"=>"IPI",
				"type"=>"G",
				"parent"=>"436",
				"min"=>"0",
				"max"=>"1",
				"regex"=>nil, "namespace"=>nil, "xpath_namespace"=>"http://www.portalfiscal.inf.br/nfe",
				"inferrable"=>"0",
				"xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI",
				"message_field"=>"ipi",
				"children"=>["709",
				"710",
				"711",
				"712",
				"722"], "attributes"=>[]
				"lambda" => lambda {|msg,map,xml|}
			},
			{
				"id"=>"713",
				"name"=>"IPITrib",
				"type"=>"CG",
				"parent"=>"707",
				"min"=>"1",
				"max"=>"1",
				"regex"=>nil, "namespace"=>nil, "xpath_namespace"=>"http://www.portalfiscal.inf.br/nfe",
				"inferrable"=>"0",
				"xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:IPITrib",
				"message_field"=>nil, "children"=>["714",
				"715",
				"721"], "attributes"=>[]
				"lambda" => lambda {|msg,map,xml|}
			},
			{
				"id"=>"736",
				"name"=>"IPITrib",
				"type"=>"CG",
				"parent"=>"730",
				"min"=>"1",
				"max"=>"1",
				"regex"=>nil, "namespace"=>nil, "xpath_namespace"=>nil, "inferrable"=>"0",
				"xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:IPITrib",
				"message_field"=>nil, "children"=>["737",
				"741",
				"744"], "attributes"=>[]
				"lambda" => lambda {|msg,map,xml|}
			},
			{
				"id"=>"764",
				"name"=>"PIS",
				"type"=>"G",
				"parent"=>"434",
				"min"=>"0",
				"max"=>"1",
				"regex"=>nil, "namespace"=>nil, "xpath_namespace"=>"http://www.portalfiscal.inf.br/nfe",
				"inferrable"=>"0",
				"xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS",
				"message_field"=>"pis",
				"children"=>["765"], "attributes"=>[]
				"lambda" => lambda {|msg,map,xml|}
			},
			{
				"id"=>"777",
				"name"=>"PISOutr",
				"type"=>"CG",
				"parent"=>"764",
				"min"=>"1",
				"max"=>"1",
				"regex"=>nil, "namespace"=>nil, "xpath_namespace"=>"http://www.portalfiscal.inf.br/nfe",
				"inferrable"=>"0",
				"xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISOutr",
				"message_field"=>nil, "children"=>["778",
				"782",
				"785"], "attributes"=>[]
				"lambda" => lambda {|msg,map,xml|}
			},
			{
				"id"=>"786",
				"name"=>"PISST",
				"type"=>"G",
				"parent"=>"434",
				"min"=>"0",
				"max"=>"1",
				"regex"=>nil, "namespace"=>nil, "xpath_namespace"=>"http://www.portalfiscal.inf.br/nfe",
				"inferrable"=>"0",
				"xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PISST",
				"message_field"=>nil, "children"=>["790",
				"793"], "attributes"=>[]
				"lambda" => lambda {|msg,map,xml|}
			},
			{
				"id"=>"794",
				"name"=>"COFINS",
				"type"=>"G",
				"parent"=>"434",
				"min"=>"0",
				"max"=>"1",
				"regex"=>nil, "namespace"=>nil, "xpath_namespace"=>"http://www.portalfiscal.inf.br/nfe",
				"inferrable"=>"0",
				"xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS",
				"message_field"=>"cofins",
				"children"=>["807"], "attributes"=>[]
				"lambda" => lambda {|msg,map,xml|}
			},
			{
				"id"=>"807",
				"name"=>"COFINSOutr",
				"type"=>"CG",
				"parent"=>"794",
				"min"=>"1",
				"max"=>"1",
				"regex"=>nil, "namespace"=>nil, "xpath_namespace"=>"http://www.portalfiscal.inf.br/nfe",
				"inferrable"=>"0",
				"xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSOutr",
				"message_field"=>nil, "children"=>["808",
				"809",
				"815"], "attributes"=>[]
				"lambda" => lambda {|msg,map,xml|}
			},
			{
				"id"=>"816",
				"name"=>"COFINSST",
				"type"=>"G",
				"parent"=>"434",
				"min"=>"0",
				"max"=>"1",
				"regex"=>nil, "namespace"=>nil, "xpath_namespace"=>"http://www.portalfiscal.inf.br/nfe",
				"inferrable"=>"0",
				"xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINSST",
				"message_field"=>nil, "children"=>["820",
				"823"], "attributes"=>[]
				"lambda" => lambda {|msg,map,xml|}
			},
			{
				"id"=>"887",
				"name"=>"transporta",
				"type"=>"G",
				"parent"=>"885",
				"min"=>"0",
				"max"=>"1",
				"regex"=>nil, "namespace"=>nil, "xpath_namespace"=>"http://www.portalfiscal.inf.br/nfe",
				"inferrable"=>"0",
				"xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:transporta",
				"message_field"=>nil, "children"=>["889",
				"890",
				"891",
				"892",
				"893",
				"894"], "attributes"=>[]
				"lambda" => lambda {|msg,map,xml|}
			},
			{
				"id"=>"885",
				"name"=>"transp",
				"type"=>"G",
				"parent"=>"163",
				"min"=>"1",
				"max"=>"1",
				"regex"=>nil, "namespace"=>nil, "xpath_namespace"=>"http://www.portalfiscal.inf.br/nfe",
				"inferrable"=>"0",
				"xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp",
				"message_field"=>"transporte",
				"children"=>["886",
				"887",
				"895",
				"913",
				"915"], "attributes"=>[]
				"lambda" => lambda {|msg,map,xml|}
			},
			{
				"id"=>"911",
				"name"=>"grupo_vagao",
				"type"=>"CGO",
				"parent"=>"885",
				"min"=>"0",
				"max"=>"1",
				"regex"=>nil, "namespace"=>nil, "xpath_namespace"=>"http://www.portalfiscal.inf.br/nfe",
				"inferrable"=>"0",
				"xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp",
				"message_field"=>nil, "children"=>["912"], "attributes"=>[]
				"lambda" => lambda {|msg,map,xml|}
			},
			{
				"id"=>"913",
				"name"=>"grupo_balsa",
				"type"=>"CGO",
				"parent"=>"885",
				"min"=>"0",
				"max"=>"1",
				"regex"=>nil, "namespace"=>nil, "xpath_namespace"=>"http://www.portalfiscal.inf.br/nfe",
				"inferrable"=>"0",
				"xpath"=>"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp",
				"message_field"=>nil, "children"=>["914"], "attributes"=>[]}
				"lambda" => lambda {|msg,map,xml|}
		]

	end


	MUTEX_PARENTS_IDS = [
		{"id"=>"58","lambda" => lambda{|msg,map,xml| 
			cpf_cnpj = msg[:cpf_cnpj]
			ie = msg[:inscricao_estadual]

			if ie.nil?
				if cpf_cnpj.length == 9
					child = Nokogiri::XML("<CPF>").elements.first
					parent = map.get_tag(map.get_tag("63")["parent"])
					cnpj_tag = map.get_tag("62")
					cnpj_xml_tag = xml.xpath("#{cnpj_tag["xpath"]}","xs" => "#{cnpj_tag["xpath_namespace"]}").first
					cnpj_xml_tag.remove if !cnpj_xml_tag.nil?
				elsif cpf_cnpj.length == 11
					child = Nokogiri::XML("<CNPJ>").elements.first
					parent = map.get_tag(map.get_tag("62")["parent"])
					cpf_tag = map.get_tag("63")
					cpf_xml_tag = xml.xpath("#{cpf_tag["xpath"]}","xs" => "#{cpf_tag["xpath_namespace"]}").first
					cpf_xml_tag.remove if !cpf_xml_tag.nil?
				end

				inscricao_estadual_tag = map.get_tag('61')
				inscricao_estadual_xml_tag = xml.xpath("#{inscricao_estadual_tag["xpath"]}","xs" => "#{inscricao_estadual_tag["xpath_namespace"]}").first
				inscricao_estadual_xml_tag.remove if !inscricao_estadual_xml_tag.nil?
			else
				child = Nokogiri::XML("<IE>").elements.first
				parent = map.get_tag(map.get_tag("61")["parent"])
				
				cpf = map.get_tag("63")
				cpf = xml.xpath("#{cpf["xpath"]}","xs" => "#{cpf["xpath_namespace"]}").first
				cpf.remove if !cpf.nil?
				
				cnpj = map.get_tag("62")
				cnpj = xml.xpath("#{cnpj["xpath"]}","xs" => "#{cnpj["xpath_namespace"]}").first
				cnpj.remove if !cnpj.nil?
			end

			child.content = cpf_cnpj if ie.nil?
			child.content = ie if cpf_cnpj.nil?
			parent_xml_tag = xml.xpath("#{parent["xpath"]}","xs" => "#{parent["xpath_namespace"]}").first
			parent_xml_tag.add_child(child) if !parent_xml_tag.nil?
		}}
		{"id"=>"64","lambda" => lambda{|msg,map,xml| 
			cpf_cnpj = msg[:cpf_cnpj]
			ultimo_nsu = msg[:ultimo_nsu]
			chave_nota = msg[:chave_nota]
			consulta_nsu = msg[:consulta_nsu]

			if cpf_cnpj.length == 9
				child = Nokogiri::XML("<CPF>").elements.first
				parent = map.get_tag(map.get_tag("69")["parent"])
				cnpj_tag = map.get_tag("68")
				cnpj_xml_tag = xml.xpath("#{cnpj_tag["xpath"]}","xs" => "#{cnpj_tag["xpath_namespace"]}").first
				cnpj_xml_tag.remove if !cnpj_xml_tag.nil?
			elsif cpf_cnpj.length == 11
				child = Nokogiri::XML("<CNPJ>").elements.first
				parent = map.get_tag(map.get_tag("68")["parent"])
				cpf_tag = map.get_tag("69")
				cpf_xml_tag = xml.xpath("#{cpf_tag["xpath"]}","xs" => "#{cpf_tag["xpath_namespace"]}").first
				cpf_xml_tag.remove if !cpf_xml_tag.nil?
			end

			child.content = cpf_cnpj
			parent_xml_tag = xml.xpath("#{parent["xpath"]}","xs" => "#{parent["xpath_namespace"]}").first
			parent_xml_tag.add_child(child) if !parent_xml_tag.nil?

			dist_nsu_tag = map.get_tag('70') 
			cons_nsu_tag = map.get_tag('72') 
			cons_chnfe_tag = map.get_tag('74') 

			if !ultimo_nsu.nil? and consulta_nsu.nil? and chave_nota.nil?
				dist_nsu = Nokogiri::XML("<distNSU>").elements.first
				ult_nsu = Nokogiri::XML("<ultNSU>").elements.first
				ult_nsu.content = ultimo_nsu
				dist_nsu.add_child(ult_nsu)
				dist_nsu_parent = map.get_tag(map.get_tag("70")["parent"])
				dist_nsu_parent_xml_tag = xml.xpath("#{dist_nsu_parent["xpath"]}","xs" => "#{dist_nsu_parent["xpath_namespace"]}").first
				dist_nsu_parent_xml_tag.add_child(dist_nsu) if !dist_nsu_parent_xml_tag.nil?

				cons_nsu_xml_tag = xml.xpath("#{cons_nsu_tag["xpath"]}","xs" => "#{cons_nsu_tag["xpath_namespace"]}").first
				cons_nsu_xml_tag.remove if !cons_nsu_xml_tag.nil?
				
				cons_chnfe_xml_tag = xml.xpath("#{cons_chnfe_tag["xpath"]}","xs" => "#{cons_chnfe_tag["xpath_namespace"]}").first
				cons_chnfe_xml_tag.remove if !cons_chnfe_xml_tag.nil?
			elsif ultimo_nsu.nil? and !consulta_nsu.nil? and chave_nota.nil?
				cons_nsu = Nokogiri::XML("<consNSU>").elements.first
				nsu = Nokogiri::XML("<NSU>").elements.first
				nsu.content = consulta_nsu
				cons_nsu.add_child(cons_nsu)
				cons_nsu_parent = map.get_tag(map.get_tag("72")["parent"])
				cons_nsu_parent_xml_tag = xml.xpath("#{cons_nsu_parent["xpath"]}","xs" => "#{cons_nsu_parent["xpath_namespace"]}").first
				cons_nsu_parent_xml_tag.add_child(cons_nsu) if !cons_nsu_parent_xml_tag.nil?

				dist_nsu_xml_tag = xml.xpath("#{dist_nsu_tag["xpath"]}","xs" => "#{dist_nsu_tag["xpath_namespace"]}").first
				dist_nsu_xml_tag.remove if !cons_nsu_xml_tag.nil?
				
				cons_chnfe_xml_tag = xml.xpath("#{cons_chnfe_tag["xpath"]}","xs" => "#{cons_chnfe_tag["xpath_namespace"]}").first
				cons_chnfe_xml_tag.remove if !cons_chnfe_xml_tag.nil?
			elsif ultimo_nsu.nil? and consulta_nsu.nil? and !chave_nota.nil?
				cons_chnfe = Nokogiri::XML("<conChNFe>").elements.first
				chnfe = Nokogiri::XML("<chNFe>").elements.first
				chnfe.content = chnfe
				cons_chnfe.add_child(chnfe)
				cons_chnfe_parent = map.get_tag(map.get_tag("74")["parent"])
				cons_chnfe_parent_xml_tag = xml.xpath("#{cons_chnfe_parent["xpath"]}","xs" => "#{cons_chnfe_parent["xpath_namespace"]}").first
				cons_chnfe_parent_xml_tag.add_child(cons_chnfe) if !cons_chnfe_parent_xml_tag.nil?

				cons_nsu_xml_tag = xml.xpath("#{cons_nsu_tag["xpath"]}","xs" => "#{cons_nsu_tag["xpath_namespace"]}").first
				cons_nsu_xml_tag.remove if !cons_nsu_xml_tag.nil?
				
				dist_nsu_xml_tag = xml.xpath("#{dist_nsu_tag["xpath"]}","xs" => "#{dist_nsu_tag["xpath_namespace"]}").first
				dist_nsu_xml_tag.remove if !dist_nsu_xml_tag.nil?
			end
		}}
		{"id"=>"81","lambda" => lambda{|msg,map,xml| 
			cpf_cnpj = msg[:cpf_cnpj]

			if cpf_cnpj.length == 9
				child = Nokogiri::XML("<CPF>").elements.first
				parent = map.get_tag(map.get_tag("86")["parent"])
				cnpj = map.get_tag("85")
				cnpj = xml.xpath("#{cnpj["xpath"]}","xs" => "#{cnpj["xpath_namespace"]}").first
				cnpj.remove if !cnpj.nil?
			elsif cpf_cnpj.length == 11
				child = Nokogiri::XML("<CNPJ>").elements.first
				parent = map.get_tag(map.get_tag("85")["parent"])
				cpf = map.get_tag("86")
				cpf = xml.xpath("#{cpf["xpath"]}","xs" => "#{cpf["xpath_namespace"]}").first
				cpf.remove if !cpf.nil?
			end

			child.content = cpf_cnpj
			parent_xml_tag = xml.xpath("#{parent["xpath"]}","xs" => "#{parent["xpath_namespace"]}").first
			parent_xml_tag.add_child(child) if !parent_xml_tag.nil?
		}}
		{"id"=>"138","lambda" => lambda{|msg,map,xml| 
			cpf_cnpj = msg[:cpf_cnpj]
			id_estrangeiro = msg[:id_estrangeiro]

			if id_estrangeiro.nil?
				if cpf_cnpj.length == 9
					child = Nokogiri::XML("<CPF>").elements.first
					parent = map.get_tag(map.get_tag("141")["parent"])

					cnpj_tag = map.get_tag("140")
					cnpj_xml_tag = xml.xpath("#{cnpj_tag["xpath"]}","xs" => "#{cnpj_tag["xpath_namespace"]}").first
					cnpj_xml_tag.remove if !cnpj_xml_tag.nil?

					id_estrangeiro_tag = map.get_tag("142")
					id_estrangeiro__xml_tag = xml.xpath("#{id_estrangeiro_tag["xpath"]}","xs" => "#{id_estrangeiro_tag["xpath_namespace"]}").first
					id_estrangeiro_xml_tag.remove if !id_estrangeiro_xml_tag.nil?
				elsif cpf_cnpj.length == 11
					child = Nokogiri::XML("<CNPJ>").elements.first
					parent = map.get_tag(map.get_tag("140")["parent"])

					cpf_tag = map.get_tag("141")
					cpf_xml_tag = xml.xpath("#{cpf_tag["xpath"]}","xs" => "#{cpf_tag["xpath_namespace"]}").first
					cpf_xml_tag.remove if !cpf_xml_tag.nil?

					id_estrangeiro_tag = map.get_tag("142")
					id_estrangeiro__xml_tag = xml.xpath("#{id_estrangeiro_tag["xpath"]}","xs" => "#{id_estrangeiro_tag["xpath_namespace"]}").first
					id_estrangeiro_xml_tag.remove if !id_estrangeiro_xml_tag.nil?
				end
			else
				child = Nokogiri::XML("<idEstrangeiro>").elements.first
				parent = map.get_tag(map.get_tag("142")["parent"])

				cnpj_tag = map.get_tag("140")
				cnpj_xml_tag = xml.xpath("#{cnpj_tag["xpath"]}","xs" => "#{cnpj_tag["xpath_namespace"]}").first
				cnpj_xml_tag.remove if !cnpj_xml_tag.nil?

				cpf_tag = map.get_tag("141")
				cpf_xml_tag = xml.xpath("#{cpf_tag["xpath"]}","xs" => "#{cpf_tag["xpath_namespace"]}").first
				cpf_xml_tag.remove if !cpf_xml_tag.nil?
			end

			child.content = cpf_cnpj if id_estrangeiro.nil?
			child.content = id_estrangeiro if cpf_cnpj.nil?
			parent_xml_tag = xml.xpath("#{parent["xpath"]}","xs" => "#{parent["xpath_namespace"]}").first
			parent_xml_tag.add_child(child) if !parent_xml_tag.nil?
		}}
		{"id"=>"158","lambda" => lambda{|msg,map,xml| 
			cpf_cnpj = msg[:cpf_cnpj]

			if cpf_cnpj.length == 9
				child = Nokogiri::XML("<CPF>").elements.first
				parent = map.get_tag(map.get_tag("160")["parent"])
				cnpj = map.get_tag("159")
				cnpj = xml.xpath("#{cnpj["xpath"]}","xs" => "#{cnpj["xpath_namespace"]}").first
				cnpj.remove if !cnpj.nil?
			elsif cpf_cnpj.length == 11
				child = Nokogiri::XML("<CNPJ>").elements.first
				parent = map.get_tag(map.get_tag("159")["parent"])
				cpf = map.get_tag("160")
				cpf = xml.xpath("#{cpf["xpath"]}","xs" => "#{cpf["xpath_namespace"]}").first
				cpf.remove if !cpf.nil?
			end

			child.content = cpf_cnpj
			parent_xml_tag = xml.xpath("#{parent["xpath"]}","xs" => "#{parent["xpath_namespace"]}").first
			parent_xml_tag.add_child(child) if !parent_xml_tag.nil?
		}}
		{"id"=>"191","lambda" => lambda{|msg,map,xml| 
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

			refnfe_tag = map.get_tag('192')
			refnf_tag = map.get_tag('193')
			refnfp_tag = map.get_tag('200')
			refcte_tag = map.get_tag('209')
			refecf_tag = map.get_tag('210')

			if refnfe_present
				refnfe_tag_xml = xml.xpath("#{refnfe_tag["xpath"]}","xs"=>"#{refnfe_tag["xpath_namespace"]}").first
				
				if !refnfe_xml_tag.nil?
					refnfe_xml_tag.content = chave_nota
				else
					refnfe_xml_tag = Nokogiri::XML("<refNFe>").elements.first
					refnfe_xml_tag.content = chave_nota
					parent_tag = map.get_tag('191')
					parent_xml_tag = xml.xpath("#{parent_tag["xpath"]}","xs" => "#{parent_tag["xpath_namespace"]}").first
					parent_xml_tag.add_child(refnfe_xml_tag) if !parent_xml_tag.nil?
				end

				refnf_xml_tag = xml.xpath("#{refnf_tag["xpath"]}","xs" => "#{refnf_tag["xpath_namespace"]}").first
				refnfp_xml_tag = xml.xpath("#{refnfp_tag["xpath"]}","xs" => "#{refnfp_tag["xpath_namespace"]}").first
				refcte_xml_tag = xml.xpath("#{refcte_tag["xpath"]}","xs" => "#{refcte_tag["xpath_namespace"]}").first
				refecf_xml_tag = xml.xpath("#{refnfp_tag["xpath"]}","xs" => "#{refecf_tag["xpath_namespace"]}").first
			
				refnf_xml_tag.remove if !refnf_xml_tag.nil?
				refnfp_xml_tag.remove if !refnfp_xml_tag.nil?
				refcte_xml_tag.remove if !refcte_xml_tag.nil?
				refecf_xml_tag.remove if !refecf_xml_tag.nil?
			elsif refnf_present
				refnf_tag_xml = xml.xpath("#{refnf_tag["xpath"]}","xs"=>"#{refnf_tag["xpath_namespace"]}").first
				
				codigo_uf_tag = map.get_tag('194')
				ano_mes_tag = map.get_tag('195')
				cpf_cnpj_tag = map.get_tag('196') 
				modelo_tag = map.get_tag('197')
				serie_tag = map.get_tag('198')
				numero_documento_tag = map.get_tag('199')

				if !refnf_xml_tag.nil?
					codigo_uf_xml_tag = xml.xpath("#{codigo_uf_tag["xpath"]}","xs" => "#{codigo_uf_tag["xpath_namespace"]}").first
					ano_mes_xml_tag = xml.xpath("#{ano_mes_tag["xpath"]}","xs" => "#{ano_mes_tag["xpath_namespace"]}").first
					cpf_cnpj_xml_tag = xml.xpath("#{cpf_cnpj_tag["xpath"]}","xs" => "#{cpf_cnpj_tag["xpath_namespace"]}").first
					modelo_xml_tag = xml.xpath("#{modelo_tag["xpath"]}","xs" => "#{modelo_tag["xpath_namespace"]}").first
					serie_xml_tag = xml.xpath("#{serie_tag["xpath"]}","xs" => "#{serie_tag["xpath_namespace"]}").first
					numero_documento_xml_tag = xml.xpath("#{numero_documento_tag["xpath"]}","xs" => "#{numero_documento_tag["xpath_namespace"]}").first
				end

				some_tag_is_missing = codigo_uf_xml_tag.nil? or ano_mes_xml_tag.nil? or cpf_cnpj_tag.nil? or modelo_xml_tag.nil? or serie_xml_tag.nil? or numero_documento_xml_tag.nil?

				if some_tag_is_missing
					codigo_uf_xml_tag.remove if !codigo_uf_xml_tag.nil?
					ano_mes_xml_tag.remove if !ano_mes_xml_tag.nil?
					cpf_cnpj_xml_tag.remove if !cpf_cnpj_xml_tag.nil?
					modelo_xml_tag.remove if !modelo_xml_tag.nil?
					serie_xml_tag.remove if !serie_xml_tag.nil?
					numero_documento_xml_tag.remove if !numero_documento_xml_tag.nil?

					codigo_uf_xml_tag = Nokogiri::XML("<cUF>").elements.first
					ano_mes_xml_tag = Nokogiri::XML("<AAMM>").elements.first
					cpf_cnpj_xml_tag = Nokogiri::XML("<CNPJ>").elements.first
					modelo_xml_tag = Nokogiri::XML("<mod>").elements.first
					serie_xml_tag = Nokogiri::XML("<serie>").elements.first
					numero_documento_xml_tag = Nokogiri::XML("<nNF>").elements.first
				end

				codigo_uf_xml_tag.content = codigo_uf
				ano_mes_xml_tag.content = ano_mes
				cpf_cnpj_xml_tag.content = cpf_cnpj
				modelo_xml_tag.content = modelo
				serie_xml_tag.content = serie
				numero_documento_xml_tag.content = numero_documento

				refnf_xml_tag = Nokogiri::XML("<refNFe>").elements.first if refnf_xml_tag.nil?

				refnf_xml_tag.add_child(codigo_uf_xml_tag)
				refnf_xml_tag.add_child(ano_mes_xml_tag)
				refnf_xml_tag.add_child(cpf_cnpj_xml_tag)
				refnf_xml_tag.add_child(modelo_xml_tag)
				refnf_xml_tag.add_child(serie_xml_tag)
				refnf_xml_tag.add_child(numero_documento_xml_tag)

				refnf_parent_tag = map.get_tag('191')
				refnf_parent_xml_tag = xml.xpath("#{refnf_parent_tag["xpath"]}","xs" => "#{refnf_parent_tag["xpath_namespace"]}").first
				refnf_parent_xml_tag.add_child(refnf_xml_tag)

				refnfe_xml_tag = xml.xpath("#{refnfe_tag["xpath"]}","xs" => "#{refnfe_tag["xpath_namespace"]}").first
				refnfp_xml_tag = xml.xpath("#{refnfp_tag["xpath"]}","xs" => "#{refnfp_tag["xpath_namespace"]}").first
				refcte_xml_tag = xml.xpath("#{refcte_tag["xpath"]}","xs" => "#{refcte_tag["xpath_namespace"]}").first
				refecf_xml_tag = xml.xpath("#{refecf_tag["xpath"]}","xs" => "#{refecf_tag["xpath_namespace"]}").first
			
				refnfe_xml_tag.remove if !refnfe_xml_tag.nil?
				refnfp_xml_tag.remove if !refnfp_xml_tag.nil?
				refcte_xml_tag.remove if !refcte_xml_tag.nil?
				refecf_xml_tag.remove if !refecf_xml_tag.nil?
			elsif refnfp_present
				refnfp_tag_xml = xml.xpath("#{refnfp_tag["xpath"]}","xs"=>"#{refnfp_tag["xpath_namespace"]}").first
				
				codigo_uf_tag = map.get_tag('201')
				ano_mes_tag = map.get_tag('202')
				cpf_cnpj_tag = (!cpf_cnpj.nil? and cpf_cnpj.length == 11) ? map.get_tag('203') : map.get_tag('204')
				ie_tag = map.get_tag('205')
				modelo_tag = map.get_tag('206')
				serie_tag = map.get_tag('207')
				numero_documento_tag = map.get_tag('208')

				if !refnfp_xml_tag.nil?
					codigo_uf_xml_tag = xml.xpath("#{codigo_uf_tag["xpath"]}","xs" => "#{codigo_uf_tag["xpath_namespace"]}").first
					ano_mes_xml_tag = xml.xpath("#{ano_mes_tag["xpath"]}","xs" => "#{ano_mes_tag["xpath_namespace"]}").first
					cpf_cnpj_xml_tag = xml.xpath("#{cpf_cnpj_tag["xpath"]}","xs" => "#{cpf_cnpj_tag["xpath_namespace"]}").first
					ie_xml_tag = xml.xpath("#{ie_tag["xpath"]}","xs" => "#{ie_tag["xpath_namespace"]}").first
					modelo_xml_tag = xml.xpath("#{modelo_tag["xpath"]}","xs" => "#{modelo_tag["xpath_namespace"]}").first
					serie_xml_tag = xml.xpath("#{serie_tag["xpath"]}","xs" => "#{serie_tag["xpath_namespace"]}").first
					numero_documento_xml_tag = xml.xpath("#{numero_documento_tag["xpath"]}","xs" => "#{numero_documento_tag["xpath_namespace"]}").first
				end

				some_tag_is_missing = codigo_uf_xml_tag.nil? or ano_mes_xml_tag.nil? or cpf_cnpj_tag.nil? or ie_xml_tag.nil? or modelo_xml_tag.nil? or serie_xml_tag.nil? or chave_cte_xml_tag.nil? or numero_documento_xml_tag.nil?

				if some_tag_is_missing
					codigo_uf_xml_tag.remove if !codigo_uf_xml_tag.nil?
					ano_mes_xml_tag.remove if !ano_mes_xml_tag.nil?
					cpf_cnpj_xml_tag.remove if !cpf_cnpj_xml_tag.nil?
					ie_xml_tag.remove if !ie_xml_tag.nil?
					modelo_xml_tag.remove if !modelo_xml_tag.nil?
					serie_xml_tag.remove if !serie_xml_tag.nil?
					numero_documento_xml_tag.remove if !numero_documento_xml_tag.nil?

					codigo_uf_xml_tag = Nokogiri::XML("<cUF>").elements.first
					ano_mes_xml_tag = Nokogiri::XML("<AAMM>").elements.first
					cpf_cnpj_xml_tag = Nokogiri::XML("<CNPJ>").elements.first
					ie_xml_tag = Nokogiri::XML("<IE>").elements.first 
					modelo_xml_tag = Nokogiri::XML("<mod>").elements.first
					serie_xml_tag = Nokogiri::XML("<serie>").elements.first
					numero_documento_xml_tag = Nokogiri::XML("<nNF>").elements.first
				end

				codigo_uf_xml_tag.content = codigo_uf
				ano_mes_xml_tag.content = ano_mes
				cpf_cnpj_xml_tag.content = cpf_cnpj
				ie_xml_tag = inscricao_estadual
				modelo_xml_tag.content = modelo
				serie_xml_tag.content = serie
				numero_documento_xml_tag.content = numero_documento

				refnfp_xml_tag = Nokogiri::XML("<refNFP>").elements.first if refnfp_xml_tag.nil?

				refnfp_xml_tag.add_child(codigo_uf_xml_tag)
				refnfp_xml_tag.add_child(ano_mes_xml_tag)
				refnfp_xml_tag.add_child(cpf_cnpj_xml_tag)
				refnfp_xml_tag.add_child(ie_xml_tag)
				refnfp_xml_tag.add_child(modelo_xml_tag)
				refnfp_xml_tag.add_child(serie_xml_tag)
				refnfp_xml_tag.add_child(numero_documento_xml_tag)

				refnfp_parent_tag = map.get_tag('191')
				refnfp_parent_xml_tag = xml.xpath("#{refnfp_parent_tag["xpath"]}","xs" => "#{refnfp_parent_tag["xpath_namespace"]}").first
				refnfp_parent_xml_tag.add_child(refnfp_xml_tag)

				refnfe_xml_tag = xml.xpath("#{refnfe_tag["xpath"]}","xs" => "#{refnfe_tag["xpath_namespace"]}").first
				refnf_xml_tag = xml.xpath("#{refnf_tag["xpath"]}","xs" => "#{refnf_tag["xpath_namespace"]}").first
				refcte_xml_tag = xml.xpath("#{refcte_tag["xpath"]}","xs" => "#{refcte_tag["xpath_namespace"]}").first
				refecf_xml_tag = xml.xpath("#{refecf_tag["xpath"]}","xs" => "#{refecf_tag["xpath_namespace"]}").first

				refnfe_xml_tag.remove if !refnfe_xml_tag.nil?
				refnf_xml_tag.remove if !refnf_xml_tag.nil?
				refcte_xml_tag.remove if !refcte_xml_tag.nil?
				refecf_xml_tag.remove if !refecf_xml_tag.nil?
			elsif refcte_present
				refcte_tag_xml = xml.xpath("#{refcte_tag["xpath"]}","xs"=>"#{refcte_tag["xpath_namespace"]}").first
				
				if !refcte_xml_tag.nil?
					refcte_xml_tag.content = chave_cte
				else
					refcte_xml_tag = Nokogiri::XML("<refCTe>").elements.first
					refcte_xml_tag.content = chave_cte
					parent_tag = map.get_tag('191')
					parent_xml_tag = xml.xpath("#{parent_tag["xpath"]}","xs" => "#{parent_tag["xpath_namespace"]}").first
					parent_xml_tag.add_child(refcte_xml_tag) if !parent_xml_tag.nil?
				end

				refnfe_xml_tag = xml.xpath("#{refnfe_tag["xpath"]}","xs" => "#{refnfe_tag["xpath_namespace"]}").first
				refnf_xml_tag = xml.xpath("#{refnf_tag["xpath"]}","xs" => "#{refnf_tag["xpath_namespace"]}").first
				refnfp_xml_tag = xml.xpath("#{refnfp_tag["xpath"]}","xs" => "#{refnfp_tag["xpath_namespace"]}").first
				refecf_xml_tag = xml.xpath("#{refecf_tag["xpath"]}","xs" => "#{refecf_tag["xpath_namespace"]}").first
			
				refnfe_xml_tag.remove if !refnfe_xml_tag.nil?
				refnf_xml_tag.remove if !refnf_xml_tag.nil?
				refnfp_xml_tag.remove if !refnfp_xml_tag.nil?
				refecf_xml_tag.remove if !refecf_xml_tag.nil?
			elsif refecf_present
				refecf_xml_tag = xml.xpath("#{refecf_tag["xpath"]}","xs"=>"#{refecf_tag["xpath_namespace"]}").first
				
				modelo_tag = map.get_tag('211')
				numero_ecf_tag = map.get_tag('212')
				numero_coo_tag = map.get_tag('213')

				if !refecf_xml_tag.nil?
					modelo_xml_tag = xml.xpath("#{modelo_tag["xpath"]}","xs" => "#{modelo_tag["xpath_namespace"]}").first
					numero_ecf_xml_tag = xml.xpath("#{numero_ecf_tag["xpath"]}","xs" => "#{numero_ecf_tag["xpath_namespace"]}").first
					numero_coo_xml_tag = xml.xpath("#{numero_coo_tag["xpath"]}","xs" => "#{numero_coo_tag["xpath_namespace"]}").first
				end

				some_tag_is_missing = modelo_xml_tag.nil? or numero_ecf_xml_tag.nil? or numero_coo_xml_tag.nil?

				if some_tag_is_missing
					modelo_xml_tag.remove if !modelo_xml_tag.nil?
					numero_ecf_xml_tag.remove if !numero_ecf_xml_tag.nil?
					numero_coo_xml_tag.remove if !numero_coo_xml_tag.nil?

					modelo_xml_tag = Nokogiri::XML("<mod>").elements.first
					numero_ecf_xml_tag = Nokogiri::XML("<nECF>").elements.first
					numero_coo_xml_tag = Nokogiri::XML("<nCOO>").elements.first
				end

				modelo_xml_tag.content = modelo
				numero_ecf_xml_tag.content = numero_ecf
				numero_coo_xml_tag.content = numero_coo

				refecf_xml_tag = Nokogiri::XML("<refNFP>").elements.first if refecf_xml_tag.nil?

				refecf_xml_tag.add_child(modelo_xml_tag)
				refecf_xml_tag.add_child(numero_ecf_xml_tag)
				refecf_xml_tag.add_child(numero_coo_xml_tag)

				refecf_parent_tag = map.get_tag('191')
				refecf_parent_xml_tag = xml.xpath("#{refecf_parent_tag["xpath"]}","xs" => "#{refecf_parent_tag["xpath_namespace"]}").first
				refecf_parent_xml_tag.add_child(refecf_xml_tag)

				refnfe_xml_tag = xml.xpath("#{refnfe_tag["xpath"]}","xs" => "#{refnfe_tag["xpath_namespace"]}").first
				refnf_xml_tag = xml.xpath("#{refnf_tag["xpath"]}","xs" => "#{refnf_tag["xpath_namespace"]}").first
				refnfp_xml_tag = xml.xpath("#{refnfp_tag["xpath"]}","xs" => "#{refnfp_tag["xpath_namespace"]}").first
				refcte_xml_tag = xml.xpath("#{refcte_tag["xpath"]}","xs" => "#{refcte_tag["xpath_namespace"]}").first

				refnfe_xml_tag.remove if !refnfe_xml_tag.nil?
				refnf_xml_tag.remove if !refnf_xml_tag.nil?
				refnfp_xml_tag.remove if !refnfp_xml_tag.nil?
				refcte_xml_tag.remove if !refcte_xml_tag.nil?
			end
		}}
		{"id"=>"200","lambda" => lambda{|msg,map,xml| }}
		{"id"=>"214","lambda" => lambda{|msg,map,xml| 
			cpf_cnpj = msg[:cpf_cnpj]

			if cpf_cnpj.length == 9
				child = Nokogiri::XML("<CPF>").elements.first
				parent = map.get_tag(map.get_tag("216")["parent"])
				cnpj = map.get_tag("215")
				cnpj = xml.xpath("#{cnpj["xpath"]}","xs" => "#{cnpj["xpath_namespace"]}").first
				cnpj.remove if !cnpj.nil?
			elsif cpf_cnpj.length == 11
				child = Nokogiri::XML("<CNPJ>").elements.first
				parent = map.get_tag(map.get_tag("215")["parent"])
				cpf = map.get_tag("216")
				cpf = xml.xpath("#{cpf["xpath"]}","xs" => "#{cpf["xpath_namespace"]}").first
				cpf.remove if !cpf.nil?
			end

			child.content = cpf_cnpj
			parent_xml_tag = xml.xpath("#{parent["xpath"]}","xs" => "#{parent["xpath_namespace"]}").first
			parent_xml_tag.add_child(child) if !parent_xml_tag.nil?
		}}
		{"id"=>"249","lambda" => lambda{|msg,map,xml| 
			cpf_cnpj = msg[:cpf_cnpj]
			id_estrangeiro = msg[:id_estrangeiro]

			if id_estrangeiro.nil?
				if cpf_cnpj.length == 9
					child = Nokogiri::XML("<CPF>").elements.first
					parent = map.get_tag(map.get_tag("251")["parent"])

					cnpj_tag = map.get_tag("250")
					cnpj_xml_tag = xml.xpath("#{cnpj["xpath"]}","xs" => "#{cnpj_tag["xpath_namespace"]}").first
					cnpj_xml_tag.remove if !cnpj_xml_tag.nil?

					id_estrangeiro_tag = map.get_tag("252")
					id_estrangeiro_xml_tag = xml.xpath("#{id_estrangeiro_tag["xpath"]}","xs" => "#{id_estrangeiro_tag["xpath_namespace"]}").first
					id_estrangeiro_xml_tag.remove if !id_estrangeiro_xml_tag.nil?
				elsif cpf_cnpj.length == 11
					child =_xml_tag Nokogiri::XML("<CNPJ>").elements.first
					parent = map.get_tag(map.get_tag("250")["parent"])

					cpf_tag = map.get_tag("251")
					cpf_xml_tag = xml.xpath("#{cpf_tag["xpath"]}","xs" => "#{cpf_tag["xpath_namespace"]}").first
					cpf_xml_tag.remove if !cpf_xml_tag.nil?

					id_estrangeiro_tag = map.get_tag("252")
					id_estrangeiro_xml_tag = xml.xpath("#{id_estrangeiro_tag["xpath"]}","xs" => "#{id_estrangeiro_tag["xpath_namespace"]}").first
					id_estrangeiro_xml_tag.remove if !id_estrangeiro_xml_tag.nil?
				end
			else
				child = Nokogiri::XML("<idEstrangeiro>").elements.first
				parent = map.get_tag(map.get_tag("252")["parent"])

				cnpj_tag = map.get_tag("250")
				cnpj_xml_tag = xml.xpath("#{cnpj_tag["xpath"]}","xs" => "#{cnpj_tag["xpath_namespace"]}").first
				cnpj_xml_tag.remove if !cnpj_xml_tag.nil?

				cpf_tag = map.get_tag("251")
				cpf_xml_tag = xml.xpath("#{cpf_tag["xpath"]}","xs" => "#{cpf_tag["xpath_namespace"]}").first
				cpf_xml_tag.remove if !cpf_xml_tag.nil?
			end

			child.content = cpf_cnpj if id_estrangeiro.nil?
			child.content = id_estrangeiro if cpf_cnpj.nil?
			parent_xml_tag = xml.xpath("#{parent["xpath"]}","xs" => "#{parent["xpath_namespace"]}").first
			parent_xml_tag.add_child(child) if !parent_xml_tag.nil?
		}}
		{"id"=>"271","lambda" => lambda{|msg,map,xml| 
			cpf_cnpj = msg[:cpf_cnpj]

			if cpf_cnpj.length == 9
				child = Nokogiri::XML("<CPF>").elements.first
				parent = map.get_tag(map.get_tag("273")["parent"])
				cnpj = map.get_tag("272")
				cnpj = xml.xpath("#{cnpj["xpath"]}","xs" => "#{cnpj["xpath_namespace"]}").first
				cnpj.remove if !cnpj.nil?
			elsif cpf_cnpj.length == 11
				child = Nokogiri::XML("<CNPJ>").elements.first
				parent = map.get_tag(map.get_tag("272")["parent"])
				cpf = map.get_tag("273")
				cpf = xml.xpath("#{cpf["xpath"]}","xs" => "#{cpf["xpath_namespace"]}").first
				cpf.remove if !cpf.nil?
			end

			child.content = cpf_cnpj
			parent_xml_tag = xml.xpath("#{parent["xpath"]}","xs" => "#{parent["xpath_namespace"]}").first
			parent_xml_tag.add_child(child) if !parent_xml_tag.nil?
		}}
		{"id"=>"288","lambda" => lambda{|msg,map,xml|
			cpf_cnpj = msg[:cpf_cnpj]

			if cpf_cnpj.length == 9
				child = Nokogiri::XML("<CPF>").elements.first
				parent = map.get_tag(map.get_tag("290")["parent"])
				cnpj = map.get_tag("289")
				cnpj = xml.xpath("#{cnpj["xpath"]}","xs" => "#{cnpj["xpath_namespace"]}").first
				cnpj.remove if !cnpj.nil?
			elsif cpf_cnpj.length == 11
				child = Nokogiri::XML("<CNPJ>").elements.first
				parent = map.get_tag(map.get_tag("289")["parent"])
				cpf = map.get_tag("290")
				cpf = xml.xpath("#{cpf["xpath"]}","xs" => "#{cpf["xpath_namespace"]}").first
				cpf.remove if !cpf.nil?
			end

			child.content = cpf_cnpj
			parent_xml_tag = xml.xpath("#{parent["xpath"]}","xs" => "#{parent["xpath_namespace"]}").first
			parent_xml_tag.add_child(child) if !parent_xml_tag.nil?
		}}
		{"id"=>"305","lambda" => lambda{|msg,map,xml|
			cpf_cnpj = msg[:cpf_cnpj]

			if cpf_cnpj.length == 9
				child = Nokogiri::XML("<CPF>").elements.first
				parent = map.get_tag(map.get_tag("307")["parent"])
				cnpj = map.get_tag("306")
				cnpj = xml.xpath("#{cnpj["xpath"]}","xs" => "#{cnpj["xpath_namespace"]}").first
				cnpj.remove if !cnpj.nil?
			elsif cpf_cnpj.length == 11
				child = Nokogiri::XML("<CNPJ>").elements.first
				parent = map.get_tag(map.get_tag("306")["parent"])
				cpf = map.get_tag("307")
				cpf = xml.xpath("#{cpf["xpath"]}","xs" => "#{cpf["xpath_namespace"]}").first
				cpf.remove if !cpf.nil?
			end

			child.content = cpf_cnpj
			parent_xml_tag = xml.xpath("#{parent["xpath"]}","xs" => "#{parent["xpath_namespace"]}").first
			parent_xml_tag.add_child(child) if !parent_xml_tag.nil?
		}}
		{"id"=>"310","lambda" => lambda{|msg,map,xml|
			produtos = msg[:produtos]

			produtos_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det","xs"=>"http://www.portalfiscal.inf.br/nfe")
			produtos_xml_tags.each{|produto| produto.remove } if !produtos_xml_tags.nil?

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
		}}
		{"id"=>"434","lambda" => lambda{|msg,map,xml|
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
		}}
		{"id"=>"437","lambda" => lambda{|msg,map,xml|
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

				#ICMSPart CST = 10 ou 90
				#ICMSST CST = 41 ou 60

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
		}}
		{"id"=>"707","lambda" => lambda{|msg,map,xml|
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
		}}
		{"id"=>"713","lambda" => lambda{|msg,map,xml|
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
		}}
		{"id"=>"736","lambda" => lambda{|msg,map,xml|
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
		}}
		{"id"=>"764","lambda" => lambda{|msg,map,xml|
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
		}}
		{"id"=>"777","lambda" => lambda{|msg,map,xml|
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
		}}
		{"id"=>"786","lambda" => lambda{|msg,map,xml|
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
		}}
		{"id"=>"794","lambda" => lambda{|msg,map,xml|
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
		}}
		{"id"=>"807","lambda" => lambda{|msg,map,xml|
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
		}}
		{"id"=>"816","lambda" => lambda{|msg,map,xml|
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
		}}
		{"id"=>"885","lambda" => lambda{|msg,map,xml|

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
		}}
		{"id"=>"887","lambda" => lambda{|msg,map,xml|
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
	]

end