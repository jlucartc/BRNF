require 'csv'
require 'regexp-examples'
require 'pry'
require 'nokogiri'
require 'json'

module BRNF

	module API

		module Builder

			module BuilderHelper

				class XMLBuilder

					class Grupo
						attr_accessor :tag_number
						attr_accessor :children
						attr_accessor :repeats

						def initialize(tag_number,children,repeats)
							self.tag_number = tag_number
							self.children = children
							self.repeats
						end
					end

					TAGS = ["E","G","CE","CG","Raiz"]
					ATRIBUTOS = ["A"]
					OPCIONAIS = ["GO","CGO"]

					def initialize
						cria_mapa_tags
					end

					def consultar_cadastro(mensagem)
						mensagem = {
							servico:"xServ",
							uf:"UF",
							inscricao_estadual:"IE",
							cnpj:"CNPJ",
							cpf:"CPF"
						}
					end

					def autorizar_nota(mensagem)
						mensagem = {
							lote:"idLote",
							identificacao:{
								codigo_uf:"cUF",
								codigo_numerico:"cNF",
								modelo:"mod",
								serie:"serie",
								numero_nota:"nNF",
								data_saida_entrada:"dhEmi",
								tipo_nota:"tpNF",
								tipo_impressao:"tpImp",
								ambiente:"tpAmb",
								finalidade:"finNFe",
								indicador_consumidor:"indFinal",
								indicador_presencial:"indPres",
								versao_aplicacao:"verProc",
								justificativa_contingencia:"xJust",
								ano_mes:"AAMM",
								modelo_referenciado:"mod",
								serie_referenciada:"serie",
								numero_nota_referenciada:"nNF",
								cpf_cnpj:"CNPJ/CPF",
								inscricao_estadual:"IE",
								chave_cte:"refCTe",
								numero_ecf:"nECF",
								numero_coo:"nCOO",
								emissor: Grupo.new(1,{
									cpf_cnpj:"CNPJ/CPF",
									nome_razao_social:"xNome",
									nome_fantasia:"xFant",
									logradouro:"xLgr",
									numero:"nro",
									complemento:"xCpl",
									bairro:"xBairro",
									codigo_municipio:"cMun",
									nome_municipio:"xMun",
									uf:"UF",
									cep:"CEP",
									codigo_pais:"cPais",
									nome_pais:"xPais",
									fone:"fone",
									inscricao_estadual:"IE",
									inscricao_estadual_substituto:"IEST",
									inscricao_municipal:"IM",
									regime_tributario:"CRT",
									cnae:"CNAE"
								},false),
								destinatario:Grupo.new(1,{
									cpf_cnpj:"CNPJ/CPF",
									id_estrangeiro:"idEstrangeiro",
									nome_razao_social:"xNome",
									logradouro:"xLgr",
									numero:"nro",
									complemento:"xCpl",
									bairro:"xBairro",
									codigo_municipio:"cMun",
									nome_municipio:"xMun",
									uf:"UF",
									cep:"CEP",
									codigo_pais:"cPais",
									nome_pais:"xPais",
									fone:"fone",
									contribuinte:"indIEDest",
									inscricao_estadual:"IE",
									inscricao_suframa:"IEST",
									inscricao_municipal:"IM",
									email:"email"
								},false),
								retirada:Grupo.new(1,{
									cpf_cnpj:"CNPJ/CPF",
									cpf:"CPF",
									nome_razao_social:"xNome",
									logradouro:"xLgr",
									numero:"nro",
									complemento:"xCpl",
									bairro:"xBairro",
									codigo_municipio:"cMun",
									nome_municipio:"xMun",
									uf:"UF",
									cep:"CEP",
									codigo_pais:"cPais",
									nome_pais:"xPais",
									fone:"fone",
									email:"email",
									inscricao_estadual:"IE"
								},false),
								entrega:Grupo.new(1,{
									cpf_cnpj:"CNPJ/CPF",
									nome_razao_social:"xNome",
									logradouro:"xLgr",
									numero:"nro",
									complemento:"xCpl",
									bairro:"xBairro",
									codigo_municipio:"cMun",
									nome_municipio:"xMun",
									uf:"UF",
									cep:"CEP",
									codigo_pais:"cPais",
									nome_pais:"xPais",
									fone:"fone",
									email:"email",
									inscricao_estadual:"IE"
								},false),
								autorizacoes: Grupo.new(1,{
									cpf_cnpj:"CNPJ/CPF",
								},true),
								produtos: Grupo.new(1,{
									codigo_produto:"cProd",
									codigo_ean:"cEAN",
									descricao_produto:"xProd",
									ncm:"NCM",
									nve: Grupo.new(1,{codigo:"NVE"},true),
									cest:"CEST",
									indicador_escala:"indEscala",
									cnpj_fabricante:"CNPJFab",
									codigo_beneficiario:"cBenef",
									extipi:"EXTIPI",
									cfop:"CFOP",
									unidade_comercial:"uCom",
									quantidade:"qCom",
									preco:"vUnCom",
									codigo_ean_tributo:"cEANTrib",
									valor_frete:"vFrete",
									valor_seguro:"vSeg",
									valor_desconto:"vDesc",
									valor_outro:"vOutro",
									indicador_total:"indTot",
									importacoes: Grupo.new(1,{
										numero_documento:"nDI",
										data_registro_documento:"dDI",
										local_desembaraco:"xLocDesemb",
										uf_desembaraco:"UFDesemb",
										data_desembaraco:"dDesemb",
										tipo_transporte:"tpViaTransp",
										valor_afrmm:"vAFRMM",
										tipo_intermedio:"tpIntermedio",
										cnpj:"CNPJ",
										uf_terceiro:"UFTerceiro",
										codigo_exportador:"cExportador",
										adicoes: Grupo.new(1,{
											numero_adicao:"nAdicao",
											numero_sequencial_adicao:"nSeqAdic",
											codigo_fabricante:"cFabricante",
											valor_desconto:"vDescDI",
											numero_drawback:"nDraw"
										},true)
									},true),
									exportacoes: Grupo.new(1,{
										numero_drawback:"nDraw",
										numero_registro_exportacao:"nRE",
										chave_nota:"chNFe",
										quantidade:"qExport"
									},true),
									numero_pedido:"xPed",
									numero_item_pedido:"nItemPed",
									numero_fci:"nFCI",
									rastreamento: Grupo.new(1,{
										lote:"nLote",
										quantidade:"qLote",
										fabricacao:"dFab",
										validade:"dVal",
										codigo_agregacao:"cAgreg"
									},true),
									veiculos: Grupo.new(1,{
										tipo_operacao:"tpOp",
										chassi:"chassi",
										codigo_cor:"cCor",
										descricao_cor:"xCor",
										potencia:"pot",
										cilindradas:"cilin",
										peso_liquido:"pesoL",
										peso_bruto:"pesoB",
										serie:"nSerie",
										tipo_combustivel:"tpComb",
										numero_motor:"nMotor",
										capacidade_maxima_tracao_toneladas:"CMT",
										distancia_eixos:"dist",
										ano_modelo:"anoMod",
										ano_fabricacao:"anoFab",
										tipo_pintura:"tpPint",
										tipo_veiculo:"tpVeic",
										especie_veiculo:"espVeic",
										condicao_vin:"VIN",
										condicao_veiculo:"condVeic",
										codigo_marca_modelo:"cMod",
										codigo_cor_denatran:"cCordDENATRAN",
										lotacao:"lota",
										restricao:"tpRest"
									},false),
									medicamentos: Grupo.new(1,{
										codigo_produto_anvisa:"cProdANVISA",
										motivo_isencao:"xMotivoIsencao",
										preco_maximo_consumidor:"vPMC"
									},false),
									armas: Grupo.new(1,{
										tipo_arma:"tpArma",
										numero_serie:"nSerie",
										numero_cano:"nCano",
										descricao:"descr"
									},false),
									combustiveis:Grupo.new(1,{
										codigo_produto_anp:"cProdANP",
										descricao_anp:"descANP",
										percentual_glp:"pGLP",
										percentual_gnn:"pGNn",
										percentual_gni:"pGNi",
										valor_partida:"vPart",
										codif:"CODIF",
										qtd_combustivel_temperatura_ambiente:"qTemp",
										quantidade_cide:"qBCProd",
										aliquota_cide:"vAliqProd",
										numero_bico:"nBico",
										numero_bomba:"nBomba",
										numero_tanque:"nTanque",
										valor_encerrante_inicio:"vEncIni",
										valor_encerrante_fim:"vEncFin"
									},false),
									papel: Grupo.new(1,{
										nrecopi:"nRECOPI"
									},false),
									imposto: Grupo.new(1,{
										icms: Grupo.new(1,{
											origem:"orig",
											codigo:"CST/CSOSN",
											modalidade:"modBC",
											percentual_mva_substituicao:"pMVAST",
											percentual_reducao_substituicao:"pRedBCST",
											valor_icms_desonerado:"vICMSDeson",
											motivo_desoneracao:"motDesICMS",
											percentual_reducao:"pRedBC",
											percentual_diferimento:"pDif",
											percentual_reducao_efetiva:"pRedBCEfet",
											percentual_operacao_propria:"pBCOp",
											percuntal_credito:"pCredSN",
											modalidade_substituicao:"modBCST",
											percentual_substituicao_retido:"pST",
											valor_icms_substituto:"vICMSSubstituto"
										},false),
										ipi: Grupo.new(1,{
											cnpj_produtor:"CNPJProd",
											selo:"cSelo",
											quantidade_selo:"qSelo",
											codigo_enquadramento:"cEnq"
										},false),
										ii: Grupo.new(1,{
											valor_despesas_aduaneiras:"vDespAdu",
											valor_ii:"vII",
											valor_iof:"vIOF"
										},false),
										pis: Grupo.new(1,{
											codigo:"CST",
											aliquota_percentual:"pPIS",
											aliquota_reais:"vAliqProd"
										},false),
										pisst: Grupo.new(1,{
											aliquota_percentual:"pPIS",
											aliquota_reais:"vAliqProd"
										},false),
										cofins: Grupo.new(1,{
											codigo:"CST",
											aliquota_percentual:"pCOFINS",
											aliquota_reais:"vAliqProd"
										},false),
										cofinsst: Grupo.new(1,{
											aliquota_percentual:"pCOFINS",
											aliquota_reais:"vAliqProd"
										},false),
										issqn: Grupo.new(1,{
											aliquota:"vAliq",
											codigo_municipio_fato_gerador:"cMunFG",
											codigo_lista_servicos:"cListServ",
											valor_deducao:"vDeducao",
											valor_outro:"vOutro",
											valor_desconto_incondicionado:"vDescIncond",
											valor_desconto_condicionado:"vDescCond",
											valor_iss_retido:"vISSRet",
											indicador_iss:"indISS",
											codigo_servico:"cServico",
											codigo_municipio_incidencia:"cMun",
											codigo_pais:"cPais",
											numero_processo:"nProcesso",
											indicador_incentivo:"indIncentivo"
										},false),
									},false),
									informacoes_adicionais_produto:"infAdProd"
								},true),
								transporte: Grupo.new(1,{
									modalidade_frete:"modFrete",
									cpf_cnpj:"CNPJ/CPF",
									nome_razao_social:"xNome",
									inscricao_estadual:"IE",
									endereco:"xEnder",
									nome_municipio:"xMun",
									uf_transportador:"UF",
									valor_servico:"vServ",
									base_calculo_retencao_icms:"vBCRet",
									aliquota_retencao:"pICMSRet",
									cfop:"CFOP",
									codigo_municipio:"cMunFG",
									placa:"placa",
									uf:"UF",
									rntc:"RNTC",
									reboques: Grupo.new(1,{
										placa:"placa",
										uf:"UF",
										rntc:"RNTC",
									},true),
									vagao:"vagao",
									balsa:"balsa",
									volumes: Grupo.new(1,{
										quantidade_volumes:"qVol",
										especie_volumes:"esp",
										marca_volumes:"marca",
										numeracao_volumes:"nVol",
										peso_liquido:"pesoL",
										peso_bruto:"pesoB",
										lacres: Grupo.new(1,{
											numero_lacre:"nLacre"
										},true)
									},true)
								},false),
								cobranca: Grupo.new(1,{
									fatura:"nFat",
									valor_total:"vOrig",
									valor_desconto:"vDesc",
									valor_liquido:"vLiq",
									parcelas:Grupo.new(1,{
										numero_parcela:"nDup",
										vencimento:"dVenc",
										valor:"vDup"
									},true)
								},false),
								pagamento: Grupo.new(1,{
									detalhes: Grupo.new(1,{
										forma_pagamento:"indPag",
										meio_pagamento:"tPag",
										valor:"vPag",
										tipo_integracao:"tpIntegra",
										cnpj:"CNPJ",
										bandeira:"tBand",
										numero_autorizacao:"cAut"
									},true),
									troco:"vTroco"
								},false),
								informacoes_intermediador: Grupo.new(1,{
									cnpj:"CNPJ",
									identificador_intermediador:"idCadIntTran"
								},false),
								informacoes_adicionais: Grupo.new(1,{
									fisco:"infAdFisco",
									contribuinte:"infCpl",
									campos: Grupo.new(1,{
										campo:"xCampo",
										conteudo:"xTexto"
									},true),
									processos: Grupo.new(1,{
										numero_processo:"nProc",
										origem_processo:"indProc"
									},true)
								},false),
								exportacao: Grupo.new(1,{
									uf_saida_pais:"UFSaidaPais",
									local_embarque:"xLocExporta",
									local_despacho:"xLocDespacho"
								},false),
								compra: Grupo.new(1,{
									nota_empenho:"xNEmp",
									pedido:"xPed",
									contrato:"xCont"
								},false),
								cana: Grupo.new(1,{
									safra:"safra",
									mes_ano:"ref",
									dias: Grupo.new(1,{
										dia:"dia",
										quantidade:"qtde",
										quantidade_total_mes:"qTotMes",
										quantidade_total_anterior:"qTotAnt",
										quantidade_total_geral:"qTotGer"
									},true),
									deducoes: Grupo.new(1,{
										descricao:"xDed",
										valor_deducoes:"vDed",
										valor_fornecimentos:"vFor",
										valor_total_deducoes:"vTotDed",
										valor_liquido_fornecimentos:"vLiqFor"
									},false),
								},false),
								responsavel_tecnico: Grupo.new(1,{
									cnpj:"CNPJ",
									nome:"xContato",
									email:"email",
									fone:"fone",
									id_csrt:"idCSRT"
								},false)
							}
						}
					end

					def consultar_status_servico(mensagem)
						mensagem = {
							ambiente:"tpAmb",
							codigo_uf:"cUF",
							servico:"xServ"
						}
					end

					def consultar_retorno_autorizacao(mensagem)
						mensagem = {
							ambiente:"tpAmb",
							recibo:"nRec"
						}
					end

					def inutilizar_numeracao(mensagem)
						mensagem = {
							ambiente:"tpAmb",
							servico:"xServ",
							codigo_uf:"cUF",
							ano:"ano",
							cnpj:"CNPJ",
							modelo:"mod",
							serie:"serie",
							numeracao_inicial:"nNFIni",
							numeracao_final:"nNFFin",
							justificativa:"xJust"
						}
					end

					def nfe_distribuicao_dfe(mensagem)
						mensagem = {
							ambiente:"tpAmb",
							servico:"xServ",
							codigo_uf_autor:"cUFAutor",
							cnpj:"CNPJ",
							cpf:"CPF",
							ultimo_nsu:"ultNSU",
							consulta_nsu:"NSU",
							chave_nota:"chNFe"
						}
					end

					def consultar_protocolo(mensagem)
						mensagem = {
							ambiente:"tpAmb",
							servico:"xServ",
							chave_nota:"chNFe"
						}
					end

					def criar_carta_correcao(mensagem)
						mensagem = {
							lote:"idLote",
							codigo_orgao:"cOrgao",
							ambiente:"tpAmb",
							cnpj:"CNPJ",
							cpf:"CPF",
							chave_nota:"chNFe",
							tipo_evento:"tpEvento",
							numero_sequencial_evento:"nSeqEvento",
							correcao:"xCorrecao",
						}
					end

					def confirmacao_da_operacao(mensagem)
						mensagem = {
							lote:"idLote",
							codigo_orgao:"cOrgao",
							ambiente:"tpAmb",
							cnpj:"CNPJ",
							cpf:"CPF",
							chave_nota:"chNFe",
							tipo_evento:"tpEvento",
							numero_sequencial_evento:"nSeqEvento"
						}
					end

					def ciencia_da_operacao(mensagem)
						mensagem = {
							lote:"idLote",
							codigo_orgao:"cOrgao",
							ambiente:"tpAmb",
							cnpj:"CNPJ",
							cpf:"CPF",
							chave_nota:"chNFe",
							tipo_evento:"tpEvento",
							numero_sequencial_evento:"nSeqEvento"
						}
					end

					def desconhecimento_da_operacao(mensagem)
						mensagem = {
							lote:"idLote",
							codigo_orgao:"cOrgao",
							ambiente:"tpAmb",
							cnpj:"CNPJ",
							cpf:"CPF",
							chave_nota:"chNFe",
							tipo_evento:"tpEvento",
							numero_sequencial_evento:"nSeqEvento"
						}
					end

					def operacao_nao_realizada(mensagem)
						mensagem = {
							lote:"idLote",
							codigo_orgao:"cOrgao",
							ambiente:"tpAmb",
							cnpj:"CNPJ",
							cpf:"CPF",
							chave_nota:"chNFe",
							tipo_evento:"tpEvento",
							numero_sequencial_evento:"nSeqEvento"
						}
					end

					def emissao_contingencia(mensagem)
						mensagem = {
							lote:"idLote",
							codigo_orgao:"cOrgao",
							ambiente:"tpAmb",
							cnpj:"CNPJ",
							cpf:"CPF",
							chave_nota:"chNFe",
							tipo_evento:"tpEvento",
							numero_sequencial_evento:"nSeqEvento",
							codigo_orgao_autor:"cOrgaoAutor",
							tipo_autor:"tpAutor",
							versao_aplicacao:"verAplic",
							data_emissao:"cOrgaoAutor",
							tipo_nota:"cOrgaoAutor",
							ie:"cOrgaoAutor",
							destinatario:{
								uf:"UF",
								cnpj:"CNPJ",
								cpf:"CPF",
								identificador_estrangeiro:"idEstrangeiro",
								inscricao_estadual:"IE",
								valor_nota:"vNF",
								valor_icms:"vICMS",
								valor_icms_substituicao:"vST",
							},
						}
					end

					def cancelar_nota_substituicao(mensagem)
						mensagem = {
							lote:"idLote",
							codigo_orgao:"cOrgao",
							ambiente:"tpAmb",
							cnpj:"CNPJ",
							cpf:"CPF",
							chave_nota:"chNFe",
							tipo_evento:"tpEvento",
							numero_sequencial_evento:"nSeqEvento",
							codigo_orgao_autor:"cOrgaoAutor",
							tipo_autor:"tpAutor",
							versao_aplicacao:"verAplic",
							protocolo:"nProt",
							justificativa:"xJust",
							chave_nota_referenciada:"chNFeRef"
						}
					end

					def cancelar_nota(mensagem)
						mensagem = {
							lote:"idLote",
							codigo_orgao:"cOrgao",
							ambiente:"tpAmb",
							cnpj:"CNPJ",
							cpf:"CPF",
							chave_nota:"chNFe",
							tipo_evento:"tpEvento",
							numero_sequencial_evento:"nSeqEvento",
							protocolo:"nProt",
							justificativa:"xJust",
						}
					end

					def prorrogar_prazo_1(mensagem)
						mensagem = {
							lote:"idLote",
							codigo_orgao:"cOrgao",
							ambiente:"tpAmb",
							cnpj:"CNPJ",
							cpf:"CPF",
							chave_nota:"chNFe",
							tipo_evento:"tpEvento",
							numero_sequencial_evento:"nSeqEvento",
							protocolo:"nProt",
							itens_pedido:[{
								numero_item:"numItem",
								qtd_item:"qtdeItem"
							}]
						}
					end

					def prorrogar_prazo_2(mensagem)
						mensagem = {
							lote:"idLote",
							codigo_orgao:"cOrgao",
							ambiente:"tpAmb",
							cnpj:"CNPJ",
							cpf:"CPF",
							chave_nota:"chNFe",
							tipo_evento:"tpEvento",
							numero_sequencial_evento:"nSeqEvento",
							protocolo:"nProt",
							itens_pedido:[{
								numero_item:"numItem",
								qtd_item:"qtdeItem"
							}]
						}
					end

					def ator_interessado(mensagem)
						mensagem = {
							lote:"idLote",
							codigo_orgao:"cOrgao",
							ambiente:"tpAmb",
							cnpj:"CNPJ",
							cpf:"CPF",
							chave_nota:"chNFe",
							tipo_evento:"tpEvento",
							numero_sequencial_evento:"nSeqEvento",
							codigo_orgao_autor:"cOrgaoAutor",
							tipo_autor:"tpAutor",
							versao_aplicacao:"verAplic",
							data_emissao:"cOrgaoAutor",
							tipo_nota:"cOrgaoAutor",
							ie:"cOrgaoAutor",
							autorizacoes:[{
								cnpj:"CNPJ",
								cpf:"CPF"
							}],
							tipo_autorizacao:"tpAutorizacao",
							condicao_uso:"xCondUso"
						}
					end

					def cancelamento_prazo_1(mensagem)
					end

					def cancelamento_prazo_2(mensagem)
					end

					private

					def cria_mapa_tags
						@mapa_tags = JSON.parse(File.open("#{__dir__}/mapa_tags.json",'r').read);
					end

				end

			end

		end

	end

end