require_relative './xml_parser_helper.rb'
require_relative './xml_generator_helper.rb'
require_relative './../validator/validator.rb'

module BRNF

	class XML

		def initialize
			@generator = XMLGeneratorHelper::XMLGenerator.new
			@parser = XMLParserHelper::XMLInflator.new
			@validator = BRNF::Validator.new
		end

		def autorizar_nota(mensagem: nil, documento: nil)
			generate_xml(mensagem,documento,__method__)
		end

		def consultar_status_servico(mensagem: nil, documento: nil)
			generate_xml(mensagem,documento,__method__)
		end

		def consultar_retorno_autorizacao(mensagem: nil, documento: nil)
			generate_xml(mensagem,documento,__method__)
		end

		def inutilizar_numeracao(mensagem: nil, documento: nil)
			generate_xml(mensagem,documento,__method__)
		end

		def nfe_distribuicao_dfe(mensagem: nil, documento: nil)
			generate_xml(mensagem,documento,__method__)
		end

		def consultar_protocolo(mensagem: nil, documento: nil)
			generate_xml(mensagem,documento,__method__)
		end

		def criar_carta_correcao(mensagem: nil, documento: nil)
			generate_xml(mensagem,documento,__method__)
		end

		def confirmacao_da_operacao(mensagem: nil, documento: nil)
			generate_xml(mensagem,documento,__method__)
		end

		def ciencia_da_operacao(mensagem: nil, documento: nil)
			generate_xml(mensagem,documento,__method__)
		end

		def desconhecimento_da_operacao(mensagem: nil, documento: nil)
			generate_xml(mensagem,documento,__method__)
		end

		def operacao_nao_realizada(mensagem: nil, documento: nil)
			generate_xml(mensagem,documento,__method__)
		end

		def emissao_contingencia(mensagem: nil, documento: nil)
			generate_xml(mensagem,documento,__method__)
		end

		def cancelar_nota_substituicao(mensagem: nil, documento: nil)
			generate_xml(mensagem,documento,__method__)
		end

		def cancelar_nota(mensagem: nil, documento: nil)
			generate_xml(mensagem,documento,__method__)
		end

		def prorrogar_prazo_1(mensagem: nil, documento: nil)
			generate_xml(mensagem,documento,__method__)
		end

		def prorrogar_prazo_2(mensagem: nil, documento: nil)
			generate_xml(mensagem,documento,__method__)
		end

		def ator_interessado(mensagem: nil, documento: nil)
			generate_xml(mensagem,documento,__method__)
		end

		def cancelamento_prazo_1(mensagem: nil, documento: nil)
			generate_xml(mensagem,documento,__method__)
		end
		
		def cancelamento_prazo_2(mensagem: nil, documento: nil)
			generate_xml(mensagem,documento,__method__)
		end

		def consultar_cadastro(mensagem: nil, documento: nil)
			generate_xml(mensagem,documento,__method__)
		end

		private

		def generate_xml(mensagem,documento,metodo)
			if documento.nil? and !mensagem.nil?
				xml = @parser.autorizar_nota(mensagem)
				binding.pry
				xml = @validator.public_send("valida_#{metodo}",mensagem)
			elsif !documento.nil? and mensagem.nil?
				binding.pry
				xml = @validator.public_send("valida_#{metodo}",documento)
			elsif documento.nil? and mensagem.nil?
				xml = @generator.public_send(metodo)
				xml = @validator.public_send("valida_#{metodo}",xml)
			else
				raise "Error: both 'message' and 'document' parameters shoudn't be sent in the method. Choose one and try again."
			end
		end

	end

end