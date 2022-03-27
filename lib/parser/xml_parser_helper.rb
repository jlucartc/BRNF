require 'csv'
require 'regexp-examples'
require 'pry'
require 'nokogiri'
require 'json'
require_relative './../builder/xml_builder.rb'
require_relative './../signer.rb'
require_relative './../tag_map.rb'
require_relative './../tag_lambdas.rb'

module XMLParserHelper

	class XMLInflator

		class Grupo
			attr_accessor :tag_number
			attr_accessor :children
			attr_accessor :repeats

			def initialize(tag_number,children,repeats)
				self.tag_number = tag_number
				self.children = children
				self.repeats = repeats
			end
		end

		def initialize
			@builder = BRNF::XMLBuilder.new(fill: false)
			@signer = BRNF::Signer.new
			@map = BRNF::TagMap.new(keep_mutex_tags: true)
			@lambdas = BRNF::TagLambdas::LAMBDAS
		end

		def consultar_cadastro(message)
			xml = @builder.build_xml(56,keep_mutex_tags: true)
			fill_constant_fields(xml)
			fill_xml(message,xml)
			remove_empty_tags(xml)
			xml
		end

		def autorizar_nota(message)
			xml = @builder.build_xml(1,keep_mutex_tags: true)
			fill_constant_fields(xml)
			fill_xml(message,xml)
			remove_empty_tags(xml)
			@signer.sign_message(xml)
			xml
		end

		def consultar_status_servico(message)
			xml = @builder.build_xml(51,keep_mutex_tags: true)
			fill_constant_fields(xml)
			fill_xml(message,xml)
			remove_empty_tags(xml)
			xml
		end

		def consultar_retorno_autorizacao(message)
			xml = @builder.build_xml(6,keep_mutex_tags: true)
			fill_constant_fields(xml)
			fill_xml(message,xml)
			remove_empty_tags(xml)
			xml
		end

		def inutilizar_numeracao(message)
			xml = @builder.build_xml(10,keep_mutex_tags: true)
			fill_constant_fields(xml)
			fill_xml(message,xml)
			remove_empty_tags(xml)
			@signer.sign_message(xml)
			xml
		end

		def nfe_distribuicao_dfe(message)
			xml = @builder.build_xml(64,keep_mutex_tags: true)
			fill_constant_fields(xml)
			fill_xml(message,xml)
			remove_empty_tags(xml)
			xml
		end

		def consultar_protocolo(message)
			xml = @builder.build_xml(46,keep_mutex_tags: true)
			fill_constant_fields(xml)
			fill_xml(message,xml)
			remove_empty_tags(xml)
			xml
		end

		def criar_carta_correcao(message)
			message["tipo_evento"] = "110110"
			message["detalhes"]["descricao"] = "Carta de Correcao"
			message["detalhes"]["condicao_uso"] = "A Carta de Correcao e disciplinada pelo paragrafo 1o-A do art. 7o do Convenio S/N, de 15 de dezembro de 1970 e pode ser utilizada para regularizacao de erro ocorrido na emissao de documento fiscal, desde que o erro nao esteja relacionado com: I - as variaveis que determinam o valor do imposto tais como: base de calculo, aliquota, diferenca de preco, quantidade, valor da operacao ou da prestacao; II - a correcao de dados cadastrais que implique mudanca do remetente ou do destinatario; III - a data de emissao ou de saida."
			xml = @builder.build_xml(76,keep_mutex_tags: true)
			fill_constant_fields(xml)
			fill_xml(message,xml)
			remove_empty_tags(xml)
			@signer.sign_message(xml)
			xml
		end

		def confirmacao_da_operacao(message)
			message["tipo_evento"] = "210200"
			message["detalhes"]["descricao"] = "Confirmacao da Operacao"
			xml = @builder.build_xml(116,keep_mutex_tags: true)
			fill_constant_fields(xml)
			fill_xml(message,xml)
			remove_empty_tags(xml)
			@signer.sign_message(xml)
			xml
		end

		def ciencia_da_operacao(message)
			message["tipo_evento"] = "210220"
			message["detalhes"]["descricao"] = "Ciencia da Operacao"
			xml = @builder.build_xml(156,keep_mutex_tags: true)
			fill_constant_fields(xml)
			fill_xml(message,xml)
			remove_empty_tags(xml)
			@signer.sign_message(xml)
			xml
		end

		def desconhecimento_da_operacao(message)
			message["tipo_evento"] = "210220"
			message["detalhes"]["descricao"] = "Desconhecimento da Operacao"
			xml = @builder.build_xml(196,keep_mutex_tags: true)
			fill_constant_fields(xml)
			fill_xml(message,xml)
			remove_empty_tags(xml)
			@signer.sign_message(xml)
			xml
		end

		def operacao_nao_realizada(message)
			message["tipo_evento"] = "210240"
			message["detalhes"]["descricao"] = "Operacao nao Realizada"
			xml = @builder.build_xml(236,keep_mutex_tags: true)
			fill_constant_fields(xml)
			fill_xml(message,xml)
			remove_empty_tags(xml)
			@signer.sign_message(xml)
			xml
		end

		def emissao_contingencia(message)
			message["tipo_evento"] = "110140"
			message["detalhes"]["descricao"] = "EPEC"
			xml = @builder.build_xml(276,keep_mutex_tags: true)
			fill_constant_fields(xml)
			fill_xml(message,xml)
			remove_empty_tags(xml)
			@signer.sign_message(xml)
			xml
		end

		def cancelar_nota_substituicao(message)
			message["tipo_evento"] = "110112"
			message["detalhes"]["descricao"] = "Cancelamento por substituicao"
			xml = @builder.build_xml(316,keep_mutex_tags: true)
			fill_constant_fields(xml)
			fill_xml(message,xml)
			remove_empty_tags(xml)
			@signer.sign_message(xml)
			xml
		end

		def cancelar_nota(message)
			message["tipo_evento"] = "110111"
			message["detalhes"]["descricao"] = "Cancelamento"
			xml = @builder.build_xml(356,keep_mutex_tags: true)
			fill_constant_fields(xml)
			fill_xml(message,xml)
			remove_empty_tags(xml)
			@signer.sign_message(xml)
			xml
		end

		def prorrogar_prazo_1(message)
			message["tipo_evento"] = "111500"
			message["detalhes"]["descricao"] = "Pedido de Prorrogacao"
			xml = @builder.build_xml(396,keep_mutex_tags: true)
			fill_constant_fields(xml)
			fill_xml(message,xml)
			remove_empty_tags(xml)
			@signer.sign_message(xml)
			xml
		end

		def prorrogar_prazo_2(message)
			message["tipo_evento"] = "111501"
			message["detalhes"]["descricao"] = "Pedido de Prorrogacao"
			xml = @builder.build_xml(436,keep_mutex_tags: true)
			fill_constant_fields(xml)
			fill_xml(message,xml)
			remove_empty_tags(xml)
			@signer.sign_message(xml)
			xml
		end

		def ator_interessado(message)
			message["tipo_evento"] = "110150"
			message["detalhes"]["descricao"] = "Ator interessado na NF-e"
			message["detalhes"]["condicao_uso"] = "O emitente ou destinatário da NF-e, declara que permite o transportador declarado no campo CNPJ/CPF deste evento a autorizar os transportadores subcontratados ou redespachados a terem acesso ao download da NF-e"
			xml = @builder.build_xml(476,keep_mutex_tags: true)
			fill_constant_fields(xml)
			fill_xml(message,xml)
			remove_empty_tags(xml)
			@signer.sign_message(xml)
			xml
		end

		def cancelamento_prazo_1(message)
			message["tipo_evento"] = "111501"
			message["detalhes"]["descricao"] = "Pedido de Prorrogacao"
			xml = @builder.build_xml(516,keep_mutex_tags: true)
			fill_constant_fields(xml)
			fill_xml(message,xml)
			remove_empty_tags(xml)
			@signer.sign_message(xml)
			xml
		end

		def cancelamento_prazo_2(message)
			message["tipo_evento"] = "111503"
			message["detalhes"]["descricao"] = "Pedido de Prorrogacao"
			xml = @builder.build_xml(556,keep_mutex_tags: true)
			fill_constant_fields(xml)
			fill_xml(message,xml)
			remove_empty_tags(xml)
			@signer.sign_message(xml)
			xml
		end

		private

		def create_xml_tag(tag_name)
			Nokogiri::XML("<#{tag_name}>").elements.first
		end

		def fill_constant_fields(xml)
			tags = @map.get_constant_regex_tags
			tags.each do |tag|
				xml_tag = xml.xpath(tag["xpath"],"xs" => tag["xpath_namespace"]).first
				xml_tag.content = Regexp.new(tag["regex"]).random_example.gsub("\u0000",'') if !xml_tag.nil?
			end
		end

		def fill_xml(msg,xml)
			@map.get_real_tags.each do |tag|
				@lambdas[tag["xpath"]].call(msg,xml) if !@lambdas[tag["xpath"]].nil?
			end
		end

		def remove_empty_tags(xml)
			root = xml.is_a?(Nokogiri::XML::Document) ? xml.root : xml

			if root.is_a?(Nokogiri::XML::Text)
				root.remove if root.content.empty?
			else
				if root.children.empty?
					root.remove
				else
					root.children.each do |child|
						remove_empty_tags(child)
					end
					root.remove if root.children.empty?
				end
			end
		end
	end
end