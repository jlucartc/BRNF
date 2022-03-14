require_relative './builder_helper.rb'
require_relative './../validator/validator.rb'

module BRNF

	module API

		class Builder

			def autorizar_nota(mensagem)
				gera_xml(mensagem,__method__)
			end

			def consultar_status_servico(mensagem)
				gera_xml(mensagem,__method__)
			end

			def consultar_retorno_autorizacao(mensagem)
				gera_xml(mensagem,__method__)
			end

			def inutilizar_numeracao(mensagem)
				gera_xml(mensagem,__method__)
			end

			def nfe_distribuicao_dfe(mensagem)
				gera_xml(mensagem,__method__)
			end

			def consultar_protocolo(mensagem)
				gera_xml(mensagem,__method__)
			end

			def criar_carta_correcao(mensagem)
				gera_xml(mensagem,__method__)
			end

			def confirmacao_da_operacao(mensagem)
				gera_xml(mensagem,__method__)
			end

			def ciencia_da_operacao(mensagem)
				gera_xml(mensagem,__method__)
			end

			def desconhecimento_da_operacao(mensagem)
				gera_xml(mensagem,__method__)
			end

			def operacao_nao_realizada(mensagem)
				gera_xml(mensagem,__method__)
			end

			def emissao_contingencia(mensagem)
				gera_xml(mensagem,__method__)
			end

			def cancelar_nota_substituicao(mensagem)
				gera_xml(mensagem,__method__)
			end

			def cancelar_nota(mensagem)
				gera_xml(mensagem,__method__)
			end

			def prorrogar_prazo_1(mensagem)
				gera_xml(mensagem,__method__)
			end

			def prorrogar_prazo_2(mensagem)
				gera_xml(mensagem,__method__)
			end

			def ator_interessado(mensagem)
				gera_xml(mensagem,__method__)
			end

			def cancelamento_prazo_1(mensagem)
				gera_xml(mensagem,__method__)
			end
			
			def cancelamento_prazo_2(mensagem)
				gera_xml(mensagem,__method__)
			end

			def consultar_cadastro(mensagem)
				gera_xml(mensagem,__method__)
			end

			private

			def gera_xml(mensagem,metodo)
				xml_builder = BuilderHelper::XMLInflator.new()
				validator = BRNF::Validator.new()
				xml = validator.public_send("valida_#{metodo}",mensagem)
			end

		end

	end

end