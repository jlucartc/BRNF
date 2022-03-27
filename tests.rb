require 'simplecov'
SimpleCov.start

require './lib/brnf.rb'
require 'nokogiri'
require 'pry'
require 'openssl'
require 'pry'

RSpec.describe "Random XML Generator (producao)" do

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
	# message_cancelamento_prazo_1 = JSON.parse(File.open("","r").read)
	# message_cancelamento_prazo_2 = JSON.parse(File.open("","r").read)
	message_consultar_retorno_autorizacao = JSON.parse(File.open("./messages/examples/message_consultar_retorno_autorizacao.json","r").read)
	message_consultar_protocolo = JSON.parse(File.open("./messages/examples/message_consultar_protocolo.json","r").read)
	# message_nfe_distribuicao_dfe = JSON.parse(File.open("","r").read)
	# message_consultar_cadastro = JSON.parse(File.open("","r").read)

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
	# xml_evento_cancelamento_prazo_1 = generator.cancelamento_prazo_1(message: message_cancelamento_prazo_1)
	# xml_evento_cancelamento_prazo_2 = generator.cancelamento_prazo_2(message: message_cancelamento_prazo_2)
	xml_consultar_retorno_autorizacao = generator.consultar_retorno_autorizacao(message: message_consultar_retorno_autorizacao)
	xml_consultar_protocolo = generator.consultar_protocolo(message: message_consultar_protocolo)
	# xml_nfe_distribuicao_dfe = generator.nfe_distribuicao_dfe(message: message_nfe_distribuicao_dfe)
	# xml_consultar_cadastro = generator.consultar_cadastro(message: message_consultar_cadastro)

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

	# it "deve criar um xml válido para mensagem de cancelamento de prazo 1" do |test|
	# 	schema = Nokogiri::XML::Schema(File.open(schema_evento_cancelamento_prazo_1))
	# 	puts schema.validate(xml_evento_cancelamento_prazo_1) if !schema.valid?(xml_evento_cancelamento_prazo_1)
	# 	expect(schema.valid?(xml_evento_cancelamento_prazo_1)).to be(true)
	# end

	# it "deve criar um xml válido para mensagem de cancelamento de prazo 2" do |test|
	# 	schema = Nokogiri::XML::Schema(File.open(schema_evento_cancelamento_prazo_2))
	# 	puts schema.validate(xml_evento_cancelamento_prazo_2) if !schema.valid?(xml_evento_cancelamento_prazo_2)
	# 	expect(schema.valid?(xml_evento_cancelamento_prazo_2)).to be(true)
	# end

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

	# it "deve criar um xml válido para mensagem de distribuicao dfe" do |test|
	# 	schema = Nokogiri::XML::Schema(File.open(schema_nfe_distribuicao_dfe))
	# 	puts schema.validate(xml_nfe_distribuicao_dfe) if !schema.valid?(xml_nfe_distribuicao_dfe)
	# 	expect(schema.valid?(xml_nfe_distribuicao_dfe)).to be(true)
	# end

	# it "deve criar um xml válido para mensagem de consultar cadastro" do |test|
	# 	schema = Nokogiri::XML::Schema(File.open(schema_consultar_cadastro))
	# 	puts schema.validate(xml_consultar_cadastro) if !schema.valid?(xml_consultar_cadastro)
	# 	expect(schema.valid?(xml_consultar_cadastro)).to be(true)
	# end
end