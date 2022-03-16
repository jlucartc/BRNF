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
			veiculos = msg[:veiculos]
			medicamentos = msg[:medicamentos]
			armas = msg[:armas]
			combustiveis = msg[:combustiveis]
			papel = msg[:papel]
		}}
		{"id"=>"434","lambda" => lambda{|msg,map,xml|
			icms = msg[:icms]
			issqn = msg[:issqn]
			ii = msg[:ii]
			pis = msg[:pis]
			cofins = msg[:cofins]
			ipi = msg[:ipi]

			#grupo_icms_ii contem icms, pode conter ipi e pode conter ii
			#grupo issqn contem issqn, pode conter ipi

			if !icms.nil?
			elsif !issqn.nil?
			end

		}}
		{"id"=>"437","lambda" => lambda{|msg,map,xml| }}
		{"id"=>"707","lambda" => lambda{|msg,map,xml| }}
		{"id"=>"713","lambda" => lambda{|msg,map,xml| }}
		{"id"=>"736","lambda" => lambda{|msg,map,xml| }}
		{"id"=>"764","lambda" => lambda{|msg,map,xml| }}
		{"id"=>"777","lambda" => lambda{|msg,map,xml| }}
		{"id"=>"786","lambda" => lambda{|msg,map,xml| }}
		{"id"=>"794","lambda" => lambda{|msg,map,xml| }}
		{"id"=>"807","lambda" => lambda{|msg,map,xml| }}
		{"id"=>"816","lambda" => lambda{|msg,map,xml| }}
		{"id"=>"887","lambda" => lambda{|msg,map,xml| }}
		{"id"=>"885","lambda" => lambda{|msg,map,xml| }}
		{"id"=>"911","lambda" => lambda{|msg,map,xml| }}
		{"id"=>"913","lambda" => lambda{|msg,map,xml| }}
	]

end