require_relative './generator_helper.rb'
require_relative './validator.rb'

module NF

	module Mock

		module Generator

			def self.autorizar_nota
				xml_builder = GeneratorHelper::XMLGenerator.new()
				xml = xml_builder.autorizar_nota
				validator = NF::Mock::Validator.new()
				xml = validator.verifica_regras(xml)
				xml
			end

			def self.consultar_status_servico
			end

			def self.consultar_retorno_autorizacao
			end

			def self.inutilizar_numeracao
			end

			def self.nfe_distribuicao_dfe
			end

			def self.consultar_protocolo
			end

			def self.criar_carta_correcao
			end

			def self.autorizar_transportador
			end

			def self.criar_manifestacao
			end

			def self.emitir_nota_contingencia
			end

			def self.cancelar_nota
			end

			def self.prorrogar_prazo
			end

		end

	end

end