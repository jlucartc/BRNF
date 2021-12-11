require 'csv'
require 'regexp-examples'
require 'pry'
require 'nokogiri'

module NF

	module Mock

		module Generator
			
			module GeneratorHelper

				class XMLGenerator

					ELEMENTOS_SAO_TAGS = ["E","G","CE","CG","Raiz"]
					ELEMENTOS_SAO_ATRIBUTOS = ["A"]
					ELEMENTOS_SAO_OPCIONAIS = ["GO","CGO"]

					def initialize
						cria_mapa_tags
					end

					def autorizar_nota
						Nokogiri::XML::Document.parse(constroi_tag("1").to_xml.gsub(/>[\s\n\t]*</,"><"))
					end

					def consultar_status_servico
					end

					def consultar_retorno_autorizacao
					end

					def inutilizar_numeracao
					end

					def nfe_distribuicao_dfe
					end

					def consultar_protocolo
					end

					def criar_carta_correcao
					end

					def autorizar_transportador
					end

					def criar_manifestacao
					end

					def emitir_nota_contingencia
					end

					def cancelar_nota
					end

					def prorrogar_prazo
					end

					private

						def constroi_tag(pai)
							
							tag_pai = Nokogiri::XML("<#{@mapa_tags[pai]["campo"]}>").elements.first
							
							if tem_filhos(pai)
								filhos = busca_filhos(pai)
								filhos.each do |filho|
									tag_filho = @mapa_tags[filho]
									adiciona_filho_no_pai(tag_pai,tag_filho)
								end
							else
								tag_pai = preenche_tag(pai)
							end

							if !@mapa_tags[pai]["namespace"].nil?
								tag_pai["xmlns"] = @mapa_tags[pai]["namespace"]
							end

							tag_pai

						end

						def tem_filhos(pai)
							if @mapa_tags.key?(pai)
								!@mapa_tags[pai]["filhos"].empty?
							else
								false
							end
						end

						def adiciona_filho_no_pai(tag_pai,dados_filho)
							tipo = dados_filho["elemento"]
							if ELEMENTOS_SAO_TAGS.include?(tipo)
								tag_pai.add_child(constroi_tag(dados_filho["id"]))
							elsif ELEMENTOS_SAO_ATRIBUTOS.include?(tipo)
								tag_pai[dados_filho["campo"]] = Regexp.new(dados_filho["regex"]).random_example
							elsif ELEMENTOS_SAO_OPCIONAIS.include?(tipo)
								netos = busca_filhos(dados_filho["id"])
								netos.each do |neto|
									tag_pai.add_child(constroi_tag(neto))
								end
							end
						end

						def preenche_tag(tag)
							regex = @mapa_tags[tag]["regex"]
							tag = Nokogiri::XML("<#{@mapa_tags[tag]["campo"]}>").elements.first
							tag.content = Regexp.new(regex).random_example.gsub("\u0000",'') unless regex.nil?
							tag
						end

						def busca_filhos(pai)
							@mapa_tags[pai]["filhos"]
						end

						def cria_mapa_tags()
							tags = CSV.read('tags.csv',col_sep:";",headers:true)
							mapa_tags = {}
							tags.each do |tag|
								if tag["ativo"] == "1"
									dados_tag = {}
									dados_tag["id"] = tag["id"]
									dados_tag["campo"] = tag["campo"]
									dados_tag["elemento"] = tag["elemento"]
									dados_tag["pai"] = tag["pai"]
									dados_tag["min"] = tag["min"]
									dados_tag["max"] = tag["max"]
									dados_tag["regex"] = tag["regex"]
									dados_tag["namespace"] = tag["namespace"]
									dados_tag["filhos"] = []
									mapa_tags["#{tag["id"]}"] = dados_tag

									if mapa_tags.key?(tag["pai"])
										mapa_tags[tag["pai"]]["filhos"] << tag["id"]
									end
								end
							end
							@mapa_tags = mapa_tags
							remove_tags_mutex
						end

						def remove_tags_mutex
							tags = @mapa_tags.keys
							filhos = {tags_filhos_ce: [],tags_filhos_cg: [],tags_filhos_cgo: [],tags_filhos_normais: []}
							tags.each do |tag_pai|
								lista_filhos = busca_filhos(tag_pai)
								lista_filhos.each do |filho|
									dados_filho = @mapa_tags[filho]
									case dados_filho["elemento"]
									when "CE"
										filhos[:tags_filhos_ce] << filho
									when "CG"
										filhos[:tags_filhos_cg] << filho
									when "CGO"
										filhos[:tags_filhos_cgo] << filho
									else
										filhos[:tags_filhos_normais] << filho
									end
								end
								@mapa_tags[tag_pai]["filhos"] = ([filhos[:tags_filhos_ce].sample,filhos[:tags_filhos_cg].sample,filhos[:tags_filhos_cgo].sample].compact + filhos[:tags_filhos_normais]).sort
								filhos = {tags_filhos_ce: [],tags_filhos_cg: [],tags_filhos_cgo: [],tags_filhos_normais: []}
							end
						end

						def gera_exemplo(string_regex)
							valor = ""
							while valor.empty?
								valor = Regexp.new(string_regex).random_example
							end
							valor
						end

				end

			end

		end

	end

end