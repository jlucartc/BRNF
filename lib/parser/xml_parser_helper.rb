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
			@builder.build_xml(56,keep_mutex_tags: true)
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
			@signer.sign_message(xml)
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
			xml = @builder.build_xml(76,keep_mutex_tags: true)
			fill_constant_fields(xml)
			fill_xml(message,xml)
			remove_empty_tags(xml)
			@signer.sign_message(xml)
			xml
		end

		def confirmacao_da_operacao(message)
			xml = @builder.build_xml(76,keep_mutex_tags: true)
			fill_constant_fields(xml)
			fill_xml(message,xml)
			remove_empty_tags(xml)
			@signer.sign_message(xml)
			xml
		end

		def ciencia_da_operacao(message)
			xml = @builder.build_xml(76,keep_mutex_tags: true)
			fill_constant_fields(xml)
			fill_xml(message,xml)
			remove_empty_tags(xml)
			@signer.sign_message(xml)
			xml
		end

		def desconhecimento_da_operacao(message)
			xml = @builder.build_xml(76,keep_mutex_tags: true)
			fill_constant_fields(xml)
			fill_xml(message,xml)
			remove_empty_tags(xml)
			@signer.sign_message(xml)
			xml
		end

		def operacao_nao_realizada(message)
			xml = @builder.build_xml(76,keep_mutex_tags: true)
			fill_constant_fields(xml)
			fill_xml(message,xml)
			remove_empty_tags(xml)
			@signer.sign_message(xml)
			xml
		end

		def emissao_contingencia(message)
			xml = @builder.build_xml(76,keep_mutex_tags: true)
			fill_constant_fields(xml)
			fill_xml(message,xml)
			remove_empty_tags(xml)
			@signer.sign_message(xml)
			xml
		end

		def cancelar_nota_substituicao(message)
			xml = @builder.build_xml(76,keep_mutex_tags: true)
			fill_constant_fields(xml)
			fill_xml(message,xml)
			remove_empty_tags(xml)
			@signer.sign_message(xml)
			xml
		end

		def cancelar_nota(message)
			xml = @builder.build_xml(76,keep_mutex_tags: true)
			fill_constant_fields(xml)
			fill_xml(message,xml)
			remove_empty_tags(xml)
			@signer.sign_message(xml)
			xml
		end

		def prorrogar_prazo_1(message)
			xml = @builder.build_xml(76,keep_mutex_tags: true)
			fill_constant_fields(xml)
			fill_xml(message,xml)
			remove_empty_tags(xml)
			@signer.sign_message(xml)
			xml
		end

		def prorrogar_prazo_2(message)
			xml = @builder.build_xml(76,keep_mutex_tags: true)
			fill_constant_fields(xml)
			fill_xml(message,xml)
			remove_empty_tags(xml)
			@signer.sign_message(xml)
			xml
		end

		def ator_interessado(message)
			xml = @builder.build_xml(76,keep_mutex_tags: true)
			fill_constant_fields(xml)
			fill_xml(message,xml)
			remove_empty_tags(xml)
			@signer.sign_message(xml)
			xml
		end

		def cancelamento_prazo_1(message)
			xml = @builder.build_xml(76,keep_mutex_tags: true)
			fill_constant_fields(xml)
			fill_xml(message,xml)
			remove_empty_tags(xml)
			@signer.sign_message(xml)
			xml
		end

		def cancelamento_prazo_2(message)
			xml = @builder.build_xml(76,keep_mutex_tags: true)
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