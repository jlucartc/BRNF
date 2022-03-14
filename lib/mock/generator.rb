require_relative './generator_helper.rb'
require_relative './validator.rb'

module BRNF

	module Mock

		module Generator

			def self.autorizar_nota(documento)
				gera_xml(documento,__method__)
			end

			def self.consultar_status_servico(documento)
				gera_xml(documento,__method__)
			end

			def self.consultar_retorno_autorizacao(documento)
				gera_xml(documento,__method__)
			end

			def self.inutilizar_numeracao(documento)
				gera_xml(documento,__method__)
			end

			def self.nfe_distribuicao_dfe(documento)
				gera_xml(documento,__method__)
			end

			def self.consultar_protocolo(documento)
				gera_xml(documento,__method__)
			end

			def self.criar_carta_correcao(documento)
				gera_xml(documento,__method__)
			end

			def self.confirmacao_da_operacao(documento)
				gera_xml(documento,__method__)
			end

			def self.ciencia_da_operacao(documento)
				gera_xml(documento,__method__)
			end

			def self.desconhecimento_da_operacao(documento)
				gera_xml(documento,__method__)
			end

			def self.operacao_nao_realizada(documento)
				gera_xml(documento,__method__)
			end

			def self.emissao_contingencia(documento)
				gera_xml(documento,__method__)
			end

			def self.cancelar_nota_substituicao(documento)
				gera_xml(documento,__method__)
			end

			def self.cancelar_nota(documento)
				gera_xml(documento,__method__)
			end

			def self.prorrogar_prazo_1(documento)
				gera_xml(documento,__method__)
			end

			def self.prorrogar_prazo_2(documento)
				gera_xml(documento,__method__)
			end

			def self.ator_interessado(documento)
				gera_xml(documento,__method__)
			end

			def self.cancelamento_prazo_1(documento)
				gera_xml(documento,__method__)
			end
			
			def self.cancelamento_prazo_2(documento)
				gera_xml(documento,__method__)
			end

			def self.consultar_cadastro(documento)
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