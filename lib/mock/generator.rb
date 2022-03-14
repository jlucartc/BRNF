require_relative './generator_helper.rb'
require_relative './../validator/validator.rb'

module BRNF

	module Mock

		class Generator

			def autorizar_nota(documento: nil)
				gera_xml(documento,__method__)
			end

			def consultar_status_servico(documento: nil)
				gera_xml(documento,__method__)
			end

			def consultar_retorno_autorizacao(documento: nil)
				gera_xml(documento,__method__)
			end

			def inutilizar_numeracao(documento: nil)
				gera_xml(documento,__method__)
			end

			def nfe_distribuicao_dfe(documento: nil)
				gera_xml(documento,__method__)
			end

			def consultar_protocolo(documento: nil)
				gera_xml(documento,__method__)
			end

			def criar_carta_correcao(documento: nil)
				gera_xml(documento,__method__)
			end

			def confirmacao_da_operacao(documento: nil)
				gera_xml(documento,__method__)
			end

			def ciencia_da_operacao(documento: nil)
				gera_xml(documento,__method__)
			end

			def desconhecimento_da_operacao(documento: nil)
				gera_xml(documento,__method__)
			end

			def operacao_nao_realizada(documento: nil)
				gera_xml(documento,__method__)
			end

			def emissao_contingencia(documento: nil)
				gera_xml(documento,__method__)
			end

			def cancelar_nota_substituicao(documento: nil)
				gera_xml(documento,__method__)
			end

			def cancelar_nota(documento: nil)
				gera_xml(documento,__method__)
			end

			def prorrogar_prazo_1(documento: nil)
				gera_xml(documento,__method__)
			end

			def prorrogar_prazo_2(documento: nil)
				gera_xml(documento,__method__)
			end

			def ator_interessado(documento: nil)
				gera_xml(documento,__method__)
			end

			def cancelamento_prazo_1(documento: nil)
				gera_xml(documento,__method__)
			end
			
			def cancelamento_prazo_2(documento: nil)
				gera_xml(documento,__method__)
			end

			def consultar_cadastro(documento: nil)
				gera_xml(documento,__method__)
			end

			private

			def gera_xml(documento,metodo)
				xml_builder = GeneratorHelper::XMLGenerator.new()
				
				if documento.nil?
					xml = xml_builder.public_send(metodo)
					validator = BRNF::Validator.new()
					xml = validator.public_send("valida_#{metodo}",xml)
				else
					validator = BRNF::Validator.new()
					xml = validator.public_send("valida_#{metodo}",documento)
				end
			end

		end

	end

end