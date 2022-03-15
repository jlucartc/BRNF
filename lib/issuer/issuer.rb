require_relative './../validator/validator.rb'

module BRNF

	class Issuer

		def initialize
		end

		def autorizar_nota(xml: nil)
			send_message(mensagem,documento,__method__)
		end

		def consultar_status_servico(xml: nil)
			send_message(mensagem,documento,__method__)
		end

		def consultar_retorno_autorizacao(xml: nil)
			send_message(mensagem,documento,__method__)
		end

		def inutilizar_numeracao(xml: nil)
			send_message(mensagem,documento,__method__)
		end

		def nfe_distribuicao_dfe(xml: nil)
			send_message(mensagem,documento,__method__)
		end

		def consultar_protocolo(xml: nil)
			send_message(mensagem,documento,__method__)
		end

		def criar_carta_correcao(xml: nil)
			send_message(mensagem,documento,__method__)
		end

		def confirmacao_da_operacao(xml: nil)
			send_message(mensagem,documento,__method__)
		end

		def ciencia_da_operacao(xml: nil)
			send_message(mensagem,documento,__method__)
		end

		def desconhecimento_da_operacao(xml: nil)
			send_message(mensagem,documento,__method__)
		end

		def operacao_nao_realizada(xml: nil)
			send_message(mensagem,documento,__method__)
		end

		def emissao_contingencia(xml: nil)
			send_message(mensagem,documento,__method__)
		end

		def cancelar_nota_substituicao(xml: nil)
			send_message(mensagem,documento,__method__)
		end

		def cancelar_nota(xml: nil)
			send_message(mensagem,documento,__method__)
		end

		def prorrogar_prazo_1(xml: nil)
			send_message(mensagem,documento,__method__)
		end

		def prorrogar_prazo_2(xml: nil)
			send_message(mensagem,documento,__method__)
		end

		def ator_interessado(xml: nil)
			send_message(mensagem,documento,__method__)
		end

		def cancelamento_prazo_1(xml: nil)
			send_message(mensagem,documento,__method__)
		end
		
		def cancelamento_prazo_2(xml: nil)
			send_message(mensagem,documento,__method__)
		end

		def consultar_cadastro(xml: nil)
			send_message(mensagem,documento,__method__)
		end

		private

		def send_message(xml,metodo)
		end

	end

end