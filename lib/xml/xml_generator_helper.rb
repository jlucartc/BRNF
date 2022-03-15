require 'csv'
require 'regexp-examples'
require 'pry'
require 'nokogiri'
require 'digest'
require 'base64'
require 'openssl'
require_relative './../builder/xml_builder.rb'


module XMLGeneratorHelper

	class XMLGenerator

		def initialize
			@builder = BRNF::XMLBuilder.new
		end

		def consultar_cadastro
			@builder.build_xml("56")
		end

		def autorizar_nota
			xml = @builder.build_xml("1")
			@builder.sign_message(xml)
		end

		def consultar_status_servico
			xml = @builder.build_xml("51")
		end

		def consultar_retorno_autorizacao
			xml = @builder.build_xml("6")
		end

		def inutilizar_numeracao
			xml = @builder.build_xml("10")
			@builder.sign_message(xml)
		end

		def nfe_distribuicao_dfe
			xml = @builder.build_xml("64")
		end

		def consultar_protocolo
			xml = @builder.build_xml("46")
		end

		def criar_carta_correcao
			xml = @builder.build_xml("76")
			@builder.sign_message(xml)
		end

		def confirmacao_da_operacao
			xml = @builder.build_xml("76")
			@builder.sign_message(xml)
		end

		def ciencia_da_operacao
			xml = @builder.build_xml("76")
			@builder.sign_message(xml)
		end

		def desconhecimento_da_operacao
			xml = @builder.build_xml("76")
			@builder.sign_message(xml)
		end

		def operacao_nao_realizada
			xml = @builder.build_xml("76")
			@builder.sign_message(xml)
		end

		def emissao_contingencia
			xml = @builder.build_xml("76")
			@builder.sign_message(xml)
		end

		def cancelar_nota_substituicao
			xml = @builder.build_xml("76")
			@builder.sign_message(xml)
		end

		def cancelar_nota
			xml = @builder.build_xml("76")
			@builder.sign_message(xml)
		end

		def prorrogar_prazo_1
			xml = @builder.build_xml("76")
			@builder.sign_message(xml)
		end

		def prorrogar_prazo_2
			xml = @builder.build_xml("76")
			@builder.sign_message(xml)
		end

		def ator_interessado
			xml = @builder.build_xml("76")
			@builder.sign_message(xml)
		end

		def cancelamento_prazo_1
			xml = @builder.build_xml("76")
			@builder.sign_message(xml)
		end

		def cancelamento_prazo_2
			xml = @builder.build_xml("76")
			@builder.sign_message(xml)
		end

	end

end
