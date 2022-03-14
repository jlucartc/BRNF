require_relative './generator_helper.rb'
require_relative './validator.rb'

module BRNF

	module Mock

		module Generator

			def self.autorizar_nota(documento: nil)
				gera_xml(documento,__method__)
			end

			def self.consultar_status_servico(documento: nil)
				gera_xml(documento,__method__)
			end

			def self.consultar_retorno_autorizacao(documento: nil)
				gera_xml(documento,__method__)
			end

			def self.inutilizar_numeracao(documento: nil)
				gera_xml(documento,__method__)
			end

			def self.nfe_distribuicao_dfe(documento: nil)
				gera_xml(documento,__method__)
			end

			def self.consultar_protocolo(documento: nil)
				gera_xml(documento,__method__)
			end

			def self.criar_carta_correcao(documento: nil)
				gera_xml(documento,__method__)
			end

			def self.confirmacao_da_operacao(documento: nil)
				gera_xml(documento,__method__)
			end

			def self.ciencia_da_operacao(documento: nil)
				gera_xml(documento,__method__)
			end

			def self.desconhecimento_da_operacao(documento: nil)
				gera_xml(documento,__method__)
			end

			def self.operacao_nao_realizada(documento: nil)
				gera_xml(documento,__method__)
			end

			def self.emissao_contingencia(documento: nil)
				gera_xml(documento,__method__)
			end

			def self.cancelar_nota_substituicao(documento: nil)
				gera_xml(documento,__method__)
			end

			def self.cancelar_nota(documento: nil)
				gera_xml(documento,__method__)
			end

			def self.prorrogar_prazo_1(documento: nil)
				gera_xml(documento,__method__)
			end

			def self.prorrogar_prazo_2(documento: nil)
				gera_xml(documento,__method__)
			end

			def self.ator_interessado(documento: nil)
				gera_xml(documento,__method__)
			end

			def self.cancelamento_prazo_1(documento: nil)
				gera_xml(documento,__method__)
			end
			
			def self.cancelamento_prazo_2(documento: nil)
				gera_xml(documento,__method__)
			end

			def self.consultar_cadastro(documento: nil)
				gera_xml(documento,__method__)
			end

			def self.gera_xml(documento,metodo)
				xml_builder = GeneratorHelper::XMLGenerator.new()
				
				if documento.nil?
					xml = xml_builder.public_send(metodo)
					validator = BRNF::Mock::Validator.new()
					xml = validator.public_send("valida_#{metodo}",xml)
				else
					validator = BRNF::Mock::Validator.new()
					xml = validator.public_send("valida_#{metodo}",documento)
				end
			end

		end

	end

end