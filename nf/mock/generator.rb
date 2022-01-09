require_relative './generator_helper.rb'
require_relative './validator.rb'

module NF

	module Mock

		module Generator

			def self.autorizar_nota(documento)
				xml_builder = GeneratorHelper::XMLGenerator.new()
				
				if documento.nil?
					xml = xml_builder.autorizar_nota
					validator = NF::Mock::Validator.new()
					xml = validator.verifica_autorizacao(xml)
				else
					validator = NF::Mock::Validator.new()
					xml = validator.verifica_autorizacao(documento)
				end
			end

			def self.consultar_status_servico(documento)
				xml_builder = GeneratorHelper::XMLGenerator.new()
				
				if documento.nil?
					xml = xml_builder.consultar_status_servico
					validator = NF::Mock::Validator.new()
					xml = validator.verifica_consultar_status_servico(xml)
				else
					validator = NF::Mock::Validator.new()
					xml = validator.verifica_consultar_status_servico(documento)
				end
			end

			def self.consultar_retorno_autorizacao(documento)
				xml_builder = GeneratorHelper::XMLGenerator.new()
				
				if documento.nil?
					xml = xml_builder.consultar_retorno_autorizacao
					validator = NF::Mock::Validator.new()
					xml = validator.verifica_consultar_retorno_autorizacao(xml)
				else
					validator = NF::Mock::Validator.new()
					xml = validator.verifica_consultar_retorno_autorizacao(documento)
				end
			end

			def self.inutilizar_numeracao(documento)
				xml_builder = GeneratorHelper::XMLGenerator.new()

				if documento.nil?
					xml = xml_builder.inutilizar_numeracao
					validator = NF::Mock::Validator.new()
					xml = validator.verifica_inutilizacao(xml)					
				else
					validator = NF::Mock::Validator.new()
					xml = validator.verifica_inutilizacao(documento)
				end
			end

			def self.nfe_distribuicao_dfe(documento)
			end

			def self.consultar_protocolo(documento)
				xml_builder = GeneratorHelper::XMLGenerator.new()

				if documento.nil?
					xml = xml_builder.consultar_protocolo
					validator = NF::Mock::Validator.new()
					xml = validator.verifica_consultar_protocolo(xml)					
				else
					validator = NF::Mock::Validator.new()
					xml = validator.verifica_consultar_protocolo(documento)
				end
			end

			def self.criar_carta_correcao(documento)
				xml_builder = GeneratorHelper::XMLGenerator.new()

				if documento.nil?
					xml = xml_builder.criar_carta_correcao
					validator = NF::Mock::Validator.new()
					xml = validator.verifica_carta_correcao(xml)					
				else
					validator = NF::Mock::Validator.new()
					xml = validator.verifica_carta_correcao(documento)
				end
			end

			def self.confirmacao_da_operacao(documento)
				xml_builder = GeneratorHelper::XMLGenerator.new()

				if documento.nil?
					xml = xml_builder.confirmacao_da_operacao
					validator = NF::Mock::Validator.new()
					xml = validator.verifica_confirmacao_da_operacao(xml)					
				else
					validator = NF::Mock::Validator.new()
					xml = validator.verifica_confirmacao_da_operacao(documento)
				end
			end

			def self.ciencia_da_operacao(documento)
				xml_builder = GeneratorHelper::XMLGenerator.new()

				if documento.nil?
					xml = xml_builder.ciencia_da_operacao
					validator = NF::Mock::Validator.new()
					xml = validator.verifica_ciencia_da_operacao(xml)					
				else
					validator = NF::Mock::Validator.new()
					xml = validator.verifica_ciencia_da_operacao(documento)
				end
			end

			def self.desconhecimento_da_operacao(documento)
				xml_builder = GeneratorHelper::XMLGenerator.new()

				if documento.nil?
					xml = xml_builder.desconhecimento_da_operacao
					validator = NF::Mock::Validator.new()
					xml = validator.verifica_desconhecimento_da_operacao(xml)					
				else
					validator = NF::Mock::Validator.new()
					xml = validator.verifica_desconhecimento_da_operacao(documento)
				end
			end

			def self.operacao_nao_realizada(documento)
				xml_builder = GeneratorHelper::XMLGenerator.new()

				if documento.nil?
					xml = xml_builder.operacao_nao_realizada
					validator = NF::Mock::Validator.new()
					xml = validator.verifica_operacao_nao_realizada(xml)					
				else
					validator = NF::Mock::Validator.new()
					xml = validator.verifica_operacao_nao_realizada(documento)
				end
			end

			def self.emissao_contingencia(documento)
				xml_builder = GeneratorHelper::XMLGenerator.new()

				if documento.nil?
					xml = xml_builder.emissao_contingencia
					validator = NF::Mock::Validator.new()
					xml = validator.verifica_emissao_contingencia(xml)					
				else
					validator = NF::Mock::Validator.new()
					xml = validator.verifica_emissao_contingencia(documento)
				end
			end

			def self.cancelar_nota_substituicao(documento)
				xml_builder = GeneratorHelper::XMLGenerator.new()

				if documento.nil?
					xml = xml_builder.cancelar_nota_substituicao
					validator = NF::Mock::Validator.new()
					xml = validator.verifica_cancelar_nota_substituicao(xml)					
				else
					validator = NF::Mock::Validator.new()
					xml = validator.verifica_cancelar_nota_substituicao(documento)
				end
			end

			def self.cancelar_nota(documento)
				xml_builder = GeneratorHelper::XMLGenerator.new()

				if documento.nil?
					xml = xml_builder.cancelar_nota
					validator = NF::Mock::Validator.new()
					xml = validator.verifica_cancelar_nota(xml)					
				else
					validator = NF::Mock::Validator.new()
					xml = validator.verifica_cancelar_nota(documento)
				end
			end

			def self.prorrogar_prazo_1(documento)
				xml_builder = GeneratorHelper::XMLGenerator.new()

				if documento.nil?
					xml = xml_builder.prorrogar_prazo_1
					validator = NF::Mock::Validator.new()
					xml = validator.verifica_prorrogar_prazo_1(xml)					
				else
					validator = NF::Mock::Validator.new()
					xml = validator.verifica_prorrogar_prazo_1(documento)
				end
			end

			def self.prorrogar_prazo_2(documento)
				xml_builder = GeneratorHelper::XMLGenerator.new()

				if documento.nil?
					xml = xml_builder.prorrogar_prazo_2
					validator = NF::Mock::Validator.new()
					xml = validator.verifica_prorrogar_prazo_2(xml)					
				else
					validator = NF::Mock::Validator.new()
					xml = validator.verifica_prorrogar_prazo_2(documento)
				end
			end

			def self.ator_interessado(documento)
				xml_builder = GeneratorHelper::XMLGenerator.new()

				if documento.nil?
					xml = xml_builder.ator_interessado
					validator = NF::Mock::Validator.new()
					xml = validator.verifica_ator_interessado(xml)					
				else
					validator = NF::Mock::Validator.new()
					xml = validator.verifica_ator_interessado(documento)
				end
			end

			def self.cancelamento_prazo_1(documento)
				xml_builder = GeneratorHelper::XMLGenerator.new()

				if documento.nil?
					xml = xml_builder.cancelamento_prazo_1
					validator = NF::Mock::Validator.new()
					xml = validator.verifica_cancelamento_prazo_1(xml)					
				else
					validator = NF::Mock::Validator.new()
					xml = validator.verifica_cancelamento_prazo_1(documento)
				end
			end
			
			def self.cancelamento_prazo_2(documento)
				xml_builder = GeneratorHelper::XMLGenerator.new()

				if documento.nil?
					xml = xml_builder.cancelamento_prazo_2
					validator = NF::Mock::Validator.new()
					xml = validator.verifica_cancelamento_prazo_2(xml)					
				else
					validator = NF::Mock::Validator.new()
					xml = validator.verifica_cancelamento_prazo_2(documento)
				end
			end

		end

	end

end