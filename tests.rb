require 'simplecov'
SimpleCov.start

require './lib/brnf.rb'
require 'nokogiri'
require 'pry'
require 'openssl'

RSpec.describe "Random XML Generator (producao)" do

	schema_autorizacao = './schemas/enviNFe_v4.00.xsd'
	schema_inutilizacao = './schemas/inutNFe_v4.00.xsd'
	schema_evento_carta_correcao = './schemas/envCCe_v1.00.xsd'
	schema_evento_cancelar_nota = './schemas/envEventoCancNFe_v1.00.xsd'
	schema_consultar_status_servico = './schemas/consStatServ_v4.00.xsd'
	schema_evento_cancelar_nota_substituicao = './schemas/envEventoCancSubst_v1.00.xsd'
	schema_evento_prorrogar_prazo_1 = './schemas/envRemIndus_v1.00.xsd'
	schema_evento_prorrogar_prazo_2 = './schemas/envRemIndus_v1.00.xsd'
	schema_evento_ator_interessado = './schemas/envEventoAtorInteressado_v1.00.xsd'
	schema_evento_confirmacao_da_operacao = './schemas/envConfRecebto_v1.00.xsd'
	schema_evento_ciencia_da_operacao = './schemas/envConfRecebto_v1.00.xsd'
	schema_evento_desconhecimento_da_operacao = './schemas/envConfRecebto_v1.00.xsd'
	schema_evento_operacao_nao_realizada = './schemas/envConfRecebto_v1.00.xsd'
	schema_evento_emissao_contingencia = './schemas/envEPEC_v1.00.xsd'
	schema_evento_cancelamento_prazo_1 = './schemas/envRemIndus_v1.00.xsd'
	schema_evento_cancelamento_prazo_2 = './schemas/envRemIndus_v1.00.xsd'
	schema_consultar_retorno_autorizacao = './schemas/consReciNFe_v4.00.xsd'
	schema_consultar_protocolo = './schemas/consSitNFe_v4.00.xsd'
	schema_nfe_distribuicao_dfe = './schemas/distDFeInt_v1.01.xsd'
	schema_consultar_cadastro = './schemas/consCad_v2.00.xsd'
	
	generator = BRNF::XML.new
	signer = BRNF::Signer.new
	
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

	xml_autorizacao = signer.sign_message(xml_autorizacao)
	xml_inutilizacao = signer.sign_message(xml_inutilizacao)
	xml_evento_carta_correcao = signer.sign_message(xml_evento_carta_correcao)
	xml_evento_cancelar_nota = signer.sign_message(xml_evento_cancelar_nota)
	xml_evento_cancelar_nota_substituicao = signer.sign_message(xml_evento_cancelar_nota_substituicao)
	xml_evento_prorrogar_prazo_1 = signer.sign_message(xml_evento_prorrogar_prazo_1)
	xml_evento_prorrogar_prazo_2 = signer.sign_message(xml_evento_prorrogar_prazo_2)
	xml_evento_ator_interessado = signer.sign_message(xml_evento_ator_interessado)
	xml_evento_confirmacao_da_operacao = signer.sign_message(xml_evento_confirmacao_da_operacao)
	xml_evento_ciencia_da_operacao = signer.sign_message(xml_evento_ciencia_da_operacao)
	xml_evento_desconhecimento_da_operacao = signer.sign_message(xml_evento_desconhecimento_da_operacao)
	xml_evento_operacao_nao_realizada = signer.sign_message(xml_evento_operacao_nao_realizada)
	xml_evento_emissao_contingencia = signer.sign_message(xml_evento_emissao_contingencia)
	xml_evento_cancelamento_prazo_1 = signer.sign_message(xml_evento_cancelamento_prazo_1)
	xml_evento_cancelamento_prazo_2 = signer.sign_message(xml_evento_cancelamento_prazo_2)

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

	it "deve criar um xml válido para mensagem de cancelamento de prazo 1" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_cancelamento_prazo_1))
		puts schema.validate(xml_evento_cancelamento_prazo_1) if !schema.valid?(xml_evento_cancelamento_prazo_1)
		expect(schema.valid?(xml_evento_cancelamento_prazo_1)).to be(true)
	end

	it "deve criar um xml válido para mensagem de cancelamento de prazo 2" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_cancelamento_prazo_2))
		puts schema.validate(xml_evento_cancelamento_prazo_2) if !schema.valid?(xml_evento_cancelamento_prazo_2)
		expect(schema.valid?(xml_evento_cancelamento_prazo_2)).to be(true)
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
end

