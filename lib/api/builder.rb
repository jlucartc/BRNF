require_relative './builder_helper.rb'

module BRNF

	module API

		module Builder

			def self.autorizar_nota(mensagem)
				gera_xml(mensagem,__method__)
			end

			def self.consultar_status_servico(mensagem)
				gera_xml(mensagem,__method__)
			end

			def self.consultar_retorno_autorizacao(mensagem)
				gera_xml(mensagem,__method__)
			end

			def self.inutilizar_numeracao(mensagem)
				gera_xml(mensagem,__method__)
			end

			def self.nfe_distribuicao_dfe(mensagem)
				gera_xml(mensagem,__method__)
			end

			def self.consultar_protocolo(mensagem)
				gera_xml(mensagem,__method__)
			end

			def self.criar_carta_correcao(mensagem)
				gera_xml(mensagem,__method__)
			end

			def self.confirmacao_da_operacao(mensagem)
				gera_xml(mensagem,__method__)
			end

			def self.ciencia_da_operacao(mensagem)
				gera_xml(mensagem,__method__)
			end

			def self.desconhecimento_da_operacao(mensagem)
				gera_xml(mensagem,__method__)
			end

			def self.operacao_nao_realizada(mensagem)
				gera_xml(mensagem,__method__)
			end

			def self.emissao_contingencia(mensagem)
				gera_xml(mensagem,__method__)
			end

			def self.cancelar_nota_substituicao(mensagem)
				gera_xml(mensagem,__method__)
			end

			def self.cancelar_nota(mensagem)
				gera_xml(mensagem,__method__)
			end

			def self.prorrogar_prazo_1(mensagem)
				gera_xml(mensagem,__method__)
			end

			def self.prorrogar_prazo_2(mensagem)
				gera_xml(mensagem,__method__)
			end

			def self.ator_interessado(mensagem)
				gera_xml(mensagem,__method__)
			end

			def self.cancelamento_prazo_1(mensagem)
				gera_xml(mensagem,__method__)
			end
			
			def self.cancelamento_prazo_2(mensagem)
				gera_xml(mensagem,__method__)
			end

			def self.consultar_cadastro(mensagem)
				gera_xml(mensagem,__method__)
			end

			def self.gera_xml(mensagem,metodo)
				xml_builder = BuilderHelper::XMLGenerator.new()
				
				if mensagem.nil?
					xml = xml_builder.public_send(metodo,mensagem)
					validator = NF::Mock::Validator.new()
					xml = validator.public_send("valida_#{metodo}",xml)
				else
					validator = NF::Mock::Validator.new()
					xml = validator.public_send("valida_#{metodo}",mensagem)
				end
			end

		end

	end

end