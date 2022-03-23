require 'pry'

module BRNF

	class Validator
		
		def valida_autorizar_nota(xml)
			remove_ie_retirada_pessoa_fisica_autorizar_nota(xml)
			remove_ie_entrega_pessoa_fisica_autorizar_nota(xml)
			nfref_filho_unico(xml)
			regra_e16a_10(xml)
			regra_e16a_20(xml)
			regra_e16a_30(xml)
			regra_e17_30(xml)
			regra_x25a_10(xml)
			regra_x25b_10(xml)
			regra_e18_10(xml)
			xml
		end

		def valida_consultar_status_servico(xml)
			corrige_versao_consultar_status_servico(xml)
			xml
		end

		def valida_consultar_retorno_autorizacao(xml)
			corrige_versao_cons_reci_nfe_consultar_retorno_autorizacao(xml)
			xml
		end

		def valida_inutilizar_numeracao(xml)
			xml
		end

		def valida_nfe_distribuicao_dfe(xml)
			corrige_versao_dist_dfe_int_nfe_distribuicao_dfe(xml)
			xml
		end

		def valida_consultar_protocolo(xml)
			corrige_versao_cons_sit_nfe_consultar_protocolo(xml)
			xml
		end

		def valida_criar_carta_correcao(xml)
			xml
		end

		def valida_confirmacao_da_operacao(xml)
			xml
		end

		def valida_ciencia_da_operacao(xml)
			xml
		end

		def valida_desconhecimento_da_operacao(xml)
			xml
		end

		def valida_operacao_nao_realizada(xml)
			xml
		end

		def valida_emissao_contingencia(xml)
			xml
		end

		def valida_cancelar_nota_substituicao(xml)
			xml
		end

		def valida_cancelar_nota(xml)
			xml
		end

		def valida_prorrogar_prazo_1(xml)
			corrige_tipo_evento_prorrogar_prazo_1(xml)
			corrige_versao_env_evento_prorrogar_prazo_1(xml)
			corrige_desc_evento_prorrogar_prazo_1(xml)
			corrige_nprot_prorrogar_prazo_1(xml)
			corrige_qtde_item_prorrogar_prazo_1(xml)
			xml
		end

		def valida_prorrogar_prazo_2(xml)
			corrige_tipo_evento_prorrogar_prazo_2(xml)
			corrige_versao_env_evento_prorrogar_prazo_2(xml)
			corrige_desc_evento_prorrogar_prazo_2(xml)
			corrige_nprot_prorrogar_prazo_2(xml)
			corrige_qtde_item_prorrogar_prazo_2(xml)
			xml
		end

		def valida_ator_interessado(xml)
			xml
		end

		def valida_cancelamento_prazo_1(xml)
			corrige_tipo_evento_cancelamento_prazo_1(xml)
			corrige_versao_env_evento_cancelamento_prazo_1(xml)
			corrige_desc_evento_cancelamento_prazo_1(xml)
			corrige_nprot_cancelamento_prazo_1(xml)
			corrige_qtde_item_cancelamento_prazo_1(xml)
			xml
		end

		def valida_cancelamento_prazo_2(xml)
			corrige_tipo_evento_cancelamento_prazo_2(xml)
			corrige_versao_env_evento_cancelamento_prazo_2(xml)
			corrige_desc_evento_cancelamento_prazo_2(xml)
			corrige_nprot_cancelamento_prazo_2(xml)
			corrige_qtde_item_cancelamento_prazo_2(xml)
			xml
		end

		def valida_consultar_cadastro(xml)
			corrige_versao_cons_cad_consultar_cadastro(xml)
			xml
		end

		private

			def corrige_versao_cons_cad_consultar_cadastro(xml)
				versao = xml.xpath("//xs:ConsCad//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
				versao&.content = '2.00'
			end

			def corrige_versao_dist_dfe_int_nfe_distribuicao_dfe(xml)
				versao = xml.xpath("//xs:distDFeInt//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
				versao&.content = '1.01'
			end

			def corrige_versao_cons_sit_nfe_consultar_protocolo(xml)
				versao = xml.xpath("//xs:consSitNFe//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
				versao&.content = '4.00'
			end

			def corrige_versao_cons_reci_nfe_consultar_retorno_autorizacao(xml)
				versao = xml.xpath("//xs:consReciNFe//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
				versao&.content = '4.00'
			end

			def corrige_tipo_evento_cancelamento_prazo_1(xml)
				tp_evento = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:tpEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
				tp_evento&.content = '111502'
			end

			def corrige_versao_env_evento_cancelamento_prazo_1(xml)
			  versao = xml.xpath("//xs:envEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
				versao&.content = '1.00'
			end

			def corrige_desc_evento_cancelamento_prazo_1(xml)
				desc_evento = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe")
				desc_evento[1..-1].remove if !desc_evento[1..-1].nil?
				desc_evento.first&.content = 'Pedido de Prorrogacao'
			end

			def corrige_nprot_cancelamento_prazo_1(xml)
				nprot = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:nProt","xs" => "http://www.portalfiscal.inf.br/nfe")
				nprot[1..-1].remove if !nprot[1..-1].nil?
			end

			def corrige_qtde_item_cancelamento_prazo_1(xml)
				qtde_item = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:qtdeItem","xs" => "http://www.portalfiscal.inf.br/nfe")
				qtde_item[0..-2].remove if !qtde_item[0..-2].nil?
			end

			def corrige_tipo_evento_cancelamento_prazo_2(xml)
				tp_evento = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:tpEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
				tp_evento&.content = '111503'
			end

			def corrige_versao_env_evento_cancelamento_prazo_2(xml)
			  versao = xml.xpath("//xs:envEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
				versao&.content = '1.00'
			end

			def corrige_desc_evento_cancelamento_prazo_2(xml)
				desc_evento = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe")
				desc_evento[1..-1].remove if !desc_evento[1..-1].nil?
				desc_evento.first&.content = 'Pedido de Prorrogacao'
			end

			def corrige_nprot_cancelamento_prazo_2(xml)
				nprot = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:nProt","xs" => "http://www.portalfiscal.inf.br/nfe")
				nprot[1..-1].remove if !nprot[1..-1].nil?
			end

			def corrige_qtde_item_cancelamento_prazo_2(xml)
				qtde_item = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:qtdeItem","xs" => "http://www.portalfiscal.inf.br/nfe")
				qtde_item[0..-2].remove if !qtde_item[0..-2].nil?
			end

			def corrige_tipo_evento_prorrogar_prazo_2(xml)
				tp_evento = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:tpEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
				tp_evento&.content = '111501'
			end

			def corrige_versao_env_evento_prorrogar_prazo_2(xml)
			  versao = xml.xpath("//xs:envEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
				versao&.content = '1.00'
			end

			def corrige_desc_evento_prorrogar_prazo_2(xml)
				desc_evento = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe")
				desc_evento[1..-1].remove if !desc_evento[1..-1].nil?
				desc_evento.first&.content = 'Pedido de Prorrogacao'
			end

			def corrige_nprot_prorrogar_prazo_2(xml)
				nprot = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:nProt","xs" => "http://www.portalfiscal.inf.br/nfe")
				nprot[1..-1].remove if !nprot[1..-1].nil?
			end

			def corrige_qtde_item_prorrogar_prazo_2(xml)
				qtde_item = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:qtdeItem","xs" => "http://www.portalfiscal.inf.br/nfe")
				qtde_item[0..-2].remove if !qtde_item[0..-2].nil?
			end

			def corrige_tipo_evento_prorrogar_prazo_1(xml)
				tp_evento = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:tpEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
				tp_evento&.content = '111500'
			end

			def corrige_versao_env_evento_prorrogar_prazo_1(xml)
			  versao = xml.xpath("//xs:envEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
				versao&.content = '1.00'
			end

			def corrige_desc_evento_prorrogar_prazo_1(xml)
				desc_evento = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe")
				desc_evento[1..-1].remove if !desc_evento[1..-1].nil?
				desc_evento.first&.content = 'Pedido de Prorrogacao'
			end

			def corrige_nprot_prorrogar_prazo_1(xml)
				nprot = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:nProt","xs" => "http://www.portalfiscal.inf.br/nfe")
				nprot[1..-1].remove if !nprot[1..-1].nil?
			end

			def corrige_qtde_item_prorrogar_prazo_1(xml)
				qtde_item = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:qtdeItem","xs" => "http://www.portalfiscal.inf.br/nfe")
				qtde_item[0..-2].remove if !qtde_item[0..-2].nil?
			end

			def corrige_versao_consultar_status_servico(xml)
				versao = xml.xpath("//xs:consStatServ//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
				versao&.content = '4.00'
			end

			def remove_ie_retirada_pessoa_fisica_autorizar_nota(xml)
				cpf = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:retirada//xs:CPF","xs" => "http://www.portalfiscal.inf.br/nfe").first 
				ie = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:retirada//xs:IE","xs" => "http://www.portalfiscal.inf.br/nfe").first
				ie.remove if !ie.nil? and !cpf.nil?
			end
			
			def remove_ie_entrega_pessoa_fisica_autorizar_nota(xml)
				cpf = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:entrega//xs:CPF","xs" => "http://www.portalfiscal.inf.br/nfe").first
				ie = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:entrega//xs:IE","xs" => "http://www.portalfiscal.inf.br/nfe").first
				ie.remove if !ie.nil? and !cpf.nil?
			end

			def nfref_filho_unico(xml)
				nfref = xml.xpath("//xs:enviNFe//xs:NFe//xs:ide//xs:NFref","xs" => "http://www.portalfiscal.inf.br/nfe").first
				if !nfref.nil?
					nfref.children = nfref.elements.first
				end
			end

			def regra_e16a_10(xml)
				indicador_destinatario = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:indIEDest","xs" => "http://www.portalfiscal.inf.br/nfe").first
				modelo = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:mod","xs" => "http://www.portalfiscal.inf.br/nfe").first
				
				if modelo&.content == '65'
					indicador_destinatario&.content = "9"
				end
			end

			def regra_x25a_10(xml)
				vagao = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:vagao","xs" => "http://www.portalfiscal.inf.br/nfe").first
				modelo = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:mod","xs" => "http://www.portalfiscal.inf.br/nfe").first
				
				if modelo&.content == "65"
					vagao&.remove unless vagao.nil?
				end
			end

			def regra_x25b_10(xml)
				balsa = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:balsa","xs" => "http://www.portalfiscal.inf.br/nfe").first
				modelo = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:mod","xs" => "http://www.portalfiscal.inf.br/nfe").first
				
				if modelo&.content == "65"
					balsa&.remove unless balsa.nil?
				end
			end

			def regra_e16a_20(xml)
				indicador_destinatario = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:indIEDest","xs" => "http://www.portalfiscal.inf.br/nfe").first
				indicador_operacao = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:idDest","xs" => "http://www.portalfiscal.inf.br/nfe").first
				modelo = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:mod","xs" => "http://www.portalfiscal.inf.br/nfe").first

				if modelo&.content == "55"
					if indicador_operacao&.content == "3"
						indicador_destinatario&.content = "9"
					end
				end
			end

			def regra_e16a_30(xml)
				indicador_destinatario = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:indIEDest","xs" => "http://www.portalfiscal.inf.br/nfe").first
				indicador_operacao = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:idDest","xs" => "http://www.portalfiscal.inf.br/nfe").first
				modelo = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:mod","xs" => "http://www.portalfiscal.inf.br/nfe").first

				if modelo&.content == "55"
					if indicador_operacao&.content == "2"
						indicador_destinatario&.content = /[19]{1}/.random_example
					end
				end
			end

			def regra_e17_30(xml)
				modelo = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:mod","xs" => "http://www.portalfiscal.inf.br/nfe").first
				destinatario_indicador = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:indIEDest","xs" => "http://www.portalfiscal.inf.br/nfe").first
				destinatario_inscricao_estadual = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:IE","xs" => "http://www.portalfiscal.inf.br/nfe").first

				if modelo&.content == '55' and !destinatario_indicador.nil? and destinatario_indicador&.content == "2"
					destinatario_inscricao_estadual.remove if !destinatario_inscricao_estadual.nil?
				end
			end

			def regra_e18_10(xml)
				inscricao_suframa = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:ISUF","xs" => "http://www.portalfiscal.inf.br/nfe").first
				modelo = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:mod","xs" => "http://www.portalfiscal.inf.br/nfe").first

				if modelo&.content == '65' and !inscricao_suframa.nil?
					inscricao_suframa&.remove
				end

			end

	end

end