RSpec.describe "XML Parser (producao)" do
	schema_autorizacao = './schemas/enviNFe_v4.00.xsd'
	schema_inutilizacao = './schemas/inutNFe_v4.00.xsd'
	schema_evento_carta_correcao = './schemas/envCCe_v1.00.xsd'
	schema_evento_cancelar_nota = './schemas/envEventoCancNFe_v1.00.xsd'
	schema_consultar_status_servico = './schemas/consStatServ_v4.00.xsd'
	schema_evento_cancelar_nota_substituicao = './schemas/envEventoCancSubst_v1.00.xsd'
	schema_evento_prorrogar_prazo_1 = './schemas/envRemIndus_v1.00.xsd'
	schema_evento_prorrogar_prazo_2 = './schemas/envRemIndus_v1.00.xsd'
	schema_evento_ator_interessado = './schemas/envEventoAtorInteressado_v1.00.xsd'
	schema_evento_confirmacao_da_operacao = './schemas/envConfRecebto_v1.00.xsd'
	schema_evento_ciencia_da_operacao = './schemas/envConfRecebto_v1.00.xsd'
	schema_evento_desconhecimento_da_operacao = './schemas/envConfRecebto_v1.00.xsd'
	schema_evento_operacao_nao_realizada = './schemas/envConfRecebto_v1.00.xsd'
	schema_evento_emissao_contingencia = './schemas/envEPEC_v1.00.xsd'
	schema_evento_cancelamento_prazo_1 = './schemas/envRemIndus_v1.00.xsd'
	schema_evento_cancelamento_prazo_2 = './schemas/envRemIndus_v1.00.xsd'
	schema_consultar_retorno_autorizacao = './schemas/consReciNFe_v4.00.xsd'
	schema_consultar_protocolo = './schemas/consSitNFe_v4.00.xsd'
	schema_nfe_distribuicao_dfe = './schemas/distDFeInt_v1.01.xsd'
	schema_consultar_cadastro = './schemas/consCad_v2.00.xsd'
	
	message_autorizar_nota = JSON.parse(File.open("./messages/examples/message_autorizar_nota.json","r").read)
	message_inutilizar_numeracao = JSON.parse(File.open("./messages/examples/message_inutilizar_numeracao.json","r").read)
	message_criar_carta_correcao = JSON.parse(File.open("./messages/examples/eventos/message_criar_carta_correcao.json","r").read)
	message_cancelar_nota = JSON.parse(File.open("./messages/examples/eventos/message_cancelar_nota.json","r").read)
	message_consultar_status_servico = JSON.parse(File.open("./messages/examples/message_consulta_status_servico.json","r").read)
	message_cancelar_nota_substituicao = JSON.parse(File.open("./messages/examples/eventos/message_cancelar_nota_substituicao.json","r").read)
	message_prorrogar_prazo_1 = JSON.parse(File.open("./messages/examples/eventos/message_prorrogar_prazo_1.json","r").read)
	message_prorrogar_prazo_2 = JSON.parse(File.open("./messages/examples/eventos/message_prorrogar_prazo_2.json","r").read)
	message_ator_interessado = JSON.parse(File.open("./messages/examples/eventos/message_ator_interessado.json","r").read)
	message_confirmacao_da_operacao = JSON.parse(File.open("./messages/examples/eventos/message_confirmacao_da_operacao.json","r").read)
	message_ciencia_da_operacao = JSON.parse(File.open("./messages/examples/eventos/message_ciencia_da_operacao.json","r").read)
	message_desconhecimento_da_operacao = JSON.parse(File.open("./messages/examples/eventos/message_desconhecimento_da_operacao.json","r").read)
	message_operacao_nao_realizada = JSON.parse(File.open("./messages/examples/eventos/message_operacao_nao_realizada.json","r").read)
	message_emissao_contingencia = JSON.parse(File.open("./messages/examples/eventos/message_emissao_contingencia.json","r").read)
	message_cancelamento_prazo_1 = JSON.parse(File.open("./messages/examples/eventos/message_cancelamento_prazo_1.json","r").read)
	message_cancelamento_prazo_2 = JSON.parse(File.open("./messages/examples/eventos/message_cancelamento_prazo_2.json","r").read)
	message_consultar_retorno_autorizacao = JSON.parse(File.open("./messages/examples/message_consultar_retorno_autorizacao.json","r").read)
	message_consultar_protocolo = JSON.parse(File.open("./messages/examples/message_consultar_protocolo.json","r").read)
	message_nfe_distribuicao_dfe = JSON.parse(File.open("./messages/examples/message_nfe_distribuicao_dfe.json","r").read)
	message_consultar_cadastro = JSON.parse(File.open("./messages/examples/message_consultar_cadastro.json","r").read)

	message_consulta_status_servico_sem_ambiente = JSON.parse(File.open("messages/failures/message_consulta_status_servico_sem_ambiente.json","r").read)
	message_consulta_status_servico_sem_codigo_uf = JSON.parse(File.open("messages/failures/message_consulta_status_servico_sem_codigo_uf.json","r").read)
	message_consultar_cadastro_sem_cpf_cnpj = JSON.parse(File.open("messages/failures/message_consultar_cadastro_sem_cpf_cnpj.json","r").read)
	message_consultar_cadastro_sem_uf = JSON.parse(File.open("messages/failures/message_consultar_cadastro_sem_uf.json","r").read)
	message_consultar_protocolo_sem_ambiente = JSON.parse(File.open("messages/failures/message_consultar_protocolo_sem_ambiente.json","r").read)
	message_consultar_protocolo_sem_chave_nota = JSON.parse(File.open("messages/failures/message_consultar_protocolo_sem_chave_nota.json","r").read)
	message_consultar_retorno_autorizacao_sem_ambiente = JSON.parse(File.open("messages/failures/message_consultar_retorno_autorizacao_sem_ambiente.json","r").read)
	message_consultar_retorno_autorizacao_sem_recibo = JSON.parse(File.open("messages/failures/message_consultar_retorno_autorizacao_sem_recibo.json","r").read)
	message_inutilizar_numeracao_sem_ambiente = JSON.parse(File.open("messages/failures/message_inutilizar_numeracao_sem_ambiente.json","r").read)
	message_inutilizar_numeracao_sem_ano = JSON.parse(File.open("messages/failures/message_inutilizar_numeracao_sem_ano.json","r").read)
	message_inutilizar_numeracao_sem_cnpj = JSON.parse(File.open("messages/failures/message_inutilizar_numeracao_sem_cnpj.json","r").read)
	message_inutilizar_numeracao_sem_codigo_uf = JSON.parse(File.open("messages/failures/message_inutilizar_numeracao_sem_codigo_uf.json","r").read)
	message_inutilizar_numeracao_sem_justificativa = JSON.parse(File.open("messages/failures/message_inutilizar_numeracao_sem_justificativa.json","r").read)
	message_inutilizar_numeracao_sem_modelo = JSON.parse(File.open("messages/failures/message_inutilizar_numeracao_sem_modelo.json","r").read)
	message_inutilizar_numeracao_sem_numero_final = JSON.parse(File.open("messages/failures/message_inutilizar_numeracao_sem_numero_final.json","r").read)
	message_inutilizar_numeracao_sem_numero_inicial = JSON.parse(File.open("messages/failures/message_inutilizar_numeracao_sem_numero_inicial.json","r").read)
	message_inutilizar_numeracao_sem_serie = JSON.parse(File.open("messages/failures/message_inutilizar_numeracao_sem_serie.json","r").read)
	message_nfe_distribuicao_dfe_com_chave_nota_e_nsu = JSON.parse(File.open("messages/failures/message_nfe_distribuicao_dfe_com_chave_nota_e_nsu.json","r").read)
	message_nfe_distribuicao_dfe_com_chave_nota_e_ultimo_nsu = JSON.parse(File.open("messages/failures/message_nfe_distribuicao_dfe_com_chave_nota_e_ultimo_nsu.json","r").read)
	message_nfe_distribuicao_dfe_com_nsu_e_ultimo_nsu = JSON.parse(File.open("messages/failures/message_nfe_distribuicao_dfe_com_nsu_e_ultimo_nsu.json","r").read)
	message_nfe_distribuicao_dfe_sem_ambiente = JSON.parse(File.open("messages/failures/message_nfe_distribuicao_dfe_sem_ambiente.json","r").read)
	message_nfe_distribuicao_dfe_sem_chave_nota = JSON.parse(File.open("messages/failures/message_nfe_distribuicao_dfe_sem_chave_nota.json","r").read)
	message_nfe_distribuicao_dfe_sem_cpf_cnpj = JSON.parse(File.open("messages/failures/message_nfe_distribuicao_dfe_sem_cpf_cnpj.json","r").read)
	message_ator_interessado_sem_ambiente = JSON.parse(File.open("messages/failures/eventos/message_ator_interessado_sem_ambiente.json","r").read)
	message_ator_interessado_sem_chave_nota = JSON.parse(File.open("messages/failures/eventos/message_ator_interessado_sem_chave_nota.json","r").read)
	message_ator_interessado_sem_codigo_orgao_autor = JSON.parse(File.open("messages/failures/eventos/message_ator_interessado_sem_codigo_orgao_autor.json","r").read)
	message_ator_interessado_sem_codigo_uf = JSON.parse(File.open("messages/failures/eventos/message_ator_interessado_sem_codigo_uf.json","r").read)
	message_ator_interessado_sem_cpf_cnpj = JSON.parse(File.open("messages/failures/eventos/message_ator_interessado_sem_cpf_cnpj.json","r").read)
	message_ator_interessado_sem_detalhes = JSON.parse(File.open("messages/failures/eventos/message_ator_interessado_sem_detalhes.json","r").read)
	message_ator_interessado_sem_detalhes_cpf_cnpj = JSON.parse(File.open("messages/failures/eventos/message_ator_interessado_sem_detalhes_cpf_cnpj.json","r").read)
	message_ator_interessado_sem_sequencia = JSON.parse(File.open("messages/failures/eventos/message_ator_interessado_sem_sequencia.json","r").read)
	message_ator_interessado_sem_tipo_autor = JSON.parse(File.open("messages/failures/eventos/message_ator_interessado_sem_tipo_autor.json","r").read)
	message_ator_interessado_sem_versao_aplicacao = JSON.parse(File.open("messages/failures/eventos/message_ator_interessado_sem_versao_aplicacao.json","r").read)
	message_ator_interessado_sem_lote = JSON.parse(File.open("messages/failures/eventos/message_ator_interessado_sem_lote.json","r").read)
	message_cancelar_nota_sem_justificativa = JSON.parse(File.open("messages/failures/eventos/message_cancelar_nota_sem_justificativa.json","r").read)
	message_cancelar_nota_sem_protocolo = JSON.parse(File.open("messages/failures/eventos/message_cancelar_nota_sem_protocolo.json","r").read)
	message_cancelar_nota_substituicao_sem_chave_nota_substituta = JSON.parse(File.open("messages/failures/eventos/message_cancelar_nota_substituicao_sem_chave_nota_substituta.json","r").read)
	message_cancelar_nota_substituicao_sem_codigo_orgao_autor = JSON.parse(File.open("messages/failures/eventos/message_cancelar_nota_substituicao_sem_codigo_orgao_autor.json","r").read)
	message_cancelar_nota_substituicao_sem_protocolo = JSON.parse(File.open("messages/failures/eventos/message_cancelar_nota_substituicao_sem_protocolo.json","r").read)
	message_cancelar_nota_substituicao_sem_tipo_autor = JSON.parse(File.open("messages/failures/eventos/message_cancelar_nota_substituicao_sem_tipo_autor.json","r").read)
	message_cancelar_nota_substituicao_sem_versao_aplicacao = JSON.parse(File.open("messages/failures/eventos/message_cancelar_nota_substituicao_sem_versao_aplicacao.json","r").read)
	message_cancelar_nota_substituicao_sem_justificativa = JSON.parse(File.open("messages/failures/eventos/message_cancelar_nota_substituicao_sem_justificativa.json","r").read)
	message_criar_carta_correcao_sem_correcao = JSON.parse(File.open("messages/failures/eventos/message_criar_carta_correcao_sem_correcao.json","r").read)
	message_emissao_contingencia_com_cpf_cnpj_e_id_estrangeiro = JSON.parse(File.open("messages/failures/eventos/message_emissao_contingencia_com_cpf_cnpj_e_id_estrangeiro.json","r").read)
	message_emissao_contingencia_sem_codigo_orgao_autor = JSON.parse(File.open("messages/failures/eventos/message_emissao_contingencia_sem_codigo_orgao_autor.json","r").read)
	message_emissao_contingencia_sem_cpf_cnpj = JSON.parse(File.open("messages/failures/eventos/message_emissao_contingencia_sem_cpf_cnpj.json","r").read)
	message_emissao_contingencia_sem_destinatario = JSON.parse(File.open("messages/failures/eventos/message_emissao_contingencia_sem_destinatario.json","r").read)
	message_emissao_contingencia_sem_tipo_autor = JSON.parse(File.open("messages/failures/eventos/message_emissao_contingencia_sem_tipo_autor.json","r").read)
	message_emissao_contingencia_sem_tipo_operacao = JSON.parse(File.open("messages/failures/eventos/message_emissao_contingencia_sem_tipo_operacao.json","r").read)
	message_emissao_contingencia_sem_uf = JSON.parse(File.open("messages/failures/eventos/message_emissao_contingencia_sem_uf.json","r").read)
	message_emissao_contingencia_sem_valor_icms = JSON.parse(File.open("messages/failures/eventos/message_emissao_contingencia_sem_valor_icms.json","r").read)
	message_emissao_contingencia_sem_valor_icms_st = JSON.parse(File.open("messages/failures/eventos/message_emissao_contingencia_sem_valor_icms_st.json","r").read)
	message_emissao_contingencia_sem_valor_nota = JSON.parse(File.open("messages/failures/eventos/message_emissao_contingencia_sem_valor_nota.json","r").read)
	message_emissao_contingencia_sem_versao_aplicacao = JSON.parse(File.open("messages/failures/eventos/message_emissao_contingencia_sem_versao_aplicacao.json","r").read)

	generator = BRNF::XML.new

	xml_autorizacao = generator.autorizar_nota(message: message_autorizar_nota)
	xml_inutilizacao = generator.inutilizar_numeracao(message: message_inutilizar_numeracao)
	xml_evento_carta_correcao = generator.criar_carta_correcao(message: message_criar_carta_correcao)
	xml_evento_cancelar_nota = generator.cancelar_nota(message: message_cancelar_nota)
	xml_consultar_status_servico = generator.consultar_status_servico(message: message_consultar_status_servico)
	xml_evento_cancelar_nota_substituicao = generator.cancelar_nota_substituicao(message: message_cancelar_nota_substituicao)
	xml_evento_prorrogar_prazo_1 = generator.prorrogar_prazo_1(message: message_prorrogar_prazo_1)
	xml_evento_prorrogar_prazo_2 = generator.prorrogar_prazo_2(message: message_prorrogar_prazo_2)
	xml_evento_ator_interessado = generator.ator_interessado(message: message_ator_interessado)
	xml_evento_confirmacao_da_operacao = generator.confirmacao_da_operacao(message: message_confirmacao_da_operacao)
	xml_evento_ciencia_da_operacao = generator.ciencia_da_operacao(message: message_ciencia_da_operacao)
	xml_evento_desconhecimento_da_operacao = generator.desconhecimento_da_operacao(message: message_desconhecimento_da_operacao)
	xml_evento_operacao_nao_realizada = generator.operacao_nao_realizada(message: message_operacao_nao_realizada)
	xml_evento_emissao_contingencia = generator.emissao_contingencia(message: message_emissao_contingencia)
	xml_evento_cancelamento_prazo_1 = generator.cancelamento_prazo_1(message: message_cancelamento_prazo_1)
	xml_evento_cancelamento_prazo_2 = generator.cancelamento_prazo_2(message: message_cancelamento_prazo_2)
	xml_consultar_retorno_autorizacao = generator.consultar_retorno_autorizacao(message: message_consultar_retorno_autorizacao)
	xml_consultar_protocolo = generator.consultar_protocolo(message: message_consultar_protocolo)
	xml_nfe_distribuicao_dfe = generator.nfe_distribuicao_dfe(message: message_nfe_distribuicao_dfe)
	xml_consultar_cadastro = generator.consultar_cadastro(message: message_consultar_cadastro)

	xml_consulta_status_servico_sem_ambiente = generator.consultar_status_servico(message: message_consulta_status_servico_sem_ambiente)
	xml_consulta_status_servico_sem_codigo_uf = generator.consultar_status_servico(message: message_consulta_status_servico_sem_codigo_uf)
	xml_consultar_cadastro_sem_cpf_cnpj = generator.consultar_cadastro(message: message_consultar_cadastro_sem_cpf_cnpj)
	xml_consultar_cadastro_sem_uf = generator.consultar_cadastro(message: message_consultar_cadastro_sem_uf)
	xml_consultar_protocolo_sem_ambiente = generator.consultar_protocolo(message: message_consultar_protocolo_sem_ambiente)
	xml_consultar_protocolo_sem_chave_nota = generator.consultar_protocolo(message: message_consultar_protocolo_sem_chave_nota)
	xml_consultar_retorno_autorizacao_sem_ambiente = generator.consultar_retorno_autorizacao(message: message_consultar_retorno_autorizacao_sem_ambiente)
	xml_consultar_retorno_autorizacao_sem_recibo = generator.consultar_retorno_autorizacao(message: message_consultar_retorno_autorizacao_sem_recibo)
	xml_inutilizar_numeracao_sem_ambiente = generator.inutilizar_numeracao(message: message_inutilizar_numeracao_sem_ambiente)
	xml_inutilizar_numeracao_sem_ano = generator.inutilizar_numeracao(message: message_inutilizar_numeracao_sem_ano)
	xml_inutilizar_numeracao_sem_cnpj = generator.inutilizar_numeracao(message: message_inutilizar_numeracao_sem_cnpj)
	xml_inutilizar_numeracao_sem_codigo_uf = generator.inutilizar_numeracao(message: message_inutilizar_numeracao_sem_codigo_uf)
	xml_inutilizar_numeracao_sem_justificativa = generator.inutilizar_numeracao(message: message_inutilizar_numeracao_sem_justificativa)
	xml_inutilizar_numeracao_sem_modelo = generator.inutilizar_numeracao(message: message_inutilizar_numeracao_sem_modelo)
	xml_inutilizar_numeracao_sem_numero_final = generator.inutilizar_numeracao(message: message_inutilizar_numeracao_sem_numero_final)
	xml_inutilizar_numeracao_sem_numero_inicial = generator.inutilizar_numeracao(message: message_inutilizar_numeracao_sem_numero_inicial)
	xml_inutilizar_numeracao_sem_serie = generator.inutilizar_numeracao(message: message_inutilizar_numeracao_sem_serie)
	xml_nfe_distribuicao_dfe_com_chave_nota_e_nsu = generator.nfe_distribuicao_dfe(message: message_nfe_distribuicao_dfe_com_chave_nota_e_nsu)
	xml_nfe_distribuicao_dfe_com_chave_nota_e_ultimo_nsu = generator.nfe_distribuicao_dfe(message: message_nfe_distribuicao_dfe_com_chave_nota_e_ultimo_nsu)
	xml_nfe_distribuicao_dfe_com_nsu_e_ultimo_nsu = generator.nfe_distribuicao_dfe(message: message_nfe_distribuicao_dfe_com_nsu_e_ultimo_nsu)
	xml_nfe_distribuicao_dfe_sem_ambiente = generator.nfe_distribuicao_dfe(message: message_nfe_distribuicao_dfe_sem_ambiente)
	xml_nfe_distribuicao_dfe_sem_chave_nota = generator.nfe_distribuicao_dfe(message: message_nfe_distribuicao_dfe_sem_chave_nota)
	xml_nfe_distribuicao_dfe_sem_cpf_cnpj = generator.nfe_distribuicao_dfe(message: message_nfe_distribuicao_dfe_sem_cpf_cnpj)
	xml_ator_interessado_sem_ambiente = generator.ator_interessado(message: message_ator_interessado_sem_ambiente)
	xml_ator_interessado_sem_chave_nota = generator.ator_interessado(message: message_ator_interessado_sem_chave_nota)
	xml_ator_interessado_sem_codigo_orgao_autor = generator.ator_interessado(message: message_ator_interessado_sem_codigo_orgao_autor)
	xml_ator_interessado_sem_codigo_uf = generator.ator_interessado(message: message_ator_interessado_sem_codigo_uf)
	xml_ator_interessado_sem_cpf_cnpj = generator.ator_interessado(message: message_ator_interessado_sem_cpf_cnpj)
	xml_ator_interessado_sem_detalhes = generator.ator_interessado(message: message_ator_interessado_sem_detalhes)
	xml_ator_interessado_sem_detalhes_cpf_cnpj = generator.ator_interessado(message: message_ator_interessado_sem_detalhes_cpf_cnpj)
	xml_ator_interessado_sem_sequencia = generator.ator_interessado(message: message_ator_interessado_sem_sequencia)
	xml_ator_interessado_sem_tipo_autor = generator.ator_interessado(message: message_ator_interessado_sem_tipo_autor)
	xml_ator_interessado_sem_versao_aplicacao = generator.ator_interessado(message: message_ator_interessado_sem_versao_aplicacao)
	xml_ator_interessado_sem_lote = generator.ator_interessado(message: message_ator_interessado_sem_lote)
	xml_cancelar_nota_sem_justificativa = generator.cancelar_nota(message: message_cancelar_nota_sem_justificativa)
	xml_cancelar_nota_sem_protocolo = generator.cancelar_nota(message: message_cancelar_nota_sem_protocolo)
	xml_cancelar_nota_substituicao_sem_chave_nota_substituta = generator.cancelar_nota_substituicao(message: message_cancelar_nota_substituicao_sem_chave_nota_substituta)
	xml_cancelar_nota_substituicao_sem_codigo_orgao_autor = generator.cancelar_nota_substituicao(message: message_cancelar_nota_substituicao_sem_codigo_orgao_autor)
	xml_cancelar_nota_substituicao_sem_justificativa = generator.cancelar_nota_substituicao(message: message_cancelar_nota_substituicao_sem_justificativa)
	xml_cancelar_nota_substituicao_sem_protocolo = generator.cancelar_nota_substituicao(message: message_cancelar_nota_substituicao_sem_protocolo)
	xml_cancelar_nota_substituicao_sem_tipo_autor = generator.cancelar_nota_substituicao(message: message_cancelar_nota_substituicao_sem_tipo_autor)
	xml_cancelar_nota_substituicao_sem_versao_aplicacao = generator.cancelar_nota_substituicao(message: message_cancelar_nota_substituicao_sem_versao_aplicacao)
	xml_criar_carta_correcao_sem_correcao = generator.criar_carta_correcao(message: message_criar_carta_correcao_sem_correcao)
	xml_emissao_contingencia_com_cpf_cnpj_e_id_estrangeiro = generator.emissao_contingencia(message: message_emissao_contingencia_com_cpf_cnpj_e_id_estrangeiro)
	xml_emissao_contingencia_sem_codigo_orgao_autor = generator.emissao_contingencia(message: message_emissao_contingencia_sem_codigo_orgao_autor)
	xml_emissao_contingencia_sem_cpf_cnpj = generator.emissao_contingencia(message: message_emissao_contingencia_sem_cpf_cnpj)
	xml_emissao_contingencia_sem_destinatario = generator.emissao_contingencia(message: message_emissao_contingencia_sem_destinatario)
	xml_emissao_contingencia_sem_tipo_autor = generator.emissao_contingencia(message: message_emissao_contingencia_sem_tipo_autor)
	xml_emissao_contingencia_sem_tipo_operacao = generator.emissao_contingencia(message: message_emissao_contingencia_sem_tipo_operacao)
	xml_emissao_contingencia_sem_uf = generator.emissao_contingencia(message: message_emissao_contingencia_sem_uf)
	xml_emissao_contingencia_sem_valor_icms = generator.emissao_contingencia(message: message_emissao_contingencia_sem_valor_icms)
	xml_emissao_contingencia_sem_valor_icms_st = generator.emissao_contingencia(message: message_emissao_contingencia_sem_valor_icms_st)
	xml_emissao_contingencia_sem_valor_nota = generator.emissao_contingencia(message: message_emissao_contingencia_sem_valor_nota)
	xml_emissao_contingencia_sem_versao_aplicacao = generator.emissao_contingencia(message: message_emissao_contingencia_sem_versao_aplicacao)

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

	it "deve criar um xml válido para mensagem de cancelamento de prazo 1" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_cancelamento_prazo_1))
		puts schema.validate(xml_evento_cancelamento_prazo_1) if !schema.valid?(xml_evento_cancelamento_prazo_1)
		expect(schema.valid?(xml_evento_cancelamento_prazo_1)).to be(true)
	end

	it "deve criar um xml válido para mensagem de cancelamento de prazo 2" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_cancelamento_prazo_2))
		puts schema.validate(xml_evento_cancelamento_prazo_2) if !schema.valid?(xml_evento_cancelamento_prazo_2)
		expect(schema.valid?(xml_evento_cancelamento_prazo_2)).to be(true)
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

	it "não deve criar um xml válido para mensagem de ator interessado sem ambiente" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_ator_interessado))
		expect(schema.valid?(xml_ator_interessado_sem_ambiente)).to be(false)
	end

	it "não deve criar um xml válido para mensagem de ator interessado sem chave_nota" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_ator_interessado))
		expect(schema.valid?(xml_ator_interessado_sem_chave_nota)).to be(false)
	end

	it "não deve criar um xml válido para mensagem de ator interessado sem codigo orgao_autor" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_ator_interessado))
		expect(schema.valid?(xml_ator_interessado_sem_codigo_orgao_autor)).to be(false)
	end

	it "não deve criar um xml válido para mensagem de ator interessado sem codigo_uf" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_ator_interessado))
		expect(schema.valid?(xml_ator_interessado_sem_codigo_uf)).to be(false)
	end

	it "não deve criar um xml válido para mensagem de ator interessado sem cpf_cnpj" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_ator_interessado))
		expect(schema.valid?(xml_ator_interessado_sem_cpf_cnpj)).to be(false)
	end

	it "não deve criar um xml válido para mensagem de ator interessado sem detalhes" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_ator_interessado))
		expect(schema.valid?(xml_ator_interessado_sem_detalhes)).to be(false)
	end

	it "não deve criar um xml válido para mensagem de ator interessado sem detalhes cpf_cnpj" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_ator_interessado))
		expect(schema.valid?(xml_ator_interessado_sem_detalhes_cpf_cnpj)).to be(false)
	end

	it "não deve criar um xml válido para mensagem de ator interessado sem sequencia" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_ator_interessado))
		expect(schema.valid?(xml_ator_interessado_sem_sequencia)).to be(false)
	end

	it "não deve criar um xml válido para mensagem de ator interessado sem tipo_autor" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_ator_interessado))
		expect(schema.valid?(xml_ator_interessado_sem_tipo_autor)).to be(false)
	end

	it "não deve criar um xml válido para mensagem de ator interessado sem versao_aplicacao" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_ator_interessado))
		expect(schema.valid?(xml_ator_interessado_sem_versao_aplicacao)).to be(false)
	end

	it "não deve criar um xml válido para mensagem de ator interessado sem lote" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_ator_interessado))
		expect(schema.valid?(xml_ator_interessado_sem_lote)).to be(false)
	end

	it "não deve criar um xml válido para mensagem de cancelar nota sem justificativa" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_cancelar_nota))
		expect(schema.valid?(xml_cancelar_nota_sem_justificativa)).to be(false)
	end

	it "não deve criar um xml válido para mensagem de cancelar nota sem protocolo" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_cancelar_nota))
		expect(schema.valid?(xml_cancelar_nota_sem_protocolo)).to be(false)
	end

	it "não deve criar um xml válido para mensagem de cancelar nota substituicao sem chave nota substituta" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_cancelar_nota_substituicao))
		expect(schema.valid?(xml_cancelar_nota_substituicao_sem_chave_nota_substituta)).to be(false)
	end

	it "não deve criar um xml válido para mensagem de cancelar nota substituicao sem codigo orgao autor" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_cancelar_nota_substituicao))
		expect(schema.valid?(xml_cancelar_nota_substituicao_sem_codigo_orgao_autor)).to be(false)
	end

	it "não deve criar um xml válido para mensagem de cancelar nota substituicao sem justificativa" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_cancelar_nota_substituicao))
		expect(schema.valid?(xml_cancelar_nota_substituicao_sem_justificativa)).to be(false)
	end

	it "não deve criar um xml válido para mensagem de cancelar nota substituicao sem protocolo" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_cancelar_nota_substituicao))
		expect(schema.valid?(xml_cancelar_nota_substituicao_sem_protocolo)).to be(false)
	end

	it "não deve criar um xml válido para mensagem de cancelar nota substituicao sem tipo autor" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_cancelar_nota_substituicao))
		expect(schema.valid?(xml_cancelar_nota_substituicao_sem_tipo_autor)).to be(false)
	end

	it "não deve criar um xml válido para mensagem de cancelar nota substituicao sem versao aplicacao" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_cancelar_nota_substituicao))
		expect(schema.valid?(xml_cancelar_nota_substituicao_sem_versao_aplicacao)).to be(false)
	end

	it "não deve criar um xml válido para mensagem de criar carta correcao sem correcao" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_carta_correcao))
		expect(schema.valid?(xml_criar_carta_correcao_sem_correcao)).to be(false)
	end

	it "não deve criar um xml válido para mensagem de emissao contingencia com cpf cnpj e id estrangeiro" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_emissao_contingencia))
		expect(schema.valid?(xml_emissao_contingencia_com_cpf_cnpj_e_id_estrangeiro)).to be(false)
	end

	it "não deve criar um xml válido para mensagem de emissao contingencia sem codigo orgao autor" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_emissao_contingencia))
		expect(schema.valid?(xml_emissao_contingencia_sem_codigo_orgao_autor)).to be(false)
	end

	it "não deve criar um xml válido para mensagem de emissao contingencia sem cpf cnpj" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_emissao_contingencia))
		expect(schema.valid?(xml_emissao_contingencia_sem_cpf_cnpj)).to be(false)
	end

	it "não deve criar um xml válido para mensagem de emissao contingencia sem destinatario" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_emissao_contingencia))
		expect(schema.valid?(xml_emissao_contingencia_sem_destinatario)).to be(false)
	end

	it "não deve criar um xml válido para mensagem de emissao contingencia sem tipo autor" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_emissao_contingencia))
		expect(schema.valid?(xml_emissao_contingencia_sem_tipo_autor)).to be(false)
	end

	it "não deve criar um xml válido para mensagem de emissao contingencia sem tipo operacao" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_emissao_contingencia))
		expect(schema.valid?(xml_emissao_contingencia_sem_tipo_operacao)).to be(false)
	end

	it "não deve criar um xml válido para mensagem de emissao contingencia sem uf" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_emissao_contingencia))
		expect(schema.valid?(xml_emissao_contingencia_sem_uf)).to be(false)
	end

	it "não deve criar um xml válido para mensagem de emissao contingencia sem valor icms" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_emissao_contingencia))
		expect(schema.valid?(xml_emissao_contingencia_sem_valor_icms)).to be(false)
	end

	it "não deve criar um xml válido para mensagem de emissao contingencia sem valor icms st" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_emissao_contingencia))
		expect(schema.valid?(xml_emissao_contingencia_sem_valor_icms_st)).to be(false)
	end

	it "não deve criar um xml válido para mensagem de emissao contingencia sem valor nota" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_emissao_contingencia))
		expect(schema.valid?(xml_emissao_contingencia_sem_valor_nota)).to be(false)
	end

	it "não deve criar um xml válido para mensagem de emissao contingencia sem versao aplicacao" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_evento_emissao_contingencia))
		expect(schema.valid?(xml_emissao_contingencia_sem_versao_aplicacao)).to be(false)
	end

	it "não deve criar um xml válido para mensagem de consulta status servico sem ambiente" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_consultar_status_servico))
		expect(schema.valid?(xml_consulta_status_servico_sem_ambiente)).to be(false)
	end

	it "não deve criar um xml válido para mensagem de consulta status servico sem codigo uf" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_consultar_status_servico))
		expect(schema.valid?(xml_consulta_status_servico_sem_codigo_uf)).to be(false)
	end

	it "não deve criar um xml válido para mensagem de consultar cadastro sem cpf cnpj" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_consultar_cadastro))
		expect(schema.valid?(xml_consultar_cadastro_sem_cpf_cnpj)).to be(false)
	end

	it "não deve criar um xml válido para mensagem de consultar cadastro sem uf" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_consultar_cadastro))
		expect(schema.valid?(xml_consultar_cadastro_sem_uf)).to be(false)
	end

	it "não deve criar um xml válido para mensagem de consultar protocolo sem ambiente" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_consultar_protocolo))
		expect(schema.valid?(xml_consultar_protocolo_sem_ambiente)).to be(false)
	end

	it "não deve criar um xml válido para mensagem de consultar protocolo sem chave nota" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_consultar_protocolo))
		expect(schema.valid?(xml_consultar_protocolo_sem_chave_nota)).to be(false)
	end

	it "não deve criar um xml válido para mensagem de consultar retorno autorizacao sem ambiente" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_consultar_retorno_autorizacao))
		expect(schema.valid?(xml_consultar_retorno_autorizacao_sem_ambiente)).to be(false)
	end

	it "não deve criar um xml válido para mensagem de consultar retorno autorizacao sem recibo" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_consultar_retorno_autorizacao))
		expect(schema.valid?(xml_consultar_retorno_autorizacao_sem_recibo)).to be(false)
	end

	it "não deve criar um xml válido para mensagem de inutilizar numeracao sem ambiente" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_inutilizacao))
		expect(schema.valid?(xml_inutilizar_numeracao_sem_ambiente)).to be(false)
	end

	it "não deve criar um xml válido para mensagem de inutilizar numeracao sem ano" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_inutilizacao))
		expect(schema.valid?(xml_inutilizar_numeracao_sem_ano)).to be(false)
	end

	it "não deve criar um xml válido para mensagem de inutilizar numeracao sem cnpj" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_inutilizacao))
		expect(schema.valid?(xml_inutilizar_numeracao_sem_cnpj)).to be(false)
	end

	it "não deve criar um xml válido para mensagem de inutilizar numeracao sem codigo uf" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_inutilizacao))
		expect(schema.valid?(xml_inutilizar_numeracao_sem_codigo_uf)).to be(false)
	end

	it "não deve criar um xml válido para mensagem de inutilizar numeracao sem justificativa" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_inutilizacao))
		expect(schema.valid?(xml_inutilizar_numeracao_sem_justificativa)).to be(false)
	end

	it "não deve criar um xml válido para mensagem de inutilizar numeracao sem modelo" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_inutilizacao))
		expect(schema.valid?(xml_inutilizar_numeracao_sem_modelo)).to be(false)
	end

	it "não deve criar um xml válido para mensagem de inutilizar numeracao sem numero final" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_inutilizacao))
		expect(schema.valid?(xml_inutilizar_numeracao_sem_numero_final)).to be(false)
	end

	it "não deve criar um xml válido para mensagem de inutilizar numeracao sem numero inicial" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_inutilizacao))
		expect(schema.valid?(xml_inutilizar_numeracao_sem_numero_inicial)).to be(false)
	end

	it "não deve criar um xml válido para mensagem de inutilizar numeracao sem serie" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_inutilizacao))
		expect(schema.valid?(xml_inutilizar_numeracao_sem_serie)).to be(false)
	end

	it "não deve criar um xml válido para mensagem de nfe distribuicao dfe com chave nota e nsu" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_nfe_distribuicao_dfe))
		expect(schema.valid?(xml_nfe_distribuicao_dfe_com_chave_nota_e_nsu)).to be(false)
	end

	it "não deve criar um xml válido para mensagem de nfe distribuicao dfe com chave nota e ultimo nsu" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_nfe_distribuicao_dfe))
		expect(schema.valid?(xml_nfe_distribuicao_dfe_com_chave_nota_e_ultimo_nsu)).to be(false)
	end

	it "não deve criar um xml válido para mensagem de nfe distribuicao dfe com nsu e ultimo nsu" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_nfe_distribuicao_dfe))
		expect(schema.valid?(xml_nfe_distribuicao_dfe_com_nsu_e_ultimo_nsu)).to be(false)
	end

	it "não deve criar um xml válido para mensagem de nfe distribuicao dfe sem ambiente" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_nfe_distribuicao_dfe))
		expect(schema.valid?(xml_nfe_distribuicao_dfe_sem_ambiente)).to be(false)
	end

	it "não deve criar um xml válido para mensagem de nfe distribuicao dfe sem chave nota" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_nfe_distribuicao_dfe))
		expect(schema.valid?(xml_nfe_distribuicao_dfe_sem_chave_nota)).to be(false)
	end

	it "não deve criar um xml válido para mensagem de nfe distribuicao dfe sem cpf cnpj" do |test|
		schema = Nokogiri::XML::Schema(File.open(schema_nfe_distribuicao_dfe))
		expect(schema.valid?(xml_nfe_distribuicao_dfe_sem_cpf_cnpj)).to be(false)
	end
end