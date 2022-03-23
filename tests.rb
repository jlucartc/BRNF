require 'simplecov'
SimpleCov.start

#require './nf/api/builder.rb'
#require './nf/mock/generator.rb'
require './lib/brnf.rb'
require 'nokogiri'
require 'pry'
require 'openssl'
require 'pry'

RSpec.describe Gem do

	schema_autorizacao = './schemas/producao/arquivos/enviNFe_v4.00.xsd'
	schema_inutilizacao = './schemas/producao/arquivos/inutNFe_v4.00.xsd'
	schema_evento_carta_correcao = './schemas/producao/arquivos/envCCe_v1.00.xsd'
	schema_evento_cancelar_nota = './schemas/producao/arquivos/envEventoCancNFe_v1.00.xsd'
	schema_consultar_status_servico = './schemas/producao/arquivos/consStatServ_v4.00.xsd'
	schema_evento_cancelar_nota_substituicao = './schemas/producao/arquivos/envEventoCancSubst_v1.00.xsd'
	schema_evento_prorrogar_prazo_1 = './schemas/producao/arquivos/envRemIndus_v1.00.xsd'
	schema_evento_prorrogar_prazo_2 = './schemas/producao/arquivos/envRemIndus_v1.00.xsd'
	schema_evento_ator_interessado = './schemas/producao/arquivos/envEventoAtorInteressado_v1.00.xsd'
	schema_evento_confirmacao_da_operacao = './schemas/producao/arquivos/envConfRecebto_v1.00.xsd'
	schema_evento_ciencia_da_operacao = './schemas/producao/arquivos/envConfRecebto_v1.00.xsd'
	schema_evento_desconhecimento_da_operacao = './schemas/producao/arquivos/envConfRecebto_v1.00.xsd'
	schema_evento_operacao_nao_realizada = './schemas/producao/arquivos/envConfRecebto_v1.00.xsd'
	schema_evento_emissao_contingencia = './schemas/producao/arquivos/envEPEC_v1.00.xsd'
	schema_evento_cancelamento_prazo_1 = './schemas/producao/arquivos/envRemIndus_v1.00.xsd'
	schema_evento_cancelamento_prazo_2 = './schemas/producao/arquivos/envRemIndus_v1.00.xsd'
	schema_consultar_retorno_autorizacao = './schemas/producao/arquivos/consReciNFe_v4.00.xsd'
	schema_consultar_protocolo = './schemas/producao/arquivos/consSitNFe_v4.00.xsd'
	schema_nfe_distribuicao_dfe = './schemas/producao/arquivos/distDFeInt_v1.01.xsd'
	schema_consultar_cadastro = './schemas/producao/arquivos/consCad_v2.00.xsd'
	generator = BRNF::XML.new
	#xml_autorizacao = generator.autorizar_nota(documento: File.open("nota_exemplo.xml") { |f| Nokogiri::XML(f) })
	xml_autorizacao = generator.autorizar_nota()
	xml_inutilizacao = generator.inutilizar_numeracao()
	xml_evento_carta_correcao = generator.criar_carta_correcao()
	xml_evento_cancelar_nota = generator.cancelar_nota()
	xml_consultar_status_servico = generator.consultar_status_servico()
	xml_evento_cancelar_nota_substituicao = generator.cancelar_nota_substituicao()
	xml_evento_prorrogar_prazo_1 = generator.prorrogar_prazo_1()
	xml_evento_prorrogar_prazo_2 = generator.prorrogar_prazo_2()
	xml_evento_ator_interessado = generator.ator_interessado()
	xml_evento_confirmacao_da_operacao = generator.confirmacao_da_operacao()
	xml_evento_ciencia_da_operacao = generator.ciencia_da_operacao()
	xml_evento_desconhecimento_da_operacao = generator.desconhecimento_da_operacao()
	xml_evento_operacao_nao_realizada = generator.operacao_nao_realizada()
	xml_evento_emissao_contingencia = generator.emissao_contingencia()
	xml_evento_cancelamento_prazo_1 = generator.cancelamento_prazo_1()
	xml_evento_cancelamento_prazo_2 = generator.cancelamento_prazo_2()
	xml_consultar_retorno_autorizacao = generator.consultar_retorno_autorizacao()
	xml_consultar_protocolo = generator.consultar_protocolo()
	xml_nfe_distribuicao_dfe = generator.nfe_distribuicao_dfe()
	xml_consultar_cadastro = generator.consultar_cadastro()
	# --- AUTORIZAR NOTA ---
	indicador_operacao = xml_autorizacao.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:idDest","xs" => "http://www.portalfiscal.inf.br/nfe").first
	destinatario_uf = xml_autorizacao.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:enderDest//xs:UF","xs" => "http://www.portalfiscal.inf.br/nfe").first
	destinatario_cpf = xml_autorizacao.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:CPF","xs" => "http://www.portalfiscal.inf.br/nfe").first
	destinatario_indicador = xml_autorizacao.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:indIEDest","xs" => "http://www.portalfiscal.inf.br/nfe").first
	destinatario_inscricao_estadual = xml_autorizacao.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:IE","xs" => "http://www.portalfiscal.inf.br/nfe").first
	modelo_nota = xml_autorizacao.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:mod","xs" => "http://www.portalfiscal.inf.br/nfe").first
	icms_st_destacado = xml_autorizacao.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:vICMSST","xs" => "http://www.portalfiscal.inf.br/nfe")
	icms_st_retido = xml_autorizacao.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:vICMSSTRet","xs" => "http://www.portalfiscal.inf.br/nfe")
	icms_cst = xml_autorizacao.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:CST","xs" => "http://www.portalfiscal.inf.br/nfe").map{|tag| tag.content}
	icms_csosn = xml_autorizacao.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:CSOSN","xs" => "http://www.portalfiscal.inf.br/nfe").map{|tag| tag.content}
	ufs_sem_isencao_interestadual = ["AM","BA","CE","GO","MG","MS","MT","PA","PE","RN","SE","SP"]
	nfref = xml_autorizacao.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref","xs" => "http://www.portalfiscal.inf.br/nfe").first
	vagao = xml_autorizacao.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:vagao","xs" => "http://www.portalfiscal.inf.br/nfe").first
	grupo_entrega_cpf = xml_autorizacao.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:entrega//xs:CPF","xs" => "http://www.portalfiscal.inf.br/nfe").first
	grupo_entrega_inscricao_estadual = xml_autorizacao.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:entrega//xs:IE","xs" => "http://www.portalfiscal.inf.br/nfe").first
	indicador_consumidor_final = xml_autorizacao.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:indFinal","xs" => "http://www.portalfiscal.inf.br/nfe").first
	inscricao_suframa = xml_autorizacao.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:ISUF","xs" => "http://www.portalfiscal.inf.br/nfe").first
	# --- CARTA CORRECAO ---
	tipo_evento_carta_correcao = xml_evento_carta_correcao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:tpEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
	versao_env_evento_carta_correcao = xml_evento_carta_correcao.xpath("//xs:envEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
	versao_det_evento_carta_correcao = xml_evento_carta_correcao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
	ver_evento_carta_correcao = xml_evento_carta_correcao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:verEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
	num_item_carta_correcao = xml_evento_carta_correcao.xpath("//xs:envEvento//xs:evento//xs:infEvento//@numItem","xs" => "http://www.portalfiscal.inf.br/nfe").first
	descricao_evento_carta_correcao = xml_evento_carta_correcao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
	c_orgao_autor_carta_correcao = xml_evento_carta_correcao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:cOrgaoAutor","xs" => "http://www.portalfiscal.inf.br/nfe").first
	tipo_autor_carta_correcao = xml_evento_carta_correcao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpAutor","xs" => "http://www.portalfiscal.inf.br/nfe").first
	ver_aplic_carta_correcao = xml_evento_carta_correcao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:verAplic","xs" => "http://www.portalfiscal.inf.br/nfe").first
	nprot_carta_correcao = xml_evento_carta_correcao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:nProt","xs" => "http://www.portalfiscal.inf.br/nfe").first
	xjust_carta_correcao = xml_evento_carta_correcao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xJust","xs" => "http://www.portalfiscal.inf.br/nfe").first 
	chnfref_carta_correcao = xml_evento_carta_correcao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:chNFeRef","xs" => "http://www.portalfiscal.inf.br/nfe").first 
	condicao_uso_carta_correcao = xml_evento_carta_correcao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xCondUso","xs" => "http://www.portalfiscal.inf.br/nfe").first
	valor_condicao_uso_carta_correcao = "A Carta de Correcao e disciplinada pelo paragrafo 1o-A do art. 7o do Convenio S/N, de 15 de dezembro de 1970 e pode ser utilizada para regularizacao de erro ocorrido na emissao de documento fiscal, desde que o erro nao esteja relacionado com: I - as variaveis que determinam o valor do imposto tais como: base de calculo, aliquota, diferenca de preco, quantidade, valor da operacao ou da prestacao; II - a correcao de dados cadastrais que implique mudanca do remetente ou do destinatario; III - a data de emissao ou de saida."
	dhemi_carta_correcao = xml_evento_carta_correcao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dhEmi","xs" => "http://www.portalfiscal.inf.br/nfe").first
	tpnf_carta_correcao = xml_evento_carta_correcao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpNF","xs" => "http://www.portalfiscal.inf.br/nfe").first
	ie_carta_correcao = xml_evento_carta_correcao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:IE","xs" => "http://www.portalfiscal.inf.br/nfe").first
	dest_carta_correcao = xml_evento_carta_correcao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest","xs" => "http://www.portalfiscal.inf.br/nfe").first
	vnf_carta_correcao = xml_evento_carta_correcao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:vNF","xs" => "http://www.portalfiscal.inf.br/nfe").first
	vicms_carta_correcao = xml_evento_carta_correcao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:vICMS","xs" => "http://www.portalfiscal.inf.br/nfe").first
	vst_carta_correcao = xml_evento_carta_correcao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:vST","xs" => "http://www.portalfiscal.inf.br/nfe").first
	item_pedido_carta_correcao = xml_evento_carta_correcao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:itemPedido","xs" => "http://www.portalfiscal.inf.br/nfe").first
	qtde_item_carta_correcao = xml_evento_carta_correcao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:qtdeItem","xs" => "http://www.portalfiscal.inf.br/nfe").first
	aut_xml_carta_correcao = xml_evento_carta_correcao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:autXML","xs" => "http://www.portalfiscal.inf.br/nfe").first
	tp_autorizacao_carta_correcao = xml_evento_carta_correcao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpAutorizacao","xs" => "http://www.portalfiscal.inf.br/nfe").first	
	# --- CANCELAR NOTA ---
	tipo_evento_cancelar_nota = xml_evento_cancelar_nota.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:tpEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
	ver_evento_cancelar_nota = xml_evento_cancelar_nota.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:verEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
	versao_det_evento_cancelar_nota = xml_evento_cancelar_nota.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
	num_item_cancelar_nota = xml_evento_cancelar_nota.xpath("//xs:envEvento//xs:evento//xs:infEvento//@numItem","xs" => "http://www.portalfiscal.inf.br/nfe").first
	c_orgao_autor_cancelar_nota = xml_evento_cancelar_nota.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:cOrgaoAutor","xs" => "http://www.portalfiscal.inf.br/nfe").first
	versao_env_evento_cancelar_nota = xml_evento_cancelar_nota.xpath("//xs:envEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
	descricao_evento_cancelar_nota = xml_evento_cancelar_nota.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
	tipo_autor_cancelar_nota = xml_evento_cancelar_nota.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpAutor","xs" => "http://www.portalfiscal.inf.br/nfe").first
	ver_aplic_cancelar_nota = xml_evento_cancelar_nota.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:verAplic","xs" => "http://www.portalfiscal.inf.br/nfe").first
	chnfref_cancelar_nota = xml_evento_cancelar_nota.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:chNFeRef","xs" => "http://www.portalfiscal.inf.br/nfe").first
	xcorrecao_cancelar_nota = xml_evento_cancelar_nota.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xCorrecao","xs" => "http://www.portalfiscal.inf.br/nfe").first
	xconduso_cancelar_nota = xml_evento_cancelar_nota.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xCondUso","xs" => "http://www.portalfiscal.inf.br/nfe").first
	xjust_cancelar_nota = xml_evento_cancelar_nota.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xjust","xs" => "http://www.portalfiscal.inf.br/nfe").first
	dhemi_cancelar_nota = xml_evento_cancelar_nota.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dhEmi","xs" => "http://www.portalfiscal.inf.br/nfe").first
	tpnf_cancelar_nota = xml_evento_cancelar_nota.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpNF","xs" => "http://www.portalfiscal.inf.br/nfe").first
	ie_cancelar_nota = xml_evento_cancelar_nota.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:IE","xs" => "http://www.portalfiscal.inf.br/nfe").first
	dest_cancelar_nota = xml_evento_cancelar_nota.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest","xs" => "http://www.portalfiscal.inf.br/nfe").first
	vnf_cancelar_nota = xml_evento_cancelar_nota.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:vNF","xs" => "http://www.portalfiscal.inf.br/nfe").first
	vicms_cancelar_nota = xml_evento_cancelar_nota.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:vICMS","xs" => "http://www.portalfiscal.inf.br/nfe").first
	vst_cancelar_nota = xml_evento_cancelar_nota.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:vST","xs" => "http://www.portalfiscal.inf.br/nfe").first
	nprot_cancelar_nota = xml_evento_cancelar_nota.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:nProt","xs" => "http://www.portalfiscal.inf.br/nfe")
	item_pedido_cancelar_nota = xml_evento_cancelar_nota.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:itemPedido","xs" => "http://www.portalfiscal.inf.br/nfe").first
	qtde_item_cancelar_nota = xml_evento_cancelar_nota.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:qtdeItem","xs" => "http://www.portalfiscal.inf.br/nfe").first
	aut_xml_cancelar_nota = xml_evento_cancelar_nota.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:autXML","xs" => "http://www.portalfiscal.inf.br/nfe").first
	tp_autorizacao_cancelar_nota = xml_evento_cancelar_nota.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpAutorizacao","xs" => "http://www.portalfiscal.inf.br/nfe").first
	# --- CONSULTA SERVICO ---
	status_consulta_servico = xml_consultar_status_servico.xpath("//xs:consStatServ//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
	# --- CANCELAR NOTA SUBSTITUICAO ---
	tpnf_cancelar_nota_substituicao = xml_evento_cancelar_nota_substituicao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpNF","xs" => "http://www.portalfiscal.inf.br/nfe").first
	ie_cancelar_nota_substituicao = xml_evento_cancelar_nota_substituicao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:IE","xs" => "http://www.portalfiscal.inf.br/nfe").first
	dest_cancelar_nota_substituicao = xml_evento_cancelar_nota_substituicao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest","xs" => "http://www.portalfiscal.inf.br/nfe").first
	vnf_cancelar_nota_substituicao = xml_evento_cancelar_nota_substituicao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:vNF","xs" => "http://www.portalfiscal.inf.br/nfe").first
	vicms_cancelar_nota_substituicao = xml_evento_cancelar_nota_substituicao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:vICMS","xs" => "http://www.portalfiscal.inf.br/nfe").first
	vst_cancelar_nota_substituicao = xml_evento_cancelar_nota_substituicao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:vST","xs" => "http://www.portalfiscal.inf.br/nfe").first
	item_pedido_cancelar_nota_substituicao = xml_evento_cancelar_nota_substituicao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:itemPedido","xs" => "http://www.portalfiscal.inf.br/nfe").first
	qtde_item_cancelar_nota_substituicao = xml_evento_cancelar_nota_substituicao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:qtdeItem","xs" => "http://www.portalfiscal.inf.br/nfe").first
	xjust_cancelar_nota_substituicao = xml_evento_cancelar_nota_substituicao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xJust","xs" => "http://www.portalfiscal.inf.br/nfe")
	c_orgao_autor_cancelar_nota_substituicao = xml_evento_cancelar_nota_substituicao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:cOrgaoAutor","xs" => "http://www.portalfiscal.inf.br/nfe")
	tipo_autor_cancelar_nota_substituicao = xml_evento_cancelar_nota_substituicao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpAutor","xs" => "http://www.portalfiscal.inf.br/nfe")
	ver_aplic_cancelar_nota_substituicao = xml_evento_cancelar_nota_substituicao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:verAplic","xs" => "http://www.portalfiscal.inf.br/nfe")
	nprot_cancelar_nota_substituicao = xml_evento_cancelar_nota_substituicao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:nProt","xs" => "http://www.portalfiscal.inf.br/nfe")
	desc_evento_cancelar_nota_substituicao = xml_evento_cancelar_nota_substituicao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe")
	aut_xml_cancelar_nota_substituicao = xml_evento_cancelar_nota_substituicao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:autXML","xs" => "http://www.portalfiscal.inf.br/nfe").first
	tp_autorizacao_cancelar_nota_substituicao = xml_evento_cancelar_nota_substituicao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpAutorizacao","xs" => "http://www.portalfiscal.inf.br/nfe").first
	dhemi_cancelar_nota_substituicao = xml_evento_cancelar_nota_substituicao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dhEmi","xs" => "http://www.portalfiscal.inf.br/nfe").first
	versao_env_evento_cancelar_nota_substituicao = xml_evento_cancelar_nota_substituicao.xpath("//xs:envEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
	ver_evento_cancelar_nota_substituicao = xml_evento_cancelar_nota_substituicao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:verEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
	versao_det_evento_cancelar_nota_substituicao = xml_evento_cancelar_nota_substituicao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
	num_item_det_evento_cancelar_nota_substituicao = xml_evento_cancelar_nota_substituicao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@numItem","xs" => "http://www.portalfiscal.inf.br/nfe").first
	desc_evento_cancelar_nota_substituicao = xml_evento_cancelar_nota_substituicao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe")
	tipo_autor_cancelar_nota_substituicao = xml_evento_cancelar_nota_substituicao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpAutor","xs" => "http://www.portalfiscal.inf.br/nfe")
	tp_evento_cancelar_nota_substituicao = xml_evento_cancelar_nota_substituicao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:tpEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
	det_evento_cancelar_nota_substituicao = xml_evento_cancelar_nota_substituicao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
	xconduso_cancelar_nota_substituicao = xml_evento_cancelar_nota_substituicao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xCondUso","xs" => "http://www.portalfiscal.inf.br/nfe").first
	xcorrecao_cancelar_nota_substituicao = xml_evento_cancelar_nota_substituicao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xCorrecao","xs" => "http://www.portalfiscal.inf.br/nfe").first
	# --- PRORROGAR PRAZO 1 ---
	versao_env_evento_prorrogar_prazo_1 = xml_evento_prorrogar_prazo_1.xpath("//xs:envEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
	tp_evento_prorrogar_prazo_1 = xml_evento_prorrogar_prazo_1.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:tpEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
	versao_det_evento_prorrogar_prazo_1 = xml_evento_prorrogar_prazo_1.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
	desc_evento_prorrogar_prazo_1 = xml_evento_prorrogar_prazo_1.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
	nprot_prorrogar_prazo_1 = xml_evento_prorrogar_prazo_1.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:nProt","xs" => "http://www.portalfiscal.inf.br/nfe")
	item_pedido_prorrogar_prazo_1 = xml_evento_prorrogar_prazo_1.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:itemPedido","xs" => "http://www.portalfiscal.inf.br/nfe")
	num_item_prorrogar_prazo_1 = xml_evento_prorrogar_prazo_1.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@numItem","xs" => "http://www.portalfiscal.inf.br/nfe").first
	qtde_item_prorrogar_prazo_1 = xml_evento_prorrogar_prazo_1.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:qtdeItem","xs" => "http://www.portalfiscal.inf.br/nfe").first
	# --- PRORROGAR PRAZO 2 ---
	versao_env_evento_prorrogar_prazo_2 = xml_evento_prorrogar_prazo_2.xpath("//xs:envEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
	tp_evento_prorrogar_prazo_2 = xml_evento_prorrogar_prazo_2.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:tpEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
	versao_det_evento_prorrogar_prazo_2 = xml_evento_prorrogar_prazo_2.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
	desc_evento_prorrogar_prazo_2 = xml_evento_prorrogar_prazo_2.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
	nprot_prorrogar_prazo_2 = xml_evento_prorrogar_prazo_2.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:nProt","xs" => "http://www.portalfiscal.inf.br/nfe")
	item_pedido_prorrogar_prazo_2 = xml_evento_prorrogar_prazo_2.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:itemPedido","xs" => "http://www.portalfiscal.inf.br/nfe")
	num_item_prorrogar_prazo_2 = xml_evento_prorrogar_prazo_2.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@numItem","xs" => "http://www.portalfiscal.inf.br/nfe").first
	qtde_item_prorrogar_prazo_2 = xml_evento_prorrogar_prazo_2.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:qtdeItem","xs" => "http://www.portalfiscal.inf.br/nfe").first
	# --- ATOR INTERESSADO ---
	n_prot_ator_interessado = xml_evento_ator_interessado.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:nProt","xs" => "http://www.portalfiscal.inf.br/nfe").first
	x_just_ator_interessado = xml_evento_ator_interessado.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xJust","xs" => "http://www.portalfiscal.inf.br/nfe").first
	ch_nfe_ref_ator_interessado = xml_evento_ator_interessado.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:chNFeRef","xs" => "http://www.portalfiscal.inf.br/nfe").first
	x_correcao_ator_interessado = xml_evento_ator_interessado.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xCorrecao","xs" => "http://www.portalfiscal.inf.br/nfe").first
	dh_emi_ator_interessado = xml_evento_ator_interessado.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dhEmi","xs" => "http://www.portalfiscal.inf.br/nfe").first
	tp_nf_ator_interessado = xml_evento_ator_interessado.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpNF","xs" => "http://www.portalfiscal.inf.br/nfe").first
	ie_ator_interessado = xml_evento_ator_interessado.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:IE","xs" => "http://www.portalfiscal.inf.br/nfe").first
	dest_ator_interessado = xml_evento_ator_interessado.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest","xs" => "http://www.portalfiscal.inf.br/nfe").first
	v_nf_ator_interessado = xml_evento_ator_interessado.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:vNF","xs" => "http://www.portalfiscal.inf.br/nfe").first
	v_icms_ator_interessado = xml_evento_ator_interessado.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:vICMS","xs" => "http://www.portalfiscal.inf.br/nfe").first
	v_st_ator_interessado = xml_evento_ator_interessado.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:vST","xs" => "http://www.portalfiscal.inf.br/nfe").first
	item_pedido_ator_interessado = xml_evento_ator_interessado.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:itemPedido","xs" => "http://www.portalfiscal.inf.br/nfe").first
	qtde_item_ator_interessado = xml_evento_ator_interessado.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:qtdeItem","xs" => "http://www.portalfiscal.inf.br/nfe").first
	desc_evento_ator_interessado = xml_evento_ator_interessado.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe")
	c_orgao_autor_ator_interessado = xml_evento_ator_interessado.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:cOrgaoAutor","xs" => "http://www.portalfiscal.inf.br/nfe")
	tp_autor_ator_interessado = xml_evento_ator_interessado.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpAutor","xs" => "http://www.portalfiscal.inf.br/nfe")
	ver_aplic_ator_interessado = xml_evento_ator_interessado.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:verAplic","xs" => "http://www.portalfiscal.inf.br/nfe")
	x_cond_uso_ator_interessado = xml_evento_ator_interessado.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xCondUso","xs" => "http://www.portalfiscal.inf.br/nfe")
	versao_env_evento_ator_interessado = xml_evento_ator_interessado.xpath("//xs:envEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
	tp_evento_ator_interessado = xml_evento_ator_interessado.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:tpEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
	ver_evento_ator_interessado = xml_evento_ator_interessado.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:verEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
	versao_det_evento_ator_interessado = xml_evento_ator_interessado.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
	num_item_ator_interessado = xml_evento_ator_interessado.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@numItem","xs" => "http://www.portalfiscal.inf.br/nfe").first
	# --- CONFIRMACAO DA OPERACAO ---
	c_orgao_autor_confirmacao_da_operacao = xml_evento_confirmacao_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:cOrgaoAutor","xs" => "http://www.portalfiscal.inf.br/nfe").first
	tp_autor_confirmacao_da_operacao = xml_evento_confirmacao_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpAutor","xs" => "http://www.portalfiscal.inf.br/nfe").first
	ver_aplic_confirmacao_da_operacao = xml_evento_confirmacao_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:verAplic","xs" => "http://www.portalfiscal.inf.br/nfe").first
	n_prot_confirmacao_da_operacao = xml_evento_confirmacao_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:nProt","xs" => "http://www.portalfiscal.inf.br/nfe").first
	ch_nfe_ref_confirmacao_da_operacao = xml_evento_confirmacao_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:chNFeRef","xs" => "http://www.portalfiscal.inf.br/nfe").first
	x_correcao_confirmacao_da_operacao = xml_evento_confirmacao_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xCorrecao","xs" => "http://www.portalfiscal.inf.br/nfe").first
	x_cond_uso_confirmacao_da_operacao = xml_evento_confirmacao_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xCondUso","xs" => "http://www.portalfiscal.inf.br/nfe").first
	dh_emi_confirmacao_da_operacao = xml_evento_confirmacao_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dhEmi","xs" => "http://www.portalfiscal.inf.br/nfe").first
	tp_nf_confirmacao_da_operacao = xml_evento_confirmacao_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpNF","xs" => "http://www.portalfiscal.inf.br/nfe").first
	ie_confirmacao_da_operacao = xml_evento_confirmacao_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:IE","xs" => "http://www.portalfiscal.inf.br/nfe").first
	dest_confirmacao_da_operacao = xml_evento_confirmacao_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest","xs" => "http://www.portalfiscal.inf.br/nfe").first
	v_nf_confirmacao_da_operacao = xml_evento_confirmacao_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:vNF","xs" => "http://www.portalfiscal.inf.br/nfe").first
	v_icms_confirmacao_da_operacao = xml_evento_confirmacao_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:vICMS","xs" => "http://www.portalfiscal.inf.br/nfe").first
	v_st_confirmacao_da_operacao = xml_evento_confirmacao_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:vST","xs" => "http://www.portalfiscal.inf.br/nfe").first
	item_pedido_confirmacao_da_operacao = xml_evento_confirmacao_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:itemPedido","xs" => "http://www.portalfiscal.inf.br/nfe").first
	qtde_item_confirmacao_da_operacao = xml_evento_confirmacao_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:qtdeItem","xs" => "http://www.portalfiscal.inf.br/nfe").first
	aut_xml_confirmacao_da_operacao = xml_evento_confirmacao_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:autXML","xs" => "http://www.portalfiscal.inf.br/nfe").first
	tp_autorizacao_confirmacao_da_operacao = xml_evento_confirmacao_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpAutorizacao","xs" => "http://www.portalfiscal.inf.br/nfe").first
	versao_env_evento_confirmacao_da_operacao = xml_evento_confirmacao_da_operacao.xpath("//xs:envEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
	tp_evento_confirmacao_da_operacao = xml_evento_confirmacao_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:tpEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
	ver_evento_confirmacao_da_operacao = xml_evento_confirmacao_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:verEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
	versao_det_evento_confirmacao_da_operacao = xml_evento_confirmacao_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
	num_item_det_evento_confirmacao_da_operacao = xml_evento_confirmacao_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@numItem","xs" => "http://www.portalfiscal.inf.br/nfe").first
	desc_evento_confirmacao_da_operacao = xml_evento_confirmacao_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe")
	x_just_confirmacao_da_operacao = xml_evento_confirmacao_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xJust","xs" => "http://www.portalfiscal.inf.br/nfe")
	# --- CIENCIA DA OPERACAO ---
	c_orgao_autor_ciencia_da_operacao = xml_evento_ciencia_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:cOrgaoAutor","xs" => "http://www.portalfiscal.inf.br/nfe").first
	tp_autor_ciencia_da_operacao = xml_evento_ciencia_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpAutor","xs" => "http://www.portalfiscal.inf.br/nfe").first
	ver_aplic_ciencia_da_operacao = xml_evento_ciencia_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:verAplic","xs" => "http://www.portalfiscal.inf.br/nfe").first
	n_prot_ciencia_da_operacao = xml_evento_ciencia_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:nProt","xs" => "http://www.portalfiscal.inf.br/nfe").first
	ch_nfe_ref_ciencia_da_operacao = xml_evento_ciencia_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:chNFeRef","xs" => "http://www.portalfiscal.inf.br/nfe").first
	x_correcao_ciencia_da_operacao = xml_evento_ciencia_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xCorrecao","xs" => "http://www.portalfiscal.inf.br/nfe").first
	x_cond_uso_ciencia_da_operacao = xml_evento_ciencia_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xCondUso","xs" => "http://www.portalfiscal.inf.br/nfe").first
	dh_emi_ciencia_da_operacao = xml_evento_ciencia_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dhEmi","xs" => "http://www.portalfiscal.inf.br/nfe").first
	tp_nf_ciencia_da_operacao = xml_evento_ciencia_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpNF","xs" => "http://www.portalfiscal.inf.br/nfe").first
	ie_ciencia_da_operacao = xml_evento_ciencia_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:IE","xs" => "http://www.portalfiscal.inf.br/nfe").first
	dest_ciencia_da_operacao = xml_evento_ciencia_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest","xs" => "http://www.portalfiscal.inf.br/nfe").first
	v_nf_ciencia_da_operacao = xml_evento_ciencia_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:vNF","xs" => "http://www.portalfiscal.inf.br/nfe").first
	v_icms_ciencia_da_operacao = xml_evento_ciencia_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:vICMS","xs" => "http://www.portalfiscal.inf.br/nfe").first
	v_st_ciencia_da_operacao = xml_evento_ciencia_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:vST","xs" => "http://www.portalfiscal.inf.br/nfe").first
	item_pedido_ciencia_da_operacao = xml_evento_ciencia_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:itemPedido","xs" => "http://www.portalfiscal.inf.br/nfe").first
	qtde_item_ciencia_da_operacao = xml_evento_ciencia_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:qtdeItem","xs" => "http://www.portalfiscal.inf.br/nfe").first
	aut_xml_ciencia_da_operacao = xml_evento_ciencia_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:autXML","xs" => "http://www.portalfiscal.inf.br/nfe").first
	tp_autorizacao_ciencia_da_operacao = xml_evento_ciencia_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpAutorizacao","xs" => "http://www.portalfiscal.inf.br/nfe").first
	versao_env_evento_ciencia_da_operacao = xml_evento_ciencia_da_operacao.xpath("//xs:envEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
	tp_evento_ciencia_da_operacao = xml_evento_ciencia_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:tpEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
	ver_evento_ciencia_da_operacao = xml_evento_ciencia_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:verEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
	versao_det_evento_ciencia_da_operacao = xml_evento_ciencia_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
	num_item_det_evento_ciencia_da_operacao = xml_evento_ciencia_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@numItem","xs" => "http://www.portalfiscal.inf.br/nfe").first
	desc_evento_ciencia_da_operacao = xml_evento_ciencia_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe")
	x_just_ciencia_da_operacao = xml_evento_ciencia_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xJust","xs" => "http://www.portalfiscal.inf.br/nfe")
	# --- DESCONHECIMENTO DA OPERACAO ---
	c_orgao_autor_desconhecimento_da_operacao = xml_evento_desconhecimento_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:cOrgaoAutor","xs" => "http://www.portalfiscal.inf.br/nfe").first
	tp_autor_desconhecimento_da_operacao = xml_evento_desconhecimento_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpAutor","xs" => "http://www.portalfiscal.inf.br/nfe").first
	ver_aplic_desconhecimento_da_operacao = xml_evento_desconhecimento_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:verAplic","xs" => "http://www.portalfiscal.inf.br/nfe").first
	n_prot_desconhecimento_da_operacao = xml_evento_desconhecimento_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:nProt","xs" => "http://www.portalfiscal.inf.br/nfe").first
	ch_nfe_ref_desconhecimento_da_operacao = xml_evento_desconhecimento_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:chNFeRef","xs" => "http://www.portalfiscal.inf.br/nfe").first
	x_correcao_desconhecimento_da_operacao = xml_evento_desconhecimento_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xCorrecao","xs" => "http://www.portalfiscal.inf.br/nfe").first
	x_cond_uso_desconhecimento_da_operacao = xml_evento_desconhecimento_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xCondUso","xs" => "http://www.portalfiscal.inf.br/nfe").first
	dh_emi_desconhecimento_da_operacao = xml_evento_desconhecimento_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dhEmi","xs" => "http://www.portalfiscal.inf.br/nfe").first
	tp_nf_desconhecimento_da_operacao = xml_evento_desconhecimento_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpNF","xs" => "http://www.portalfiscal.inf.br/nfe").first
	ie_desconhecimento_da_operacao = xml_evento_desconhecimento_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:IE","xs" => "http://www.portalfiscal.inf.br/nfe").first
	dest_desconhecimento_da_operacao = xml_evento_desconhecimento_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest","xs" => "http://www.portalfiscal.inf.br/nfe").first
	v_nf_desconhecimento_da_operacao = xml_evento_desconhecimento_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:vNF","xs" => "http://www.portalfiscal.inf.br/nfe").first
	v_icms_desconhecimento_da_operacao = xml_evento_desconhecimento_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:vICMS","xs" => "http://www.portalfiscal.inf.br/nfe").first
	v_st_desconhecimento_da_operacao = xml_evento_desconhecimento_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:vST","xs" => "http://www.portalfiscal.inf.br/nfe").first
	item_pedido_desconhecimento_da_operacao = xml_evento_desconhecimento_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:itemPedido","xs" => "http://www.portalfiscal.inf.br/nfe").first
	qtde_item_desconhecimento_da_operacao = xml_evento_desconhecimento_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:qtdeItem","xs" => "http://www.portalfiscal.inf.br/nfe").first
	aut_xml_desconhecimento_da_operacao = xml_evento_desconhecimento_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:autXML","xs" => "http://www.portalfiscal.inf.br/nfe").first
	tp_autorizacao_desconhecimento_da_operacao = xml_evento_desconhecimento_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpAutorizacao","xs" => "http://www.portalfiscal.inf.br/nfe").first
	versao_env_evento_desconhecimento_da_operacao = xml_evento_desconhecimento_da_operacao.xpath("//xs:envEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
	tp_evento_desconhecimento_da_operacao = xml_evento_desconhecimento_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:tpEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
	ver_evento_desconhecimento_da_operacao = xml_evento_desconhecimento_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:verEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
	versao_det_evento_desconhecimento_da_operacao = xml_evento_desconhecimento_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
	num_item_det_evento_desconhecimento_da_operacao = xml_evento_desconhecimento_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@numItem","xs" => "http://www.portalfiscal.inf.br/nfe").first
	desc_evento_desconhecimento_da_operacao = xml_evento_desconhecimento_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe")
	x_just_desconhecimento_da_operacao = xml_evento_desconhecimento_da_operacao.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xJust","xs" => "http://www.portalfiscal.inf.br/nfe")
	# --- OPERACAO NAO REALIZADA ---
	c_orgao_autor_operacao_nao_realizada = xml_evento_operacao_nao_realizada.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:cOrgaoAutor","xs" => "http://www.portalfiscal.inf.br/nfe").first
	tp_autor_operacao_nao_realizada = xml_evento_operacao_nao_realizada.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpAutor","xs" => "http://www.portalfiscal.inf.br/nfe").first
	ver_aplic_operacao_nao_realizada = xml_evento_operacao_nao_realizada.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:verAplic","xs" => "http://www.portalfiscal.inf.br/nfe").first
	n_prot_operacao_nao_realizada = xml_evento_operacao_nao_realizada.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:nProt","xs" => "http://www.portalfiscal.inf.br/nfe").first
	ch_nfe_ref_operacao_nao_realizada = xml_evento_operacao_nao_realizada.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:chNFeRef","xs" => "http://www.portalfiscal.inf.br/nfe").first
	x_correcao_operacao_nao_realizada = xml_evento_operacao_nao_realizada.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xCorrecao","xs" => "http://www.portalfiscal.inf.br/nfe").first
	x_cond_uso_operacao_nao_realizada = xml_evento_operacao_nao_realizada.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xCondUso","xs" => "http://www.portalfiscal.inf.br/nfe").first
	dh_emi_operacao_nao_realizada = xml_evento_operacao_nao_realizada.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dhEmi","xs" => "http://www.portalfiscal.inf.br/nfe").first
	tp_nf_operacao_nao_realizada = xml_evento_operacao_nao_realizada.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpNF","xs" => "http://www.portalfiscal.inf.br/nfe").first
	ie_operacao_nao_realizada = xml_evento_operacao_nao_realizada.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:IE","xs" => "http://www.portalfiscal.inf.br/nfe").first
	dest_operacao_nao_realizada = xml_evento_operacao_nao_realizada.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest","xs" => "http://www.portalfiscal.inf.br/nfe").first
	v_nf_operacao_nao_realizada = xml_evento_operacao_nao_realizada.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:vNF","xs" => "http://www.portalfiscal.inf.br/nfe").first
	v_icms_operacao_nao_realizada = xml_evento_operacao_nao_realizada.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:vICMS","xs" => "http://www.portalfiscal.inf.br/nfe").first
	v_st_operacao_nao_realizada = xml_evento_operacao_nao_realizada.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:vST","xs" => "http://www.portalfiscal.inf.br/nfe").first
	item_pedido_operacao_nao_realizada = xml_evento_operacao_nao_realizada.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:itemPedido","xs" => "http://www.portalfiscal.inf.br/nfe").first
	qtde_item_operacao_nao_realizada = xml_evento_operacao_nao_realizada.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:qtdeItem","xs" => "http://www.portalfiscal.inf.br/nfe").first
	aut_xml_operacao_nao_realizada = xml_evento_operacao_nao_realizada.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:autXML","xs" => "http://www.portalfiscal.inf.br/nfe").first
	tp_autorizacao_operacao_nao_realizada = xml_evento_operacao_nao_realizada.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpAutorizacao","xs" => "http://www.portalfiscal.inf.br/nfe").first
	versao_env_evento_operacao_nao_realizada = xml_evento_operacao_nao_realizada.xpath("//xs:envEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
	tp_evento_operacao_nao_realizada = xml_evento_operacao_nao_realizada.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:tpEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
	ver_evento_operacao_nao_realizada = xml_evento_operacao_nao_realizada.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:verEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
	versao_det_evento_operacao_nao_realizada = xml_evento_operacao_nao_realizada.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
	num_item_det_evento_operacao_nao_realizada = xml_evento_operacao_nao_realizada.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@numItem","xs" => "http://www.portalfiscal.inf.br/nfe").first
	desc_evento_operacao_nao_realizada = xml_evento_operacao_nao_realizada.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe")
	x_just_operacao_nao_realizada = xml_evento_operacao_nao_realizada.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xJust","xs" => "http://www.portalfiscal.inf.br/nfe")
	# --- EMISSAO EM CONTINGENCIA ---
	tipo_autor_emissao_em_contingencia = xml_evento_emissao_contingencia.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpAutor","xs" => "http://www.portalfiscal.inf.br/nfe")
	n_prot_emissao_em_contingencia = xml_evento_emissao_contingencia.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:nProt","xs" => "http://www.portalfiscal.inf.br/nfe")
	ch_nfe_ref_emissao_em_contingencia = xml_evento_emissao_contingencia.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:chNFeRef","xs" => "http://www.portalfiscal.inf.br/nfe")
	x_correcao_emissao_em_contingencia = xml_evento_emissao_contingencia.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xCorrecao","xs" => "http://www.portalfiscal.inf.br/nfe")
	x_cond_uso_emissao_em_contingencia = xml_evento_emissao_contingencia.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xCondUso","xs" => "http://www.portalfiscal.inf.br/nfe")
	x_just_emissao_em_contingencia = xml_evento_emissao_contingencia.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xJust","xs" => "http://www.portalfiscal.inf.br/nfe")
	versao_env_evento_emissao_em_contingencia = xml_evento_emissao_contingencia.xpath("//xs:envEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe")
	tp_evento_emissao_em_contingencia = xml_evento_emissao_contingencia.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:tpEvento","xs" => "http://www.portalfiscal.inf.br/nfe")
	ver_evento_emissao_em_contingencia = xml_evento_emissao_contingencia.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:verEvento","xs" => "http://www.portalfiscal.inf.br/nfe")
	versao_det_evento_emissao_em_contingencia = xml_evento_emissao_contingencia.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe")
	num_item_det_evento_emissao_em_contingencia = xml_evento_emissao_contingencia.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@numItem","xs" => "http://www.portalfiscal.inf.br/nfe")
	desc_evento_emissao_em_contingencia = xml_evento_emissao_contingencia.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe")
	c_orgao_autor_emissao_em_contingencia = xml_evento_emissao_contingencia.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:cOrgaoAutor","xs" => "http://www.portalfiscal.inf.br/nfe")
	ver_aplic_emissao_em_contingencia = xml_evento_emissao_contingencia.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:verAplic","xs" => "http://www.portalfiscal.inf.br/nfe")
	item_pedido_emissao_em_contingencia = xml_evento_emissao_contingencia.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:itemPedido","xs" => "http://www.portalfiscal.inf.br/nfe")
	qtde_item_emissao_em_contingencia = xml_evento_emissao_contingencia.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:qtdeItem","xs" => "http://www.portalfiscal.inf.br/nfe")
	aut_xml_emissao_em_contingencia = xml_evento_emissao_contingencia.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:autXML","xs" => "http://www.portalfiscal.inf.br/nfe")
	tp_autorizacao_emissao_em_contingencia = xml_evento_emissao_contingencia.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpAutorizacao","xs" => "http://www.portalfiscal.inf.br/nfe")
	# --- CANCELAR PRAZO 1 ---
	versao_env_evento_cancelar_prazo_1 = xml_evento_cancelamento_prazo_1.xpath("//xs:envEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
	tp_evento_cancelar_prazo_1 = xml_evento_cancelamento_prazo_1.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:tpEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
	versao_det_evento_cancelar_prazo_1 = xml_evento_cancelamento_prazo_1.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
	desc_evento_cancelar_prazo_1 = xml_evento_cancelamento_prazo_1.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
	nprot_cancelar_prazo_1 = xml_evento_cancelamento_prazo_1.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:nProt","xs" => "http://www.portalfiscal.inf.br/nfe")
	item_pedido_cancelar_prazo_1 = xml_evento_cancelamento_prazo_1.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:itemPedido","xs" => "http://www.portalfiscal.inf.br/nfe")
	num_item_cancelar_prazo_1 = xml_evento_cancelamento_prazo_1.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@numItem","xs" => "http://www.portalfiscal.inf.br/nfe").first
	qtde_item_cancelar_prazo_1 = xml_evento_cancelamento_prazo_1.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:qtdeItem","xs" => "http://www.portalfiscal.inf.br/nfe").first	
	# --- CANCELAR PRAZO 2 ---
	versao_env_evento_cancelar_prazo_2 = xml_evento_cancelamento_prazo_2.xpath("//xs:envEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
	tp_evento_cancelar_prazo_2 = xml_evento_cancelamento_prazo_2.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:tpEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
	versao_det_evento_cancelar_prazo_2 = xml_evento_cancelamento_prazo_2.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
	desc_evento_cancelar_prazo_2 = xml_evento_cancelamento_prazo_2.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
	nprot_cancelar_prazo_2 = xml_evento_cancelamento_prazo_2.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:nProt","xs" => "http://www.portalfiscal.inf.br/nfe")
	item_pedido_cancelar_prazo_2 = xml_evento_cancelamento_prazo_2.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:itemPedido","xs" => "http://www.portalfiscal.inf.br/nfe")
	num_item_cancelar_prazo_2 = xml_evento_cancelamento_prazo_2.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@numItem","xs" => "http://www.portalfiscal.inf.br/nfe").first
	qtde_item_cancelar_prazo_2 = xml_evento_cancelamento_prazo_2.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:qtdeItem","xs" => "http://www.portalfiscal.inf.br/nfe").first	
	# --- CONSULTAR RETORNO AUTORIZACAO ---
	versao_cons_reci_nfe_consultar_retorno_autorizacao = xml_consultar_retorno_autorizacao.xpath("//xs:consReciNFe//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
	# --- CONSULTA PROTOCOLO ---
	versao_cons_sit_nfe_consulta_protocolo = xml_consultar_protocolo.xpath("//xs:consSitNFe//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
	# --- DISTRIBUICAO DFE ---
	versao_dist_dfe_int_nfe_distribuicao_dfe = xml_nfe_distribuicao_dfe.xpath("//xs:distDFeInt//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
	# --- CONSULTAR CADASTRO ---
	versao_cons_cad_consultar_cadastro = xml_consultar_cadastro.xpath("//xs:ConsCad//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
	csts_operacao_isenta = ["40","41"]
	csosns_operacao_isenta = ["103","300","400"]

	it "deve criar um xml válido para mensagem de autorizacao de notas" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_autorizacao))
		puts schema.validate(xml_autorizacao) if !schema.valid?(xml_autorizacao)
		expect(schema.valid?(xml_autorizacao)).to be(true)
	end

	it "deve criar um xml válido para mensagem de inutilizacao de notas" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_inutilizacao))
		puts schema.validate(xml_inutilizacao) if !schema.valid?(xml_inutilizacao)
		expect(schema.valid?(xml_inutilizacao)).to be(true)
	end

	it "deve criar um xml válido para mensagem de evento de carta de correção" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_carta_correcao))
		puts schema.validate(xml_evento_carta_correcao) if !schema.valid?(xml_evento_carta_correcao)
		expect(schema.valid?(xml_evento_carta_correcao)).to be(true)
	end

	it "deve criar um xml válido para mensagem de cancelamento de nota" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_cancelar_nota))
		puts schema.validate(xml_evento_cancelar_nota) if !schema.valid?(xml_evento_cancelar_nota)
		expect(schema.valid?(xml_evento_cancelar_nota)).to be(true)
	end

	it "deve criar um xml válido para mensagem de consulta de status" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_consultar_status_servico))
		puts schema.validate(xml_consultar_status_servico) if !schema.valid?(xml_consultar_status_servico)
		expect(schema.valid?(xml_consultar_status_servico)).to be(true)
	end

	it "deve criar um xml válido para mensagem de cancelamento de nota substituicao" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_cancelar_nota_substituicao))
		puts schema.validate(xml_evento_cancelar_nota_substituicao) if !schema.valid?(xml_evento_cancelar_nota_substituicao)
		expect(schema.valid?(xml_evento_cancelar_nota_substituicao)).to be(true)
	end

	it "deve criar um xml válido para mensagem de prorrogamento de prazo 1" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_prorrogar_prazo_1))
		puts schema.validate(xml_evento_prorrogar_prazo_1) if !schema.valid?(xml_evento_prorrogar_prazo_1)
		expect(schema.valid?(xml_evento_prorrogar_prazo_1)).to be(true)
	end

	it "deve criar um xml válido para mensagem de prorrogamento de prazo 2" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_prorrogar_prazo_2))
		puts schema.validate(xml_evento_prorrogar_prazo_2) if !schema.valid?(xml_evento_prorrogar_prazo_2)
		expect(schema.valid?(xml_evento_prorrogar_prazo_2)).to be(true)
	end

	it "deve criar um xml válido para mensagem de ator interessado" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_ator_interessado))
		puts schema.validate(xml_evento_ator_interessado) if !schema.valid?(xml_evento_ator_interessado)
		expect(schema.valid?(xml_evento_ator_interessado)).to be(true)
	end

	it "deve criar um xml válido para mensagem de confirmacao da operacao" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_confirmacao_da_operacao))
		puts schema.validate(xml_evento_confirmacao_da_operacao) if !schema.valid?(xml_evento_confirmacao_da_operacao)
		expect(schema.valid?(xml_evento_confirmacao_da_operacao)).to be(true)
	end

	it "deve criar um xml válido para mensagem de ciencia da operacao" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_ciencia_da_operacao))
		puts schema.validate(xml_evento_ciencia_da_operacao) if !schema.valid?(xml_evento_ciencia_da_operacao)
		expect(schema.valid?(xml_evento_ciencia_da_operacao)).to be(true)
	end

	it "deve criar um xml válido para mensagem de desconhecimento da operacao" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_desconhecimento_da_operacao))
		puts schema.validate(xml_evento_desconhecimento_da_operacao) if !schema.valid?(xml_evento_desconhecimento_da_operacao)
		expect(schema.valid?(xml_evento_desconhecimento_da_operacao)).to be(true)
	end

	it "deve criar um xml válido para mensagem de operacao não realizada" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_operacao_nao_realizada))
		puts schema.validate(xml_evento_operacao_nao_realizada) if !schema.valid?(xml_evento_operacao_nao_realizada)
		expect(schema.valid?(xml_evento_operacao_nao_realizada)).to be(true)
	end

	it "deve criar um xml válido para mensagem de emissao em contingencia" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_emissao_contingencia))
		puts schema.validate(xml_evento_emissao_contingencia) if !schema.valid?(xml_evento_emissao_contingencia)
		expect(schema.valid?(xml_evento_emissao_contingencia)).to be(true)
	end

	it "deve criar um xml válido para mensagem de consulta de retorno de autorização" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_consultar_retorno_autorizacao))
		puts schema.validate(xml_consultar_retorno_autorizacao) if !schema.valid?(xml_consultar_retorno_autorizacao)
		expect(schema.valid?(xml_consultar_retorno_autorizacao)).to be(true)
	end

	it "deve criar um xml válido para mensagem de consultar protocolo" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_consultar_protocolo))
		puts schema.validate(xml_consultar_protocolo) if !schema.valid?(xml_consultar_protocolo)
		expect(schema.valid?(xml_consultar_protocolo)).to be(true)
	end

	it "deve criar um xml válido para mensagem de distribuicao dfe" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_nfe_distribuicao_dfe))
		puts schema.validate(xml_nfe_distribuicao_dfe) if !schema.valid?(xml_nfe_distribuicao_dfe)
		expect(schema.valid?(xml_nfe_distribuicao_dfe)).to be(true)
	end

	it "deve criar um xml válido para mensagem de consultar cadastro" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_consultar_cadastro))
		puts schema.validate(xml_consultar_cadastro) if !schema.valid?(xml_consultar_cadastro)
		expect(schema.valid?(xml_consultar_cadastro)).to be(true)
	end

	# -- CONSULTA CADASTRO ---

	it "deve conter valor '2.00' no atributo 'versao' da tag ConsCad em consultar cadastro" do |test|
		condicao = versao_cons_cad_consultar_cadastro.content == '2.00'
		expect(condicao).to be(true)
	end

	# --- DISTRIBUICAO DFE ---

	it "deve conter valor '1.01' no atributo 'versao' da tag distDFeInt em distribuicao dfe" do |test|
		condicao = versao_dist_dfe_int_nfe_distribuicao_dfe.content == '1.01'
		expect(condicao).to be(true)
	end

	# --- CONSULTAR PROTOCOLO ---

	it "deve conter valor '4.00' no atributo 'versao' da tag consSitNFe em consulta de protocolo" do |test|
		condicao = versao_cons_sit_nfe_consulta_protocolo.content == '4.00'
		expect(condicao).to be(true)
	end

	# --- CONSULTAR RETORNO DE AUTORIZACAO ---

	it "deve conter valor '4.00' no atributo 'versao' da tag consReciNFe em consulta de retorno de autorização" do |test|
		condicao = versao_cons_reci_nfe_consultar_retorno_autorizacao.content == '4.00'
		expect(condicao).to be(true)
	end

	# --- CANCELAR PRAZO 2 ---

	it "deve conter valor '111503' em tag tpEvento em cancelamento de prazo 2"  do |test|
		condicao = tp_evento_cancelar_prazo_2.content == '111503'
		expect(condicao).to be(true)
	end

	it "deve conter valor '1.00' no atributo 'versao' da tag envEvento em cancelamento de prazo 2" do |test|
		condicao = versao_env_evento_cancelar_prazo_2.content == '1.00'
		expect(condicao).to be(true)
	end

	it "deve conter atributo 'versao' na tag detEvento em cancelamento de prazo 2" do |test|
		condicao = !versao_det_evento_cancelar_prazo_2.nil?
		expect(condicao).to be(true)
	end

	it "deve conter tag descEvento com valor 'Pedido de Prorrogacao' em cancelamento de prazo 2" do |test|
		condicao = desc_evento_cancelar_prazo_2.content == 'Pedido de Prorrogacao'
		expect(condicao).to be(true)
	end

	it "deve conter apenas uma tag nProt em cancelamento de prazo 2" do |test|
		condicao = nprot_cancelar_prazo_2.length == 1
		expect(condicao).to be(true)
	end

	it "deve conter pelo menos uma tag itemPedido em cancelamento de prazo 2" do |test|
		condicao = item_pedido_cancelar_prazo_2.length >= 1
		expect(condicao).to be(true)
	end

	it "deve conter atributo 'numItem' na tag detEvento em cancelamento de prazo 2" do |test|
		condicao = !num_item_cancelar_prazo_2.nil?
		expect(condicao).to be(true)
	end

	it "deve conter tag qtdeItem em cancelamento de prazo 2" do |test|
		condicao = !qtde_item_cancelar_prazo_2.nil?
		expect(condicao).to be(true)
	end

	# --- CANCELAR PRAZO 1 ---

	it "deve conter valor '111502' em tag tpEvento em cancelamento de prazo 1"  do |test|
		condicao = tp_evento_cancelar_prazo_1.content == '111502'
		expect(condicao).to be(true)
	end

	it "deve conter valor '1.00' no atributo 'versao' da tag envEvento em cancelamento de prazo 1" do |test|
		condicao = versao_env_evento_cancelar_prazo_1.content == '1.00'
		expect(condicao).to be(true)
	end

	it "deve conter atributo 'versao' na tag detEvento em cancelamento de prazo 1" do |test|
		condicao = !versao_det_evento_cancelar_prazo_1.nil?
		expect(condicao).to be(true)
	end

	it "deve conter tag descEvento com valor 'Pedido de Prorrogacao' em cancelamento de prazo 1" do |test|
		condicao = desc_evento_cancelar_prazo_1.content == 'Pedido de Prorrogacao'
		expect(condicao).to be(true)
	end

	it "deve conter apenas uma tag nProt em cancelamento de prazo 1" do |test|
		condicao = nprot_cancelar_prazo_1.length == 1
		expect(condicao).to be(true)
	end

	it "deve conter pelo menos uma tag itemPedido em cancelamento de prazo 1" do |test|
		condicao = item_pedido_cancelar_prazo_1.length >= 1
		expect(condicao).to be(true)
	end

	it "deve conter atributo 'numItem' na tag detEvento em cancelamento de prazo 1" do |test|
		condicao = !num_item_cancelar_prazo_1.nil?
		expect(condicao).to be(true)
	end

	it "deve conter tag qtdeItem em cancelamento de prazo 1" do |test|
		condicao = !qtde_item_cancelar_prazo_1.nil?
		expect(condicao).to be(true)
	end

	# --- EMISSAO EM CONTINGENCIA ---

	it "não deve conter tag autXML em emissao em contingencia" do |test|
		condicao = aut_xml_emissao_em_contingencia.length == 0
		expect(condicao).to be(true)
	end

	it "não deve conter tag tpAutorizacao em emissao em contingencia" do |test|
		condicao = tp_autorizacao_emissao_em_contingencia.length == 0
		expect(condicao).to be(true)
	end

	it "deve conter apenas uma tag descEvento em emissao em contingencia" do |test|
		condicao = desc_evento_emissao_em_contingencia.length == 1
		expect(condicao).to be(true)
	end

	it "deve conter apenas uma tag cOrgaoAutor em emissao em contingencia" do |test|
		condicao = c_orgao_autor_emissao_em_contingencia.length == 1
		expect(condicao).to be(true)
	end

	it "deve conter apenas uma tag verAplic em emissao em contingencia" do |test|
		condicao = ver_aplic_emissao_em_contingencia.length == 1
		expect(condicao).to be(true)
	end

	it "não deve conter tag itemPedido em emissao em contingencia" do |test|
		condicao = item_pedido_emissao_em_contingencia.length == 0
		expect(condicao).to be(true)
	end

	it "não deve conter tag qtdeItem em emissao em contingencia" do |test|
		condicao = qtde_item_emissao_em_contingencia.length == 0
		expect(condicao).to be(true)
	end

	it "deve conter valor '1' em tag tpAutor em emissao em contingencia" do |test|
		condicao = tipo_autor_emissao_em_contingencia.first.content == '1'
		expect(condicao).to be(true)
	end

	it "não deve conter tag nProt em emissao em contingencia" do |test|
		condicao = n_prot_emissao_em_contingencia.length == 0
		expect(condicao).to be(true)
	end

	it "não deve conter tag chNFeRef em emissao em contingencia" do |test|
		condicao = ch_nfe_ref_emissao_em_contingencia.length == 0
		expect(condicao).to be(true)
	end

	it "não deve conter tag xCorrecao em emissao em contingencia" do |test|
		condicao = x_correcao_emissao_em_contingencia.length == 0
		expect(condicao).to be(true)
	end

	it "não deve conter tag xCondUso em emissao em contingencia" do |test|
		condicao = x_cond_uso_emissao_em_contingencia.length == 0
		expect(condicao).to be(true)
	end

	it "não deve conter tag xJust em emissao em contingencia" do |test|
		condicao = x_just_emissao_em_contingencia.length == 0
		expect(condicao).to be(true)
	end

	it "deve conter valor '1.00' em atributo 'versao' de tag envEvento em emissao em contingencia" do |test|
		condicao = versao_env_evento_emissao_em_contingencia.first.content == '1.00'
		expect(condicao).to be(true)
	end

	it "deve conter valor '110140' em tag tpEvento em emissao em contingencia" do |test|
		condicao = tp_evento_emissao_em_contingencia.first.content == '110140'
		expect(condicao).to be(true)
	end

	it "deve conter valor '1.00' em tag verEvento em emissao em contingencia" do |test|
		condicao = ver_evento_emissao_em_contingencia.first.content == '1.00'
		expect(condicao).to be(true)
	end

	it "deve conter valor '1.00' em atributo 'versao' de tag detEvento em emissao em contingencia" do |test|
		condicao = versao_det_evento_emissao_em_contingencia.first.content == '1.00'
		expect(condicao).to be(true)
	end

	it "não deve conter atributo 'numItem' em tag detEvento em emissao em contingencia" do |test|
		condicao = num_item_det_evento_emissao_em_contingencia.length == 0
		expect(condicao).to be(true)
	end

	it "deve conter valor 'EPEC' em tag descEvento em emissao em contingencia" do |test|
		condicao = desc_evento_emissao_em_contingencia.first.content == 'EPEC'
		expect(condicao).to be(true)
	end

	# --- OPERACAO NAO REALIZADA ---

	it "deve conter apenas uma tag xJust em operacao nao realizada" do |test|
		condicao = x_just_operacao_nao_realizada.length == 1
		expect(condicao).to be(true)
	end

	it "deve conter valor '1.00' em atributo 'versao' de tag envEvento em operacao nao realizada" do |test|
		condicao = versao_env_evento_operacao_nao_realizada.content == '1.00'
		expect(condicao).to be(true)
	end

	it "deve conter valor '210240' em tag tpEvento em operacao nao realizada" do |test|
		condicao = tp_evento_operacao_nao_realizada.content == '210240'
		expect(condicao).to be(true)
	end

	it "deve conter valor '1.00' em tag verEvento em operacao nao realizada" do |test|
		condicao = ver_evento_operacao_nao_realizada.content == '1.00'
		expect(condicao).to be(true)
	end

	it "deve conter valor '1.00' em atributo 'versao' de tag detEvento em operacao nao realizada" do |test|
		condicao = versao_det_evento_operacao_nao_realizada.content == '1.00'
		expect(condicao).to be(true)
	end

	it "não deve conter atributo 'numItem' em tag detEvento em operacao nao realizada" do |test|
		condicao = num_item_det_evento_operacao_nao_realizada.nil?
		expect(condicao).to be(true)
	end

	it "deve conter valor 'Operacao nao Realizada' em tag descEvento em operacao nao realizada" do |test|
		condicao = desc_evento_operacao_nao_realizada.first.content == 'Operacao nao Realizada'
		expect(condicao).to be(true)
	end

	it "deve conter apenas uma tag descEvento em operacao nao realizada" do |test|
		condicao = desc_evento_operacao_nao_realizada.length == 1
		expect(condicao).to be(true)
	end

	it "não deve conter tag cOrgaoAutor em operacao nao realizada" do |test|
		condicao = c_orgao_autor_operacao_nao_realizada.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag tpAutor em operacao nao realizada" do |test|
		condicao = tp_autor_operacao_nao_realizada.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag verAplic em operacao nao realizada" do |test|
		condicao = ver_aplic_operacao_nao_realizada.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag nProt em operacao nao realizada" do |test|
		condicao = n_prot_operacao_nao_realizada.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag chNFeRef em operacao nao realizada" do |test|
		condicao = ch_nfe_ref_operacao_nao_realizada.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag xCorrecao em operacao nao realizada" do |test|
		condicao = x_correcao_operacao_nao_realizada.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag xCondUso em operacao nao realizada" do |test|
		condicao = x_cond_uso_operacao_nao_realizada.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag dhEmi em operacao nao realizada" do |test|
		condicao = dh_emi_operacao_nao_realizada.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag tpNF em operacao nao realizada" do |test|
		condicao = tp_nf_operacao_nao_realizada.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag IE em operacao nao realizada" do |test|
		condicao = ie_operacao_nao_realizada.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag dest em operacao nao realizada" do |test|
		condicao = dest_operacao_nao_realizada.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag vNF em operacao nao realizada" do |test|
		condicao = v_nf_operacao_nao_realizada.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag vICMS em operacao nao realizada" do |test|
		condicao = v_icms_operacao_nao_realizada.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag vST em operacao nao realizada" do |test|
		condicao = v_st_operacao_nao_realizada.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag itemPedido em operacao nao realizada" do |test|
		condicao = item_pedido_operacao_nao_realizada.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag qtdeItem em operacao nao realizada" do |test|
		condicao = qtde_item_operacao_nao_realizada.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag autXML em operacao nao realizada" do |test|
		condicao = aut_xml_operacao_nao_realizada.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag tpAutorizacao em operacao nao realizada" do |test|
		condicao = tp_autorizacao_operacao_nao_realizada.nil?
		expect(condicao).to be(true)
	end

	# --- DESCONHECIMENTO DA OPERACAO ---

	it "deve conter apenas uma tag xJust em desconhecimento da operacao" do |test|
		condicao = x_just_desconhecimento_da_operacao.length == 1
		expect(condicao).to be(true)
	end

	it "deve conter valor '1.00' em atributo 'versao' de tag envEvento em desconhecimento da operacao" do |test|
		condicao = versao_env_evento_desconhecimento_da_operacao.content == '1.00'
		expect(condicao).to be(true)
	end

	it "deve conter valor '210220' em tag tpEvento em desconhecimento da operacao" do |test|
		condicao = tp_evento_desconhecimento_da_operacao.content == '210220'
		expect(condicao).to be(true)
	end

	it "deve conter valor '1.00' em tag verEvento em desconhecimento da operacao" do |test|
		condicao = ver_evento_desconhecimento_da_operacao.content == '1.00'
		expect(condicao).to be(true)
	end

	it "deve conter valor '1.00' em atributo 'versao' de tag detEvento em desconhecimento da operacao" do |test|
		condicao = versao_det_evento_desconhecimento_da_operacao.content == '1.00'
		expect(condicao).to be(true)
	end

	it "não deve conter atributo 'numItem' em tag detEvento em desconhecimento da operacao" do |test|
		condicao = num_item_det_evento_desconhecimento_da_operacao.nil?
		expect(condicao).to be(true)
	end

	it "deve conter valor 'Desconhecimento da Operacao' em tag descEvento em desconhecimento da operacao" do |test|
		condicao = desc_evento_desconhecimento_da_operacao.first.content == 'Desconhecimento da Operacao'
		expect(condicao).to be(true)
	end

	it "deve conter apenas uma tag descEvento em desconhecimento da operacao" do |test|
		condicao = desc_evento_desconhecimento_da_operacao.length == 1
		expect(condicao).to be(true)
	end

	it "não deve conter tag cOrgaoAutor em desconhecimento da operacao" do |test|
		condicao = c_orgao_autor_desconhecimento_da_operacao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag tpAutor em desconhecimento da operacao" do |test|
		condicao = tp_autor_desconhecimento_da_operacao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag verAplic em desconhecimento da operacao" do |test|
		condicao = ver_aplic_desconhecimento_da_operacao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag nProt em desconhecimento da operacao" do |test|
		condicao = n_prot_desconhecimento_da_operacao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag chNFeRef em desconhecimento da operacao" do |test|
		condicao = ch_nfe_ref_desconhecimento_da_operacao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag xCorrecao em desconhecimento da operacao" do |test|
		condicao = x_correcao_desconhecimento_da_operacao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag xCondUso em desconhecimento da operacao" do |test|
		condicao = x_cond_uso_desconhecimento_da_operacao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag dhEmi em desconhecimento da operacao" do |test|
		condicao = dh_emi_desconhecimento_da_operacao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag tpNF em desconhecimento da operacao" do |test|
		condicao = tp_nf_desconhecimento_da_operacao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag IE em desconhecimento da operacao" do |test|
		condicao = ie_desconhecimento_da_operacao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag dest em desconhecimento da operacao" do |test|
		condicao = dest_desconhecimento_da_operacao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag vNF em desconhecimento da operacao" do |test|
		condicao = v_nf_desconhecimento_da_operacao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag vICMS em desconhecimento da operacao" do |test|
		condicao = v_icms_desconhecimento_da_operacao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag vST em desconhecimento da operacao" do |test|
		condicao = v_st_desconhecimento_da_operacao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag itemPedido em desconhecimento da operacao" do |test|
		condicao = item_pedido_desconhecimento_da_operacao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag qtdeItem em desconhecimento da operacao" do |test|
		condicao = qtde_item_desconhecimento_da_operacao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag autXML em desconhecimento da operacao" do |test|
		condicao = aut_xml_desconhecimento_da_operacao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag tpAutorizacao em desconhecimento da operacao" do |test|
		condicao = tp_autorizacao_desconhecimento_da_operacao.nil?
		expect(condicao).to be(true)
	end

	# --- CIENCIA DA OPERACAO ---

	it "deve conter apenas uma tag xJust em ciencia de operacao" do |test|
		condicao = x_just_ciencia_da_operacao.length == 1
		expect(condicao).to be(true)
	end

	it "deve conter valor '1.00' em atributo 'versao' de tag envEvento em ciencia de operacao" do |test|
		condicao = versao_env_evento_ciencia_da_operacao.content == '1.00'
		expect(condicao).to be(true)
	end

	it "deve conter valor '210210' em tag tpEvento em ciencia de operacao" do |test|
		condicao = tp_evento_ciencia_da_operacao.content == '210210'
		expect(condicao).to be(true)
	end

	it "deve conter valor '1.00' em tag verEvento em ciencia de operacao" do |test|
		condicao = ver_evento_ciencia_da_operacao.content == '1.00'
		expect(condicao).to be(true)
	end

	it "deve conter valor '1.00' em atributo 'versao' de tag detEvento em ciencia de operacao" do |test|
		condicao = versao_det_evento_ciencia_da_operacao.content == '1.00'
		expect(condicao).to be(true)
	end

	it "não deve conter atributo 'numItem' em tag detEvento em ciencia de operacao" do |test|
		condicao = num_item_det_evento_ciencia_da_operacao.nil?
		expect(condicao).to be(true)
	end

	it "deve conter valor 'Ciencia da Operacao' em tag descEvento em ciencia de operacao" do |test|
		condicao = desc_evento_ciencia_da_operacao.first.content == 'Ciencia da Operacao'
		expect(condicao).to be(true)
	end

	it "deve conter apenas uma tag descEvento em ciencia de operacao" do |test|
		condicao = desc_evento_ciencia_da_operacao.length == 1
		expect(condicao).to be(true)
	end

	it "não deve conter tag cOrgaoAutor em ciencia de operacao" do |test|
		condicao = c_orgao_autor_ciencia_da_operacao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag tpAutor em ciencia de operacao" do |test|
		condicao = tp_autor_ciencia_da_operacao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag verAplic em ciencia de operacao" do |test|
		condicao = ver_aplic_ciencia_da_operacao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag nProt em ciencia de operacao" do |test|
		condicao = n_prot_ciencia_da_operacao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag chNFeRef em ciencia de operacao" do |test|
		condicao = ch_nfe_ref_ciencia_da_operacao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag xCorrecao em ciencia de operacao" do |test|
		condicao = x_correcao_ciencia_da_operacao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag xCondUso em ciencia de operacao" do |test|
		condicao = x_cond_uso_ciencia_da_operacao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag dhEmi em ciencia de operacao" do |test|
		condicao = dh_emi_ciencia_da_operacao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag tpNF em ciencia de operacao" do |test|
		condicao = tp_nf_ciencia_da_operacao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag IE em ciencia de operacao" do |test|
		condicao = ie_ciencia_da_operacao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag dest em ciencia de operacao" do |test|
		condicao = dest_ciencia_da_operacao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag vNF em ciencia de operacao" do |test|
		condicao = v_nf_ciencia_da_operacao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag vICMS em ciencia de operacao" do |test|
		condicao = v_icms_ciencia_da_operacao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag vST em ciencia de operacao" do |test|
		condicao = v_st_ciencia_da_operacao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag itemPedido em ciencia de operacao" do |test|
		condicao = item_pedido_ciencia_da_operacao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag qtdeItem em ciencia de operacao" do |test|
		condicao = qtde_item_ciencia_da_operacao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag autXML em ciencia de operacao" do |test|
		condicao = aut_xml_ciencia_da_operacao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag tpAutorizacao em ciencia de operacao" do |test|
		condicao = tp_autorizacao_ciencia_da_operacao.nil?
		expect(condicao).to be(true)
	end

	# --- CONFIRMACAO DE OPERACAO ---

	it "deve conter apenas uma tag xJust em confirmacao de operacao" do |test|
		condicao = x_just_confirmacao_da_operacao.length == 1
		expect(condicao).to be(true)
	end

	it "deve conter valor '1.00' em atributo 'versao' de tag envEvento em confirmacao de operacao" do |test|
		condicao = versao_env_evento_confirmacao_da_operacao.content == '1.00'
		expect(condicao).to be(true)
	end

	it "deve conter valor '210200' em tag tpEvento em confirmacao de operacao" do |test|
		condicao = tp_evento_confirmacao_da_operacao.content == '210200'
		expect(condicao).to be(true)
	end

	it "deve conter valor '1.00' em tag verEvento em confirmacao de operacao" do |test|
		condicao = ver_evento_confirmacao_da_operacao.content == '1.00'
		expect(condicao).to be(true)
	end

	it "deve conter valor '1.00' em atributo 'versao' de tag detEvento em confirmacao de operacao" do |test|
		condicao = versao_det_evento_confirmacao_da_operacao.content == '1.00'
		expect(condicao).to be(true)
	end

	it "não deve conter atributo 'numItem' em tag detEvento em confirmacao de operacao" do |test|
		condicao = num_item_det_evento_confirmacao_da_operacao.nil?
		expect(condicao).to be(true)
	end

	it "deve conter valor 'Confirmacao da Operacao' em tag descEvento em confirmacao de operacao" do |test|
		condicao = desc_evento_confirmacao_da_operacao.first.content == 'Confirmacao da Operacao'
		expect(condicao).to be(true)
	end

	it "deve conter apenas uma tag descEvento em confirmacao de operacao" do |test|
		condicao = desc_evento_confirmacao_da_operacao.length == 1
		expect(condicao).to be(true)
	end

	it "não deve conter tag cOrgaoAutor em confirmacao de operacao" do |test|
		condicao = c_orgao_autor_confirmacao_da_operacao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag tpAutor em confirmacao de operacao" do |test|
		condicao = tp_autor_confirmacao_da_operacao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag verAplic em confirmacao de operacao" do |test|
		condicao = ver_aplic_confirmacao_da_operacao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag nProt em confirmacao de operacao" do |test|
		condicao = n_prot_confirmacao_da_operacao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag chNFeRef em confirmacao de operacao" do |test|
		condicao = ch_nfe_ref_confirmacao_da_operacao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag xCorrecao em confirmacao de operacao" do |test|
		condicao = x_correcao_confirmacao_da_operacao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag xCondUso em confirmacao de operacao" do |test|
		condicao = x_cond_uso_confirmacao_da_operacao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag dhEmi em confirmacao de operacao" do |test|
		condicao = dh_emi_confirmacao_da_operacao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag tpNF em confirmacao de operacao" do |test|
		condicao = tp_nf_confirmacao_da_operacao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag IE em confirmacao de operacao" do |test|
		condicao = ie_confirmacao_da_operacao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag dest em confirmacao de operacao" do |test|
		condicao = dest_confirmacao_da_operacao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag vNF em confirmacao de operacao" do |test|
		condicao = v_nf_confirmacao_da_operacao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag vICMS em confirmacao de operacao" do |test|
		condicao = v_icms_confirmacao_da_operacao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag vST em confirmacao de operacao" do |test|
		condicao = v_st_confirmacao_da_operacao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag itemPedido em confirmacao de operacao" do |test|
		condicao = item_pedido_confirmacao_da_operacao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag qtdeItem em confirmacao de operacao" do |test|
		condicao = qtde_item_confirmacao_da_operacao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag autXML em confirmacao de operacao" do |test|
		condicao = aut_xml_confirmacao_da_operacao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag tpAutorizacao em confirmacao de operacao" do |test|
		condicao = tp_autorizacao_confirmacao_da_operacao.nil?
		expect(condicao).to be(true)
	end

	# --- ATOR INTERESSADO ---

	it "deve conter valor 1,2 ou 3 na tag tpAutor de evento ator interessado" do |test|
		condicao = !tp_autor_ator_interessado.first.content.match(/[123]/).nil?
		expect(condicao).to be(true)
	end

	it "deve conter valor '1.00' em atributo 'versao' de tag envEvento de evento ator interessado" do |test|
		condicao = versao_env_evento_ator_interessado.content == '1.00'
		expect(condicao).to be(true)
	end

	it "deve conter valor '110150' em tag tpEvento de evento ator interessado" do |test|
		condicao = tp_evento_ator_interessado.content == '110150'
		expect(condicao).to be(true)
	end

	it "deve conter valor '1.00' em tag verEvento de evento ator interessado" do |test|
		condicao = ver_evento_ator_interessado.content == '1.00'
		expect(condicao).to be(true)	
	end

	it "deve conter valor '1.00' em atributo 'versao' de tag detEvento de evento ator interessado" do |test|
		condicao = versao_det_evento_ator_interessado.content == '1.00'
		expect(condicao).to be(true)	
	end

	it "não deve conter atributo 'numItem' em tag detEvento de evento ator interessado" do |test|
		condicao = num_item_ator_interessado.nil?
		expect(condicao).to be(true)	
	end

	it "deve conter valor 'Ator interessado na NF-e' em tag descEvento de evento ator interessado" do |test|
		condicao = desc_evento_ator_interessado.first.content == 'Ator interessado na NF-e'
		expect(condicao).to be(true)	
	end

	it "deve remover nProt de evento ator interessado" do |test|
		condicao = n_prot_ator_interessado.nil?
		expect(condicao).to be(true)
	end

	it "deve remover xJust de evento ator interessado" do |test|
		condicao = x_just_ator_interessado.nil?
		expect(condicao).to be(true)
	end

	it "deve remover chNFeRef de evento ator interessado" do |test|
		condicao = ch_nfe_ref_ator_interessado.nil?
		expect(condicao).to be(true)
	end

	it "deve remover xCorrecao de evento ator interessado" do |test|
		condicao = x_correcao_ator_interessado.nil?
		expect(condicao).to be(true)
	end

	it "deve remover dhEmi de evento ator interessado" do |test|
		condicao = dh_emi_ator_interessado.nil?
		expect(condicao).to be(true)
	end
	
	it "deve remover tpNF de evento ator interessado" do |test|
		condicao = tp_nf_ator_interessado.nil?
		expect(condicao).to be(true)
	end

	it "deve remover IE de evento ator interessado" do |test|
		condicao = ie_ator_interessado.nil?
		expect(condicao).to be(true)
	end

	it "deve remover dest de evento ator interessado" do |test|
		condicao = dest_ator_interessado.nil?
		expect(condicao).to be(true)
	end

	it "deve remover vNF de evento ator interessado" do |test|
		condicao = v_nf_ator_interessado.nil?
		expect(condicao).to be(true)
	end

	it "deve remover vICMS de evento ator interessado" do |test|
		condicao = v_icms_ator_interessado.nil?
		expect(condicao).to be(true)
	end

	it "deve remover vST de evento ator interessado" do |test|
		condicao = v_st_ator_interessado.nil?
		expect(condicao).to be(true)
	end

	it "deve remover itemPedido de evento ator interessado" do |test|
		condicao = item_pedido_ator_interessado.nil?
		expect(condicao).to be(true)
	end

	it "deve remover qtde_item de evento ator interessado" do |test|
		condicao = qtde_item_ator_interessado.nil?
		expect(condicao).to be(true)
	end

	it "deve conter apenas uma tag descEvento de evento ator interessado" do |test|
		condicao = desc_evento_ator_interessado.length == 1
		expect(condicao).to be(true)
	end

	it "deve conter apenas uma tag cOrgaoAutor de evento ator interessado" do |test|
		condicao = c_orgao_autor_ator_interessado.length == 1
		expect(condicao).to be(true)
	end

	it "deve conter apenas uma tag tpAutor de evento ator interessado" do |test|
		condicao = tp_autor_ator_interessado.length == 1
		expect(condicao).to be(true)
	end

	it "deve conter apenas uma tag verAplic de evento ator interessado" do |test|
		condicao = ver_aplic_ator_interessado.length == 1
		expect(condicao).to be(true)
	end

	it "deve conter apenas uma tag xCondUso de evento ator interessado" do |test|
		condicao = x_cond_uso_ator_interessado.length == 1
		expect(condicao).to be(true)
	end

	# --- PRORROGAMENTO DE PRAZO 2 ---

	it "deve conter valor '111501' em tag tpEvento evento de prorrogamento de prazo 2"  do |test|
		condicao = tp_evento_prorrogar_prazo_2.content == '111501'
		expect(condicao).to be(true)
	end

	it "deve conter valor '1.00' no atributo 'versao' da tag envEvento em prorrogamento de prazo 2" do |test|
		condicao = versao_env_evento_prorrogar_prazo_2.content == '1.00'
		expect(condicao).to be(true)
	end

	it "deve conter atributo 'versao' na tag detEvento em prorrogamento de prazo 2" do |test|
		condicao = !versao_det_evento_prorrogar_prazo_2.nil?
		expect(condicao).to be(true)
	end

	it "deve conter tag descEvento com valor 'Pedido de Prorrogacao' em prorrogamento de prazo 2" do |test|
		condicao = desc_evento_prorrogar_prazo_2.content == 'Pedido de Prorrogacao'
		expect(condicao).to be(true)
	end

	it "deve conter apenas uma tag nProt em prorrogamento de prazo 2" do |test|
		condicao = nprot_prorrogar_prazo_2.length == 1
		expect(condicao).to be(true)
	end

	it "deve conter pelo menos uma tag itemPedido em prorrogamento de prazo 2" do |test|
		condicao = item_pedido_prorrogar_prazo_2.length >= 1
		expect(condicao).to be(true)
	end

	it "deve conter atributo 'numItem' na tag detEvento em prorrogamento de prazo 2" do |test|
		condicao = !num_item_prorrogar_prazo_2.nil?
		expect(condicao).to be(true)
	end

	it "deve conter tag qtdeItem em prorrogamento de prazo 2" do |test|
		condicao = !qtde_item_prorrogar_prazo_2.nil?
		expect(condicao).to be(true)
	end

	# --- PRORROGAMENTO DE PRAZO 1 ---

	it "deve conter valor '111500' em tag tpEvento evento de prorrogamento de prazo 1"  do |test|
		condicao = tp_evento_prorrogar_prazo_1.content == '111500'
		expect(condicao).to be(true)
	end

	it "deve conter valor '1.00' no atributo 'versao' da tag envEvento em prorrogamento de prazo 1" do |test|
		condicao = versao_env_evento_prorrogar_prazo_1.content == '1.00'
		expect(condicao).to be(true)
	end

	it "deve conter atributo 'versao' na tag detEvento em prorrogamento de prazo 1" do |test|
		condicao = !versao_det_evento_prorrogar_prazo_1.nil?
		expect(condicao).to be(true)
	end

	it "deve conter tag descEvento com valor 'Pedido de Prorrogacao' em prorrogamento de prazo 1" do |test|
		condicao = desc_evento_prorrogar_prazo_1.content == 'Pedido de Prorrogacao'
		expect(condicao).to be(true)
	end

	it "deve conter apenas uma tag nProt em prorrogamento de prazo 1" do |test|
		condicao = nprot_prorrogar_prazo_1.length == 1
		expect(condicao).to be(true)
	end

	it "deve conter pelo menos uma tag itemPedido em prorrogamento de prazo 1" do |test|
		condicao = item_pedido_prorrogar_prazo_1.length >= 1
		expect(condicao).to be(true)
	end

	it "deve conter atributo 'numItem' na tag detEvento em prorrogamento de prazo 1" do |test|
		condicao = !num_item_prorrogar_prazo_1.nil?
		expect(condicao).to be(true)
	end

	it "deve conter tag qtdeItem em prorrogamento de prazo 1" do |test|
		condicao = !qtde_item_prorrogar_prazo_1.nil?
		expect(condicao).to be(true)
	end

	# --- CANCELAMENTO DE NOTA SUBSTITUICAO ---

	it "deve remover a tag xCondUso em cancelamento de nota substituição" do |test|
		condicao = xconduso_cancelar_nota_substituicao.nil?
		expect(condicao).to be(true)
	end

	it "deve remover a tag xCorrecao em cancelamento de nota substituição" do |test|
		condicao = xcorrecao_cancelar_nota_substituicao.nil?
		expect(condicao).to be(true)
	end

	it "deve colocar a tag chNFeRef na posição correta em cancelamento de nota substituição" do |test|
		condicao = det_evento_cancelar_nota_substituicao.children.last.name == 'chNFeRef'
		expect(condicao).to be(true)	
	end

	it "deve conter valor 110112 em tag tpEvento em cancelamento de nota substituição" do |test|
		condicao = tp_evento_cancelar_nota_substituicao.content == '110112'
		expect(condicao).to be(true)
	end

	it "deve conter valor 1.00 em atributo 'versao' de tag envEvento em cancelamento de nota substituição" do |test|
		condicao = versao_env_evento_cancelar_nota_substituicao.content == '1.00'
		expect(condicao).to be(true)
	end

	it "deve conter valor 1.00 em tag verEvento em cancelamento de nota substituição" do |test|
		condicao = ver_evento_cancelar_nota_substituicao.content == '1.00'
		expect(condicao).to be(true)
	end

	it "deve conter valor 1.00 em atributo 'versao' de tag detEvento em cancelamento de nota substituição" do |test|
		condicao = versao_det_evento_cancelar_nota_substituicao.content == '1.00'
		expect(condicao).to be(true)
	end

	it "não deve conter atributo 'numItem' em tag detEvento em cancelamento de nota substituição" do |test|
		condicao = num_item_det_evento_cancelar_nota_substituicao.nil?
		expect(condicao).to be(true)
	end

	it "deve conter valor 'Cancelamento por substituicao' em tag descEvento em cancelamento de nota substituição" do |test|
		condicao = desc_evento_cancelar_nota_substituicao.first.content == 'Cancelamento por substituicao'
		expect(condicao).to be(true)
	end

	it "deve conter valor '1' em tag tpAutor em cancelamento de nota substituição" do |test|
		condicao = tipo_autor_cancelar_nota_substituicao.first.content == '1'
		expect(condicao).to be(true)
	end

	it "deve remover a tag dhEmi em evento de cancelamento de nota substituição" do |test|
		condicao = dhemi_cancelar_nota_substituicao.nil?
		expect(condicao).to be(true)
	end

	it "deve remover a tag tpNF em evento de cancelamento de nota substituição" do |test|
		condicao = tpnf_cancelar_nota_substituicao.nil?
		expect(condicao).to be(true)
	end

	it "deve remover a tag IE em evento de cancelamento de nota substituição" do |test|
		condicao = ie_cancelar_nota_substituicao.nil?
		expect(condicao).to be(true)
	end

	it "deve remover a tag dest em evento de cancelamento de nota substituição" do |test|
		condicao = dest_cancelar_nota_substituicao.nil?
		expect(condicao).to be(true)
	end

	it "deve remover a tag vNF em evento de cancelamento de nota substituição" do |test|
		condicao = vnf_cancelar_nota_substituicao.nil?
		expect(condicao).to be(true)
	end

	it "deve remover a tag vICMS em evento de cancelamento de nota substituição" do |test|
		condicao = vicms_cancelar_nota_substituicao.nil?
		expect(condicao).to be(true)
	end

	it "deve remover a tag vST em evento de cancelamento de nota substituição" do |test|
		condicao = vst_cancelar_nota_substituicao.nil?
		expect(condicao).to be(true)
	end

	it "deve remover a tag itemPedido em evento de cancelamento de nota substituição" do |test|
		condicao = item_pedido_cancelar_nota_substituicao.nil?
		expect(condicao).to be(true)
	end

	it "deve remover a tag qtdeItem em evento de cancelamento de nota substituição" do |test|
		condicao = qtde_item_cancelar_nota_substituicao.nil?
		expect(condicao).to be(true)
	end

	it "deve conter apenas uma tag xJust em evento de cancelamento de nota substituição" do |test|
		condicao = xjust_cancelar_nota_substituicao.length == 1
		expect(condicao).to be(true)
	end

	it "deve conter apenas uma tag cOrgaoAutor em evento de cancelamento de nota substituição" do |test|
		condicao = c_orgao_autor_cancelar_nota_substituicao.length == 1
		expect(condicao).to be(true)
	end

	it "deve conter apenas uma tag tpAutor em evento de cancelamento de nota substituição" do |test|
		condicao = tipo_autor_cancelar_nota_substituicao.length == 1
		expect(condicao).to be(true)
	end

	it "deve conter apenas uma tag verAplic em evento de cancelamento de nota substituição" do |test|
		condicao = ver_aplic_cancelar_nota_substituicao.length == 1
		expect(condicao).to be(true)
	end

	it "deve conter apenas uma tag nProt em evento de cancelamento de nota substituição" do |test|
		condicao = nprot_cancelar_nota_substituicao.length == 1
		expect(condicao).to be(true)
	end

	it "deve conter apenas uma tag descEvento em evento de cancelamento de nota substituição" do |test|
		condicao = desc_evento_cancelar_nota_substituicao.length == 1
		expect(condicao).to be(true)
	end

	it "deve remover a tag autXML em evento de cancelamento de nota substituição" do |test|
		condicao = aut_xml_cancelar_nota_substituicao.nil?
		expect(condicao).to be(true)
	end

	it "deve remover a tag tpAutorizacao em evento de cancelamento de nota substituição" do |test|
		condicao = tp_autorizacao_cancelar_nota_substituicao.nil?
		expect(condicao).to be(true)
	end

	# --- CONSULTA SERVICO ---

	it "deve conter valor 4.00 em status de consulta de servico" do |test|
		condicao = status_consulta_servico.content == '4.00'
		expect(condicao).to be(true)
	end

	# --- CANCELAMENTO DE NOTA ---

	it "deve conter valor 110111 no tipo de evento de cancelamento de nota" do |test|
		condicao = (tipo_evento_cancelar_nota.content == '110111')
		expect(condicao).to be(true)
	end

	it "deve conter valor 1.00 na tag verEvento no evento de cancelamento de nota" do |test|
		condicao = (ver_evento_cancelar_nota.content == '1.00')
		expect(condicao).to be(true)
	end

	it "deve conter valor 1.00 no atributo versão da tag detEvento no evento de cancelamento de nota" do |test|
		condicao = (versao_det_evento_cancelar_nota.content == '1.00')
		expect(condicao).to be(true)
	end

	it "não deve conter atributo numItem da tag detEvento no evento de cancelamento de nota" do |test|
		condicao = num_item_cancelar_nota.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter a tag cOrgaoAutor no evento de cancelamento de nota" do |test|
		condicao = c_orgao_autor_cancelar_nota.nil?
		expect(condicao).to be(true)
	end

	it "deve conter atributo 'versao' com valor 1.00 no campo envEvento do evento de cancelamento de nota" do |test|
		condicao = (versao_env_evento_cancelar_nota.content == '1.00')
		expect(condicao).to be(true)
	end

	it "deve conter valor 'Cancelamento' em campo descEvento para evento de cancelamento de nota" do |test|
		condicao = (descricao_evento_cancelar_nota.content == 'Cancelamento')
		expect(condicao).to be(true)
	end

	it "não deve conter tag tpAutor no evento de cancelamento de nota" do |test|
		condicao = tipo_autor_cancelar_nota.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag verAplic em evento de cancelamento de nota" do |test|
		condicao = ver_aplic_cancelar_nota.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag chNFeRef em evento de cancelamento de nota" do |test|
		condicao = chnfref_cancelar_nota.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag xCorrecao em evento de cancelamento de nota" do |test|
		condicao = xcorrecao_cancelar_nota.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag xCondUso em evento de cancelamento de nota" do |test|
		condicao = xconduso_cancelar_nota.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag xJust em evento de cancelamento de nota" do |test|
		condicao = xjust_cancelar_nota.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag dhEmi em evento de cancelamento de nota" do |test|
		condicao = dhemi_cancelar_nota.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag tpNF em evento de cancelamento de nota" do |test|
		condicao = tpnf_cancelar_nota.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag IE em evento de cancelamento de nota" do |test|
		condicao = ie_cancelar_nota.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag dest em evento de cancelamento de nota" do |test|
		condicao = dest_cancelar_nota.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag vNF em evento de cancelamento de nota" do |test|
		condicao = vnf_cancelar_nota.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag vICMS em evento de cancelamento de nota" do |test|
		condicao = vicms_cancelar_nota.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag vST em evento de cancelamento de nota" do |test|
		condicao = vst_cancelar_nota.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter mais de uma tag nProt em evento de cancelamento de nota" do |test|
		condicao = nprot_cancelar_nota.length == 1
		expect(condicao).to be(true)
	end

	it "não deve conter tag itemPedido em evento de cancelamento de nota" do |test|
		condicao = item_pedido_cancelar_nota.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag qtdeItem em evento de cancelamento de nota" do |test|
		condicao = qtde_item_cancelar_nota.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag autXML em evento de cancelamento de nota" do |test|
		condicao = aut_xml_cancelar_nota.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag tpAutorizacao em evento de cancelamento de nota" do |test|
		condicao = tp_autorizacao_cancelar_nota.nil?
		expect(condicao).to be(true)
	end

	# --- CARTA CORRECAO ---

	it "deve conter valor 110110 no tipo de evento de carta correção" do |test|
		condicao = (tipo_evento_carta_correcao.content == '110110')
		expect(condicao).to be(true)
	end

	it "deve conter atributo 'versao' com valor 1.00 no campo envEvento do evento de carta de correção" do |test|
		condicao = (versao_env_evento_carta_correcao.content == '1.00')
		expect(condicao).to be(true)
	end

	it "deve conter atributo 'versao' com valor 1.00 no campo detEvento do evento de carta de correção" do |test|
		condicao = (versao_det_evento_carta_correcao.content == '1.00')
		expect(condicao).to be(true)
	end

	it "deve conter campo verEvento com valor 1.00 no evento de carta de correção" do |test|
		condicao = (ver_evento_carta_correcao.content == '1.00')
		expect(condicao).to be(true)
	end

	it "não deve conter atributo numItem no campo detEvento em evento de carta correção" do |test|
		condicao = num_item_carta_correcao.nil?
		expect(condicao).to be(true)
	end

	it "deve conter valor 'Carta de Correcao' em campo descEvento para evento de carta de correção" do |test|
		condicao = (descricao_evento_carta_correcao.content == 'Carta de Correcao')
		expect(condicao).to be(true)
	end

	it "não deve conter campo cOrgaoAutor em evento de carta de correção" do |test|
		condicao = c_orgao_autor_carta_correcao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter campo tpAutor em evento de carta de correção" do |test|
		condicao = tipo_autor_carta_correcao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag verAplic em evento de carta de correção" do |test|
		condicao = ver_aplic_carta_correcao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag nProt em evento de carta de correção" do |test|
		condicao = nprot_carta_correcao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag xJust em evento de carta de correção" do |test|
		condicao = xjust_carta_correcao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag chNFeRef em evento de carta de correção" do |test|
		condicao = chnfref_carta_correcao.nil?
		expect(condicao).to be(true)
	end

	it "deve garantir que a condição de uso está correta no evento de carta de correção" do |test|
		condicao = (!condicao_uso_carta_correcao.nil? and condicao_uso_carta_correcao.content == valor_condicao_uso_carta_correcao)
		expect(condicao).to be(true)
	end

	it "não deve conter tag dhEmi em evento de carta correção" do |test|
		condicao = dhemi_carta_correcao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag tpNF em evento de carta correção" do |test|
		condicao = tpnf_carta_correcao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag IE em evento de carta correção" do |test|
		condicao = ie_carta_correcao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag dest em evento de carta correção" do |test|
		condicao = dest_carta_correcao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag vNF em evento de carta correção" do |test|
		condicao = vnf_carta_correcao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag vICMS em evento de carta correção" do |test|
		condicao = vicms_carta_correcao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag vST em evento de carta correção" do |test|
		condicao = vst_carta_correcao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag itemPedido em evento de carta correção" do |test|
		condicao = item_pedido_carta_correcao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag qtdeItem em evento de carta correção" do |test|
		condicao = qtde_item_carta_correcao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag autXML em evento de carta correção" do |test|
		condicao = aut_xml_carta_correcao.nil?
		expect(condicao).to be(true)
	end

	it "não deve conter tag tpAutorizacao em evento de carta correção" do |test|
		condicao = tp_autorizacao_carta_correcao.nil?
		expect(condicao).to be(true)
	end

	# --- AUTORIZAR NOTA ---

	it "deve conter apenas um dos grupos: refNFe, refNF, refNFP ou refECF quando houver NFref" do |test|
		condicao = (!nfref.nil? and nfref.children.length == 1) ? true : false
		expect(condicao).to be(true)
	end

	it "deve indicar destinatario 'Não-contribuinte' caso nota seja NFCE (E16a-10)" do |test|
		condicao = (modelo_nota.content == '65' and destinatario_indicador.content != "9") ? false : true
		expect(condicao).to be(true)
	end

	it "deve indicar destinatario 'Não-contribuinte' em caso de operação com exterior para NFE (E16a-20)" do |test|
		condicao = (modelo_nota == '55' and indicador_operacao.content == '3' and destinatario_indicador.content != "9") ? false : true
		expect(condicao).to be(true)
	end

	it "deve indicar destinatario como 'Contribuinte' ou 'Não-contribuinte' para UFs que não permitem isenção em operações interestaduais (E16a-30)" do |test|
		condicao = (modelo_nota.content == "55" and destinatario_indicador.content == "2" and indicador_operacao.content == "2" and ufs_sem_isencao_interestadual.include?(destinatario_uf.content)) ? false : true
		expect(condicao).to be(true)
	end

	it "deve informar tag IE da NFE quando destinatario for 'Contribuinte' (E17-20)" do |test|
		condicao = (modelo_nota.content == '55' and destinatario_indicador.to_s == '1' and destinatario_inscricao_estadual.nil?) ? false : true
		expect(condicao).to be(true)
	end

	it "não deve informar tag IE da NFE quando destinatario for 'Isento' (E17-30)" do |test|
		condicao = (modelo_nota.content == "55" and !destinatario_inscricao_estadual.nil? and !destinatario_indicador.nil? and destinatario_indicador.content == '2') ? false : true
		expect(condicao).to be(true)
	end

	it "não deve informar tag vagao quando for NFCE (X25a-10)" do |test|
		condicao = (modelo_nota.content == "65" and !vagao.nil?) ? false : true
		expect(condicao).to be(true)
	end

	it "não deve informar tag de inscrição estadual quando houver um CPF no grupo entrega ()" do |test|
		condicao = (!grupo_entrega_cpf.nil? and !grupo_entrega_inscricao_estadual.nil?) ? false : true
		expect(condicao).to be(true)
	end

	it "NFCE não deve ter inscrição na suframa (E18-10)" do |test|
		condicao = (modelo_nota.content == '65' and !inscricao_suframa.nil?) ? false : true
		expect(condicao).to be(true)
	end
end