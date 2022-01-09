require 'simplecov'
SimpleCov.start

require './nf/api/builder.rb'
require './nf/mock/generator.rb'
require 'nokogiri'
require 'pry'
require 'openssl'

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
	#xml_autorizacao = NF::Mock::Generator.autorizar_nota(File.open("nota_exemplo.xml") { |f| Nokogiri::XML(f) })
	xml_autorizacao = NF::Mock::Generator.autorizar_nota(nil)
	xml_inutilizacao = NF::Mock::Generator.inutilizar_numeracao(nil)
	xml_evento_carta_correcao = NF::Mock::Generator.criar_carta_correcao(nil)
	xml_evento_cancelar_nota = NF::Mock::Generator.cancelar_nota(nil)
	xml_consultar_status_servico = NF::Mock::Generator.consultar_status_servico(nil)
	xml_evento_cancelar_nota_substituicao = NF::Mock::Generator.cancelar_nota_substituicao(nil)
	xml_evento_prorrogar_prazo_1 = NF::Mock::Generator.prorrogar_prazo_1(nil)
	xml_evento_prorrogar_prazo_2 = NF::Mock::Generator.prorrogar_prazo_2(nil)
	xml_evento_ator_interessado = NF::Mock::Generator.ator_interessado(nil)
	xml_evento_confirmacao_da_operacao = NF::Mock::Generator.confirmacao_da_operacao(nil)
	xml_evento_ciencia_da_operacao = NF::Mock::Generator.ciencia_da_operacao(nil)
	xml_evento_desconhecimento_da_operacao = NF::Mock::Generator.desconhecimento_da_operacao(nil)
	xml_evento_operacao_nao_realizada = NF::Mock::Generator.operacao_nao_realizada(nil)
	xml_evento_emissao_contingencia = NF::Mock::Generator.emissao_contingencia(nil)
	xml_evento_cancelamento_prazo_1 = NF::Mock::Generator.cancelamento_prazo_1(nil)
	xml_evento_cancelamento_prazo_2 = NF::Mock::Generator.cancelamento_prazo_2(nil)
	xml_consultar_retorno_autorizacao = NF::Mock::Generator.consultar_retorno_autorizacao(nil)
	xml_consultar_protocolo = NF::Mock::Generator.consultar_protocolo(nil)
	xml_nfe_distribuicao_dfe = NF::Mock::Generator.nfe_distribuicao_dfe(nil)
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
	status_consulta_servico = xml_consultar_status_servico.xpath("//xs:consStatServ//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
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
	versao_env_evento_prorrogar_prazo_1 = xml_evento_prorrogar_prazo_1.xpath("//xs:envEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
	tp_evento_prorrogar_prazo_1 = xml_evento_prorrogar_prazo_1.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:tpEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
	versao_det_evento_prorrogar_prazo_1 = xml_evento_prorrogar_prazo_1.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
	desc_evento_prorrogar_prazo_1 = xml_evento_prorrogar_prazo_1.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
	nprot_prorrogar_prazo_1 = xml_evento_prorrogar_prazo_1.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:nProt","xs" => "http://www.portalfiscal.inf.br/nfe")
	item_pedido_prorrogar_prazo_1 = xml_evento_prorrogar_prazo_1.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:itemPedido","xs" => "http://www.portalfiscal.inf.br/nfe")
	num_item_prorrogar_prazo_1 = xml_evento_prorrogar_prazo_1.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@numItem","xs" => "http://www.portalfiscal.inf.br/nfe").first
	qtde_item_prorrogar_prazo_1 = xml_evento_prorrogar_prazo_1.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:qtdeItem","xs" => "http://www.portalfiscal.inf.br/nfe").first
	versao_env_evento_prorrogar_prazo_2 = xml_evento_prorrogar_prazo_2.xpath("//xs:envEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
	tp_evento_prorrogar_prazo_2 = xml_evento_prorrogar_prazo_2.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:tpEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
	versao_det_evento_prorrogar_prazo_2 = xml_evento_prorrogar_prazo_2.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
	desc_evento_prorrogar_prazo_2 = xml_evento_prorrogar_prazo_2.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
	nprot_prorrogar_prazo_2 = xml_evento_prorrogar_prazo_2.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:nProt","xs" => "http://www.portalfiscal.inf.br/nfe")
	item_pedido_prorrogar_prazo_2 = xml_evento_prorrogar_prazo_2.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:itemPedido","xs" => "http://www.portalfiscal.inf.br/nfe")
	num_item_prorrogar_prazo_2 = xml_evento_prorrogar_prazo_2.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@numItem","xs" => "http://www.portalfiscal.inf.br/nfe").first
	qtde_item_prorrogar_prazo_2 = xml_evento_prorrogar_prazo_2.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:qtdeItem","xs" => "http://www.portalfiscal.inf.br/nfe").first
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
	versao_env_evento_cancelar_prazo_1 = xml_evento_cancelamento_prazo_1.xpath("//xs:envEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
	tp_evento_cancelar_prazo_1 = xml_evento_cancelamento_prazo_1.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:tpEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
	versao_det_evento_cancelar_prazo_1 = xml_evento_cancelamento_prazo_1.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
	desc_evento_cancelar_prazo_1 = xml_evento_cancelamento_prazo_1.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
	nprot_cancelar_prazo_1 = xml_evento_cancelamento_prazo_1.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:nProt","xs" => "http://www.portalfiscal.inf.br/nfe")
	item_pedido_cancelar_prazo_1 = xml_evento_cancelamento_prazo_1.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:itemPedido","xs" => "http://www.portalfiscal.inf.br/nfe")
	num_item_cancelar_prazo_1 = xml_evento_cancelamento_prazo_1.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@numItem","xs" => "http://www.portalfiscal.inf.br/nfe").first
	qtde_item_cancelar_prazo_1 = xml_evento_cancelamento_prazo_1.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:qtdeItem","xs" => "http://www.portalfiscal.inf.br/nfe").first	
	versao_env_evento_cancelar_prazo_2 = xml_evento_cancelamento_prazo_2.xpath("//xs:envEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
	tp_evento_cancelar_prazo_2 = xml_evento_cancelamento_prazo_2.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:tpEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
	versao_det_evento_cancelar_prazo_2 = xml_evento_cancelamento_prazo_2.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
	desc_evento_cancelar_prazo_2 = xml_evento_cancelamento_prazo_2.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
	nprot_cancelar_prazo_2 = xml_evento_cancelamento_prazo_2.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:nProt","xs" => "http://www.portalfiscal.inf.br/nfe")
	item_pedido_cancelar_prazo_2 = xml_evento_cancelamento_prazo_2.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:itemPedido","xs" => "http://www.portalfiscal.inf.br/nfe")
	num_item_cancelar_prazo_2 = xml_evento_cancelamento_prazo_2.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@numItem","xs" => "http://www.portalfiscal.inf.br/nfe").first
	qtde_item_cancelar_prazo_2 = xml_evento_cancelamento_prazo_2.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:qtdeItem","xs" => "http://www.portalfiscal.inf.br/nfe").first	
	versao_cons_reci_nfe_consultar_retorno_autorizacao = xml_consultar_retorno_autorizacao.xpath("//xs:consReciNFe//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
	versao_cons_sit_nfe_consulta_protocolo = xml_consultar_protocolo.xpath("//xs:consSitNFe//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
	versao_dist_dfe_int_nfe_distribuicao_dfe = xml_nfe_distribuicao_dfe.xpath("//xs:distDFeInt//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
	csts_operacao_isenta = ["40","41"]
	csosns_operacao_isenta = ["103","300","400"]
	puts xml_autorizacao
	puts xml_inutilizacao
	puts xml_evento_carta_correcao
	puts xml_evento_cancelar_nota
	puts xml_consultar_status_servico
	puts xml_evento_cancelar_nota_substituicao
	puts xml_evento_prorrogar_prazo_1
	puts xml_evento_prorrogar_prazo_2
	puts xml_evento_ator_interessado
	puts xml_evento_confirmacao_da_operacao
	puts xml_evento_ciencia_da_operacao
	puts xml_evento_desconhecimento_da_operacao
	puts xml_evento_emissao_contingencia
	puts xml_evento_cancelamento_prazo_1
	puts xml_evento_cancelamento_prazo_2
	puts xml_consultar_retorno_autorizacao
	puts xml_consultar_protocolo
	puts xml_nfe_distribuicao_dfe

	it "deve criar um xml válido para mensagem de autorizacao de notas" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_autorizacao))
		puts "--- AUTORIZACAO --- \n\n#{schema.validate(xml_autorizacao)}"
		expect(schema.valid?(xml_autorizacao)).to be(true)
	end

	it "deve criar um xml válido para mensagem de inutilizacao de notas" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_inutilizacao))
		puts "--- INUTILIZACAO --- \n\n#{schema.validate(xml_inutilizacao)}"
		expect(schema.valid?(xml_inutilizacao)).to be(true)
	end

	it "deve criar um xml válido para mensagem de evento de carta de correção" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_carta_correcao))
		puts "--- CARTA CORRECAO --- \n\n#{schema.validate(xml_evento_carta_correcao)}"
		expect(schema.valid?(xml_evento_carta_correcao)).to be(true)
	end

	it "deve criar um xml válido para mensagem de cancelamento de nota" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_cancelar_nota))
		puts "--- CANCELAR NOTA --- \n\n#{schema.validate(xml_evento_cancelar_nota)}"
		expect(schema.valid?(xml_evento_cancelar_nota)).to be(true)
	end

	it "deve criar um xml válido para mensagem de consulta de status" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_consultar_status_servico))
		puts "--- CONSULTAR STATUS SERVICO --- \n\n#{schema.validate(xml_consultar_status_servico)}"
		expect(schema.valid?(xml_consultar_status_servico)).to be(true)
	end

	it "deve criar um xml válido para mensagem de cancelamento de nota substituicao" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_cancelar_nota_substituicao))
		puts "--- CANCELAR NOTA SUBSTITUICAO --- \n\n#{schema.validate(xml_evento_cancelar_nota_substituicao)}"
		expect(schema.valid?(xml_evento_cancelar_nota_substituicao)).to be(true)
	end

	it "deve criar um xml válido para mensagem de prorrogamento de prazo 1" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_prorrogar_prazo_1))
		puts "--- PRORROGAR PRAZO 1 --- \n\n#{schema.validate(xml_evento_prorrogar_prazo_1)}"
		expect(schema.valid?(xml_evento_prorrogar_prazo_1)).to be(true)
	end

	it "deve criar um xml válido para mensagem de prorrogamento de prazo 2" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_prorrogar_prazo_2))
		puts "--- PRORROGAR PRAZO 2 --- \n\n#{schema.validate(xml_evento_prorrogar_prazo_2)}"
		expect(schema.valid?(xml_evento_prorrogar_prazo_2)).to be(true)
	end

	it "deve criar um xml válido para mensagem de ator interessado" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_ator_interessado))
		puts "--- ATOR INTERESSADO --- \n\n#{schema.validate(xml_evento_ator_interessado)}"
		expect(schema.valid?(xml_evento_ator_interessado)).to be(true)
	end

	it "deve criar um xml válido para mensagem de confirmacao da operacao" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_confirmacao_da_operacao))
		puts "--- CONFIRMACAO DA OPERACAO --- \n\n#{schema.validate(xml_evento_confirmacao_da_operacao)}"
		expect(schema.valid?(xml_evento_confirmacao_da_operacao)).to be(true)
	end

	it "deve criar um xml válido para mensagem de ciencia da operacao" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_ciencia_da_operacao))
		puts "--- CIENCIA DA OPERACAO --- \n\n#{schema.validate(xml_evento_ciencia_da_operacao)}"
		expect(schema.valid?(xml_evento_ciencia_da_operacao)).to be(true)
	end

	it "deve criar um xml válido para mensagem de desconhecimento da operacao" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_desconhecimento_da_operacao))
		puts "--- DESCONHECIMENTO DA OPERACAO --- \n\n#{schema.validate(xml_evento_desconhecimento_da_operacao)}"
		expect(schema.valid?(xml_evento_desconhecimento_da_operacao)).to be(true)
	end

	it "deve criar um xml válido para mensagem de operacao não realizada" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_operacao_nao_realizada))
		puts "--- OPERACAO NAO REALIZADA --- \n\n#{schema.validate(xml_evento_operacao_nao_realizada)}"
		expect(schema.valid?(xml_evento_operacao_nao_realizada)).to be(true)
	end

	it "deve criar um xml válido para mensagem de emissao em contingencia" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_emissao_contingencia))
		puts "--- EMISSAO EM CONTINGENCIA --- \n\n#{schema.validate(xml_evento_emissao_contingencia)}"
		expect(schema.valid?(xml_evento_emissao_contingencia)).to be(true)
	end

	it "deve criar um xml válido para mensagem de consulta de retorno de autorização" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_consultar_retorno_autorizacao))
		puts "--- CONSULTAR RETORNO AUTORIZACAO --- \n\n#{schema.validate(xml_consultar_retorno_autorizacao)}"
		expect(schema.valid?(xml_consultar_retorno_autorizacao)).to be(true)
	end

	it "deve criar um xml válido para mensagem de consultar protocolo" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_consultar_protocolo))
		puts "--- CONSULTAR PROTOCOLO --- \n\n#{schema.validate(xml_consultar_protocolo)}"
		expect(schema.valid?(xml_consultar_protocolo)).to be(true)
	end

	it "deve criar um xml válido para mensagem de distribuicao dfe" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_nfe_distribuicao_dfe))
		puts "--- DISTRIBUICAO DFE --- \n\n#{schema.validate(xml_nfe_distribuicao_dfe)}"
		expect(schema.valid?(xml_nfe_distribuicao_dfe)).to be(true)
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

	it "deve conter valor '210220' em tag tpEvento em operacao nao realizada" do |test|
		condicao = tp_evento_operacao_nao_realizada.content == '210220'
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

	it "deve conter valor 'Desconhecimento da Operacao' em tag descEvento em operacao nao realizada" do |test|
		condicao = desc_evento_operacao_nao_realizada.first.content == 'Desconhecimento da Operacao'
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