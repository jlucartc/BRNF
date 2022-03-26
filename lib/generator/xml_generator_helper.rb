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
			@builder.build_xml(56)
		end

		def autorizar_nota
			@builder.build_xml(1)
		end

		def consultar_status_servico
			@builder.build_xml(51)
		end

		def consultar_retorno_autorizacao
			@builder.build_xml(6)
		end

		def inutilizar_numeracao
			@builder.build_xml(10)
		end

		def nfe_distribuicao_dfe
			@builder.build_xml(64)
		end

		def consultar_protocolo
			@builder.build_xml(46)
		end

		def criar_carta_correcao
			@builder.build_xml(76)
		end

		def confirmacao_da_operacao
			@builder.build_xml(116)
		end

		def ciencia_da_operacao
			@builder.build_xml(156)
		end

		def desconhecimento_da_operacao
			@builder.build_xml(196)
		end

		def operacao_nao_realizada
			@builder.build_xml(236)
		end

		def emissao_contingencia
			@builder.build_xml(276)
		end

		def cancelar_nota_substituicao
			@builder.build_xml(316)
		end

		def cancelar_nota
			@builder.build_xml(356)
		end

		def prorrogar_prazo_1
			@builder.build_xml(396)
		end

		def prorrogar_prazo_2
			@builder.build_xml(436)
		end

		def ator_interessado
			@builder.build_xml(476)
		end

		def cancelamento_prazo_1
			@builder.build_xml(516)
		end

		def cancelamento_prazo_2
			@builder.build_xml(556)
		end
	end
end
