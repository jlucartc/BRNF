require 'simplecov'
SimpleCov.start

require './nf/api/builder.rb'
require './nf/mock/generator.rb'
require 'nokogiri'
require 'pry'

RSpec.describe Gem do

	schema_autorizacao = './schemas/producao/arquivos/enviNFe_v4.00.xsd'
	xml = NF::Mock::Generator.autorizar_nota
	indicador_destinatario = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:indIEDest","xs" => "http://www.portalfiscal.inf.br/nfe").first
	indicador_operacao = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:idDest","xs" => "http://www.portalfiscal.inf.br/nfe").first
	uf_destinatario = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:enderDest//xs:UF","xs" => "http://www.portalfiscal.inf.br/nfe").first
	modelo_nota = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:mod","xs" => "http://www.portalfiscal.inf.br/nfe").first
	icms_st_destacado = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:vICMSST","xs" => "http://www.portalfiscal.inf.br/nfe")
	icms_st_retido = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:vICMSSTRet","xs" => "http://www.portalfiscal.inf.br/nfe")
	icms_cst = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:CST","xs" => "http://www.portalfiscal.inf.br/nfe").map{|tag| tag.content}
	icms_csosn = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:CSOSN","xs" => "http://www.portalfiscal.inf.br/nfe").map{|tag| tag.content}
	ufs_sem_isencao_interestadual = ["AM","BA","CE","GO","MG","MS","MT","PA","PE","RN","SE","SP"]
	nfref = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref","xs" => "http://www.portalfiscal.inf.br/nfe").first
	vagao = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:vagao","xs" => "http://www.portalfiscal.inf.br/nfe").first
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

	it "deve indicar destinatario 'Não-contribuinte' caso nota seja NFCE" do |test|
		condicao = false if (modelo_nota.content == '65' and indicador_destinatario.content != "9")
		expect(condicao).to be(true)
	end

	it "deve indicar destinatario 'Não-contribuinte' em caso de operação com exterior para NFE" do |test|
		if modelo_nota.content == "55" and indicador_operacao.content == "3"
				condicao = (indicador_destinatario.content != "9") ? false : true
		end
		expect(condicao).to be(true)
	end

	it "deve indicar destinatario como 'Contribuinte' ou 'Não-contribuinte' para UFs que não permitem isenção em operações interestaduais" do |test|
		if modelo_nota.content == "55" and indicador_destinatario.content == "2"
			if indicador_operacao.content == "2"
				condicao = ufs_sem_isencao.include?(uf_destinatario.content) ? false : true
			end
		end

		expect(condicao).to be(true)
	end

	it "deve indicar destinatario como 'Contribuinte' ou 'Não-contribuinte' para UFs que não permitem isenção em operações internas" do |test|
		excecao_1 = icms_st_destacado.length > 0
		excecao_2 = icms_st_retido.length > 0
		excecao_3 = (!csts_operacao_isenta.intersection(icms_cst).empty? or !csosns_operacao_isenta.intersection(icms_csosn).empty?) 

		if modelo_nota.content == "55" and indicador_destinatario.content == "2"
			if ufs_sem_isencao_interestadual.include?(uf_destinatario.content)
				binding.pry
				condicao = false unless (excecao_1 or excecao_2 or excecao_3)
			end
		end

		expect(condicao).to be(true)
	end

	it "deve indicar destinatario como 'Contribuinte' ou 'Isento' para operações sem consumidor final de saída e que não são do exterior" do |test|
		expect(true).to be(false)
	end

	it "deve informar tag IE quando destinatario for 'Contribuinte'" do |test|
		expect(true).to be(false)
	end

	it "não deve informar tag IE quando destinatario for 'Isento'" do |test|
		expect(true).to be(false)
	end

	it "não deve informar tag vagao quando for NFCE" do |test|
		condicao = false if (modelo_nota.content == "65" and !vagao.nil?)
		expect(condicao).to be(true)
	end

end