require 'simplecov'
SimpleCov.start

require './nf/api/builder.rb'
require './nf/mock/generator.rb'
require 'nokogiri'
require 'pry'

RSpec.describe Gem do

	schema_autorizacao = './schemas/producao/arquivos/enviNFe_v4.00.xsd'
	#xml = NF::Mock::Generator.autorizar_nota(File.open("nota_exemplo.xml") { |f| Nokogiri::XML(f) })
	xml = NF::Mock::Generator.autorizar_nota(nil)
	indicador_operacao = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:idDest","xs" => "http://www.portalfiscal.inf.br/nfe").first
	destinatario_uf = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:enderDest//xs:UF","xs" => "http://www.portalfiscal.inf.br/nfe").first
	destinatario_cpf = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:CPF","xs" => "http://www.portalfiscal.inf.br/nfe").first
	destinatario_indicador = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:indIEDest","xs" => "http://www.portalfiscal.inf.br/nfe").first
	destinatario_inscricao_estadual = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:indIEDest","xs" => "http://www.portalfiscal.inf.br/nfe").first
	modelo_nota = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:mod","xs" => "http://www.portalfiscal.inf.br/nfe").first
	icms_st_destacado = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:vICMSST","xs" => "http://www.portalfiscal.inf.br/nfe")
	icms_st_retido = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:vICMSSTRet","xs" => "http://www.portalfiscal.inf.br/nfe")
	icms_cst = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:CST","xs" => "http://www.portalfiscal.inf.br/nfe").map{|tag| tag.content}
	icms_csosn = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:CSOSN","xs" => "http://www.portalfiscal.inf.br/nfe").map{|tag| tag.content}
	ufs_sem_isencao_interestadual = ["AM","BA","CE","GO","MG","MS","MT","PA","PE","RN","SE","SP"]
	nfref = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref","xs" => "http://www.portalfiscal.inf.br/nfe").first
	vagao = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:vagao","xs" => "http://www.portalfiscal.inf.br/nfe").first
	grupo_entrega_cpf = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:entrega//xs:CPF","xs" => "http://www.portalfiscal.inf.br/nfe").first
	grupo_entrega_inscricao_estadual = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:entrega//xs:IE","xs" => "http://www.portalfiscal.inf.br/nfe").first
	indicador_consumidor_final = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:indFinal","xs" => "http://www.portalfiscal.inf.br/nfe").first
	inscricao_suframa = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:ISUF","xs" => "http://www.portalfiscal.inf.br/nfe").first
	csts_operacao_isenta = ["40","41"]
	csosns_operacao_isenta = ["103","300","400"]
	condicao = true
	puts xml

	it "deve criar um xml válido para mensagem de autorizacao de notas" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_autorizacao))
		puts schema.validate(xml)
		expect(schema.valid?(xml)).to be(true)
	end

	it "deve conter apenas um dos grupos: refNFe, refNF, refNFP ou refECF quando houver NFref" do |test|
		condicao = (nfref.children.length == 1) if !nfref.nil?
		expect(condicao).to be(true)
	end

	it "deve indicar destinatario 'Não-contribuinte' caso nota seja NFCE (E16a-10)" do |test|
		condicao = false if (modelo_nota.content == '65' and destinatario_indicador.content != "9")
		expect(condicao).to be(true)
	end

	it "deve indicar destinatario 'Não-contribuinte' em caso de operação com exterior para NFE (E16a-20)" do |test|
		if modelo_nota.content == "55" and indicador_operacao.content == "3"
				condicao = (destinatario_indicador.content != "9") ? false : true
		end
		expect(condicao).to be(true)
	end

	it "deve indicar destinatario como 'Contribuinte' ou 'Não-contribuinte' para UFs que não permitem isenção em operações interestaduais (E16a-30)" do |test|
		if modelo_nota.content == "55" and destinatario_indicador.content == "2"
			if indicador_operacao.content == "2"
				condicao = ufs_sem_isencao_interestadual.include?(destinatario_uf.content) ? false : true
			end
		end

		expect(condicao).to be(true)
	end

	# it "deve indicar destinatario como 'Contribuinte' ou 'Não-contribuinte' para UFs que não permitem isenção em operações internas (E16a-35)" do |test|
	# 	excecao_1 = icms_st_destacado.length > 0
	# 	excecao_2 = icms_st_retido.length > 0
	# 	excecao_3 = (!csts_operacao_isenta.intersection(icms_cst).empty? or !csosns_operacao_isenta.intersection(icms_csosn).empty?) 

	# 	if modelo_nota.content == "55" and destinatario_indicador.content == "2"
	# 		if ufs_sem_isencao_interestadual.include?(destinatario_uf.content)
	# 			condicao = false unless (excecao_1 or excecao_2 or excecao_3)
	# 		end
	# 	end

	# 	expect(condicao).to be(true)
	# end

	# it "deve indicar destinatario como 'Contribuinte' ou 'Isento' para operações sem consumidor final, de saída e que não são do exterior (E16a-40)" do |test|
	# 	condicao = false if (!destinatario_indicador.nil? and (destinatario_indicador.to_s == '1' or destinatario_indicador.to_s == '9') and indicador_consumidor_final.to_s != '1' and )
	# 	expect(condicao).to be(true)
	# end

	it "deve informar tag IE da NFE quando destinatario for 'Contribuinte' (E17-20)" do |test|
		condicao = false if (modelo_nota.content == '55' and destinatario_indicador.to_s == '1' and !destinatario_inscricao_estadual.nil?)
		expect(condicao).to be(true)
	end

	it "não deve informar tag IE da NFE quando destinatario for 'Isento' (E17-30)" do |test|
		condicao = false if (!destinatario_inscricao_estadual.nil? and !destinatario_indicador.nil? and destinatario_indicador.to_s == '2')
		expect(condicao).to be(true)
	end

	it "não deve informar tag vagao quando for NFCE (X25a-10)" do |test|
		condicao = false if (modelo_nota.content == "65" and !vagao.nil?)
		expect(condicao).to be(true)
	end

	it "não deve informar tag de inscrição estadual quando houver um CPF no grupo entrega ()" do |test|
		condicao = false if (!grupo_entrega_cpf.nil? and !grupo_entrega_inscricao_estadual.nil?)
		expect(condicao).to be(true)
	end

	it "NFCE não deve ter inscrição na suframa (E18-10)" do |test|
		condicao = false if (!inscricao_suframa.nil? and modelo_nota.content == '65')
		expect(condicao).to be(true)
	end

	# it "deve ter a chave de acesso igual à concatenação dos campos correspondentes (A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "deve ter cNF válido (B03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "não deve conter data de entrada/saida quando for NFCE (B10-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "não deve ter data de entrada/saida menor do que a data de emissão quando for NFE de saída (B10-40)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "não deve gerar NFCE para operação de entrada (B11-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "deve gerar NFCE apenas para operação estadual (B11a-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "deve conter um código de municipio existente para o fato gerador de ICMS(B12-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "deve conter um código de municipio onde os dois primeiros caracteres são os mesmos do código da UF do emitente (B12-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "deve emitir NFCE apenas com tipos de impressão 4 ou 5 (B21-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "não deve emitir NFE com tipos de impressão 4 e 5 (B21-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "não deve emitir NFCE com finalidade diferente de normal (B25-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "deve informar nota referenciada caso NFE seja complementar (B25-30)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "não deve informar mais de um nota referenciada caso NFE seja complementar (B25-40)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "deve conter CPF/CNPJ da nota referenciada igual (B25-50)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(B25-60)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(B25-70)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(B25a-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(B25b-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(B25b-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(B25b-30)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(B25b-40)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(B25c-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(B25c-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(B26-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(B26-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(B26-30)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(B26-40)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(B28-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(B28-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(B28-30)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(B28-40)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(BA01-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(BA02-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(BA02-14)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(BA02-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(BA02-24)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(BA02-30)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(BA02-34)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(BA02-40)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(BA02-44)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(BA02-50)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(BA03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(BA05-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(BA06-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(BA10-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(BA10-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(BA10-30)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(BA10-40)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(BA10-50)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(BA12-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(BA13-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(BA14-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(BA15-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(BA19-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(BA19-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(BA19-24)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(BA19-30)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(BA19-34)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(BA19-40)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(BA19-44)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(BA20-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(BA20-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(BA20-30)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(C02-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(C02-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(C02-30)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(C02a-04)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(C02a-08)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(C02a-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(C02a-14)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(C02a-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(C02a-30)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(C10-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(C10-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(C12-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(C17-30)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(C18-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(C18-14)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(C18-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(C18-30)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(C18-40)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(C21-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(D01-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(D01-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(E01-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(E01-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(E02-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(E02-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(E03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(E03a-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(E03a-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(E03a-30)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(E03a-60)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(E04-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(E04-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(E05-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(E05-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(E10-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(E10-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(E10-30)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(E12-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(E12-30)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(E12-40)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(E12-50)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(E12-60)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(E14-04)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(E14-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(E14-20)" do |test|
	# 	expect(true).to be(false)
	# end	

	# it "(E14-30)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(E16a-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(E16a-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(E16a-30)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(E16a-35)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(E16a-40)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(E17-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(E17-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(E17-30)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(E17-40)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(E17-50)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(E18-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(E18-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(E18-30)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(F02-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(F02a-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(F07-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(F07-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(F07-30)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(F11-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(F15-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(G02-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(G02a-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(G07-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(G07-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(G07-30)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(G11-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(G15-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(GA02-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(GA02-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(GA03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(GA03-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(H02-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I03-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I03-30)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I04-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I05-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I05-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I05-24)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I05-30)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I05e-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I05e-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I08-04)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I08-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I08-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I08-30)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I08-40)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I08-50)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I08-60)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I08-70)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I08-90)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I08-94)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I08-110)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I08-120)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I08-130)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I08-140)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I08-144)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I08-150)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I08-160)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I08-170)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I08-180)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I08-184)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I08-190)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I09-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I11-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I11-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I12-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I12-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I12-30)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I12-40)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I12-60)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I13-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I13-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I14-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I17-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I17b-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I19-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I23-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I23b-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I23d-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I23d-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I23e-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I29a-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I29a-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I50-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I51-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I51-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I52-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I53-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I54-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I54-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I54-30)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I54-40)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I55-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I70-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I83-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(I84-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(J01-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(K01-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(L01-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(LA01-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(LA02-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(LA03c-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(LA03c-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(LA03d-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(LA11-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(LA11-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(LA16-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(LB01-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(LB01-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(LB01-30)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(N08-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(N12-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(N12-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(N12-30)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(N12-34)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(N12-40)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(N12-44)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(N12-50)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(N12-60)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(N12-70)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(N12-80)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(N12-81)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(N12-82)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(N12-85)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(N12-86)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(N12-90)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(N12-94)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(N12-97)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(N12-98)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(N12a-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(N12a-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(N12a-50)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(N12a-60)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(N12a-30)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(N12a-34)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(N12a-40)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(N12a-44)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(N12a-70)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(N16-04)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(N16-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(N16a-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(N16c-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(N17-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(N17-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(N17b-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(N17b-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(N17c-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(N17c-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(N18-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(N18-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(N23-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(N23b-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(N23b-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(N23d-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(N27b-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(N27b-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(N27d-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(N28-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(N28-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(N28-30)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(NA01-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(NA01-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(NA01-30)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(NA09-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(NA09-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(NA09-30)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(NA11-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(NA13-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(NA15-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(NA17-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(O01-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(O06-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(O09-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(P01-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(Q01-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(R01-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(S01-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(T01-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(U01-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(U01-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(U05-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(U14-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(U15-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(UA01-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(UAO1-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(W03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(W03-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(W04-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(W04-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(W04a-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(W04b-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(W04e-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(W04g-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(W05-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(W06-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(W06a-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(W06b-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(W07-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(W08-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(W09-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(W10-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(W11-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(W12-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(W12a-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(W13-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(W14-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(W15-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(W16-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(W16-20)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(W16-30)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(W16-40)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(W16-50)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(W16-60)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(W16a-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(W18-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(W19-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(W20-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(W21-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(W22-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(W22b-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(W22c-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(W22d-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end	

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

	# it "(A03-10)" do |test|
	# 	expect(true).to be(false)
	# end

end