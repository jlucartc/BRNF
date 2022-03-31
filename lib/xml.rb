require_relative 'parser'
require_relative 'generator'
require_relative 'issuer'

module BRNF

	class XML
		def initialize
			@generator = BRNF::Generator.new
			@parser = BRNF::Parser.new
		end

		def autorizar_nota(message: nil)
			generate_xml(message,__method__)
		end

		def consultar_status_servico(message: nil)
			generate_xml(message,__method__)
		end

		def consultar_retorno_autorizacao(message: nil)
			generate_xml(message,__method__)
		end

		def inutilizar_numeracao(message: nil)
			generate_xml(message,__method__)
		end

		def nfe_distribuicao_dfe(message: nil)
			generate_xml(message,__method__)
		end

		def consultar_protocolo(message: nil)
			generate_xml(message,__method__)
		end

		def criar_carta_correcao(message: nil)
			generate_xml(message,__method__)
		end

		def confirmacao_da_operacao(message: nil)
			generate_xml(message,__method__)
		end

		def ciencia_da_operacao(message: nil)
			generate_xml(message,__method__)
		end

		def desconhecimento_da_operacao(message: nil)
			generate_xml(message,__method__)
		end

		def operacao_nao_realizada(message: nil)
			generate_xml(message,__method__)
		end

		def emissao_contingencia(message: nil)
			generate_xml(message,__method__)
		end

		def cancelar_nota_substituicao(message: nil)
			generate_xml(message,__method__)
		end

		def cancelar_nota(message: nil)
			generate_xml(message,__method__)
		end

		def prorrogar_prazo_1(message: nil)
			generate_xml(message,__method__)
		end

		def prorrogar_prazo_2(message: nil)
			generate_xml(message,__method__)
		end

		def ator_interessado(message: nil)
			generate_xml(message,__method__)
		end

		def cancelamento_prazo_1(message: nil)
			generate_xml(message,__method__)
		end
		
		def cancelamento_prazo_2(message: nil)
			generate_xml(message,__method__)
		end

		def consultar_cadastro(message: nil)
			generate_xml(message,__method__)
		end

		private

		def generate_xml(message,method_name)
			if !message.nil?
				xml = @parser.public_send(method_name,message)
			elsif message.nil?
				xml = @generator.public_send(method_name)
			end
		end
	end

	class Validator
		def autorizar_nota(message)
			validate_xml(message,__method__)
		end

		def consultar_status_servico(message)
			validate_xml(message,__method__)
		end

		def consultar_retorno_autorizacao(message)
			validate_xml(message,__method__)
		end

		def inutilizar_numeracao(message)
			validate_xml(message,__method__)
		end

		def nfe_distribuicao_dfe(message)
			validate_xml(message,__method__)
		end

		def consultar_protocolo(message)
			validate_xml(message,__method__)
		end

		def criar_carta_correcao(message)
			validate_xml(message,__method__)
		end

		def confirmacao_da_operacao(message)
			validate_xml(message,__method__)
		end

		def ciencia_da_operacao(message)
			validate_xml(message,__method__)
		end

		def desconhecimento_da_operacao(message)
			validate_xml(message,__method__)
		end

		def operacao_nao_realizada(message)
			validate_xml(message,__method__)
		end

		def emissao_contingencia(message)
			validate_xml(message,__method__)
		end

		def cancelar_nota_substituicao(message)
			validate_xml(message,__method__)
		end

		def cancelar_nota(message)
			validate_xml(message,__method__)
		end

		def prorrogar_prazo_1(message)
			validate_xml(message,__method__)
		end

		def prorrogar_prazo_2(message)
			validate_xml(message,__method__)
		end

		def ator_interessado(message)
			validate_xml(message,__method__)
		end

		def cancelamento_prazo_1(message)
			validate_xml(message,__method__)
		end
		
		def cancelamento_prazo_2(message)
			validate_xml(message,__method__)
		end

		def consultar_cadastro(message)
			validate_xml(message,__method__)
		end

		private

		def validate_xml(xml,method)
			case method
			when :autorizar_nota
				schema_path = './schemas/enviNFe_v4.00.xsd'
			when :consultar_status_servico
				schema_path = './schemas/consStatServ_v4.00.xsd'
			when :consultar_retorno_autorizacao
				schema_path = './schemas/consReciNFe_v4.00.xsd'
			when :inutilizar_numeracao
				schema_path = './schemas/inutNFe_v4.00.xsd'
			when :nfe_distribuicao_dfe
				schema_path = './schemas/distDFeInt_v1.01.xsd'
			when :consultar_protocolo
				schema_path = './schemas/consSitNFe_v4.00.xsd'
			when :criar_carta_correcao
				schema_path = './schemas/envCCe_v1.00.xsd'
			when :confirmacao_da_operacao
				schema_path = './schemas/envConfRecebto_v1.00.xsd'
			when :ciencia_da_operacao
				schema_path = './schemas/envConfRecebto_v1.00.xsd'
			when :desconhecimento_da_operacao
				schema_path = './schemas/envConfRecebto_v1.00.xsd'
			when :operacao_nao_realizada
				schema_path = './schemas/envConfRecebto_v1.00.xsd'
			when :emissao_contingencia
				schema_path = './schemas/envEPEC_v1.00.xsd'
			when :cancelar_nota_substituicao
				schema_path = './schemas/envEventoCancSubst_v1.00.xsd'
			when :cancelar_nota
				schema_path = './schemas/envEventoCancNFe_v1.00.xsd'
			when :prorrogar_prazo_1
				schema_path = './schemas/envRemIndus_v1.00.xsd'
			when :prorrogar_prazo_2
				schema_path = './schemas/envRemIndus_v1.00.xsd'
			when :ator_interessado
				schema_path = './schemas/envEventoAtorInteressado_v1.00.xsd'
			when :cancelamento_prazo_1
				schema_path = './schemas/envRemIndus_v1.00.xsd'
			when :cancelamento_prazo_2
				schema_path = './schemas/envRemIndus_v1.00.xsd'
			when :consultar_cadastro
				schema_path = './schemas/consCad_v2.00.xsd'
			end

			schema = Nokogiri::XML::Schema(File.open(schema_path))
			schema.validate(xml)
		end
	end
end