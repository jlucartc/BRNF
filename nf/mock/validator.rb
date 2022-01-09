require 'pry'

module NF

	module Mock

		class Validator

			TAGS = ["E","G","CE","CG","Raiz"]
			ATRIBUTOS = ["A"]
			OPCIONAIS = ["GO","CGO"]

			def initialize
				@mapa_tags = cria_mapa_tags
			end

			def verifica_autorizacao(xml)
				nfref_filho_unico(xml)
				regra_e16a_10(xml)
				regra_e16a_20(xml)
				regra_e16a_30(xml)
				regra_e17_30(xml)
				regra_x25a_10(xml)
				regra_x25b_10(xml)
				#regra_ie_transp(xml)
				#regra_ie_dest(xml)
				regra_e18_10(xml)
				xml
			end

			def verifica_inutilizacao(xml)
				xml
			end

			def verifica_carta_correcao(xml)
				corrige_tipo_evento_carta_correcao(xml)
				corrige_versao_carta_correcao(xml)
				corrige_ver_evento_carta_correcao(xml)
				corrige_versao_det_evento_carta_correcao(xml)
				corrige_descricao_carta_correcao(xml)
				corrige_condicao_uso_carta_correcao(xml)
				corrige_versao_env_evento_carta_correcao(xml)
				remove_num_item_carta_correcao(xml)
				remove_c_orgao_autor_carta_correcao(xml)
				remove_tipo_autor_carta_correcao(xml)
				remove_ver_aplic_carta_correcao(xml)
				remove_nprot_carta_correcao(xml)
				remove_xjust_carta_correcao(xml)
				remove_chnferef_carta_correcao(xml)
				remove_dhemi_carta_correcao(xml)
				remove_tpnf_carta_correcao(xml)
				remove_ie_carta_correcao(xml)
				remove_dest_carta_correcao(xml)
				remove_vnf_carta_correcao(xml)
				remove_vicms_carta_correcao(xml)
				remove_vst_carta_correcao(xml)
				remove_item_pedido_carta_correcao(xml)
				remove_qtde_item_carta_correcao(xml)
				remove_aut_xml_carta_correcao(xml)
				remove_tp_autorizacao_carta_correcao(xml)
				xml
			end

			def verifica_cancelar_nota_substituicao(xml)
				corrige_versao_env_evento_cancelar_nota_substituicao(xml)
				corrige_versao_det_evento_cancelar_nota_substituicao(xml)
				corrige_ver_evento_cancelar_nota_substituicao(xml)
				corrige_descricao_cancelar_nota_substituicao(xml)
				corrige_tipo_autor_cancelar_nota_substituicao(xml)
				corrige_tipo_evento_cancelar_nota_substituicao(xml)
				remove_num_item_cancelar_nota_substituicao(xml)
				remove_dhemi_cancelar_nota_substituicao(xml)
				remove_tpnf_cancelar_nota_substituicao(xml)
				remove_ie_cancelar_nota_substituicao(xml)
				remove_dest_cancelar_nota_substituicao(xml)
				remove_vnf_cancelar_nota_substituicao(xml)
				remove_vicms_cancelar_nota_substituicao(xml)
				remove_vst_cancelar_nota_substituicao(xml)
				remove_item_pedido_cancelar_nota_substituicao(xml)
				remove_qtde_item_cancelar_nota_substituicao(xml)
				remove_xjust_cancelar_nota_substituicao(xml)
				remove_c_orgao_autor_cancelar_nota_substituicao(xml)
				remove_ver_aplic_cancelar_nota_substituicao(xml)
				remove_nprot_cancelar_nota_substituicao(xml)
				remove_aut_xml_cancelar_nota_substituicao(xml)
				remove_tp_autorizacao_cancelar_nota_substituicao(xml)
				remove_xconduso_cancelar_nota_substituicao(xml)
				remove_xcorrecao_cancelar_nota_substituicao(xml)
				corrige_nprot_cancelar_nota_substituicao(xml)
				corrige_xjust_cancelar_nota_substituicao(xml)
				corrige_chnferef_cancelar_nota_substituicao(xml)
				xml
			end

			def verifica_cancelar_nota(xml)
				corrige_tipo_evento_cancelar_nota(xml)
				corrige_ver_evento_cancelar_nota(xml)
				corrige_versao_det_evento_cancelar_nota(xml)
				corrige_versao_env_evento_cancelar_nota(xml)
				corrige_descricao_cancelar_nota(xml)
				remove_num_item_cancelar_nota(xml)
				remove_c_orgao_autor_cancelar_nota(xml)
				remove_tipo_autor_cancelar_nota(xml)
				remove_ver_aplic_cancelar_nota(xml)
				remove_chnferef_cancelar_nota(xml)
				remove_xcorrecao_cancelar_nota(xml)
				remove_xconduso_cancelar_nota(xml)
				remove_xjust_cancelar_nota(xml)
				remove_dhemi_cancelar_nota(xml)
				remove_tpnf_cancelar_nota(xml)
				remove_ie_cancelar_nota(xml)
				remove_dest_cancelar_nota(xml)
				remove_vnf_cancelar_nota(xml)
				remove_vicms_cancelar_nota(xml)
				remove_vst_cancelar_nota(xml)
				remove_item_pedido_cancelar_nota(xml)
				remove_qtde_item_cancelar_nota(xml)
				remove_aut_xml_cancelar_nota(xml)
				remove_tp_autorizacao_cancelar_nota(xml)
				remove_nprot_cancelar_nota(xml)
				xml
			end

			def verifica_consultar_status_servico(xml)
				corrige_versao_consultar_status_servico(xml)
				xml
			end

			def verifica_prorrogar_prazo_1(xml)
				corrige_tipo_evento_prorrogar_prazo_1(xml)
				corrige_versao_env_evento_prorrogar_prazo_1(xml)
				corrige_desc_evento_prorrogar_prazo_1(xml)
				corrige_nprot_prorrogar_prazo_1(xml)
				corrige_qtde_item_prorrogar_prazo_1(xml)
				xml
			end

			def verifica_prorrogar_prazo_2(xml)
				corrige_tipo_evento_prorrogar_prazo_2(xml)
				corrige_versao_env_evento_prorrogar_prazo_2(xml)
				corrige_desc_evento_prorrogar_prazo_2(xml)
				corrige_nprot_prorrogar_prazo_2(xml)
				corrige_qtde_item_prorrogar_prazo_2(xml)
				xml
			end

			def verifica_ator_interessado(xml)
				remove_n_prot_ator_interessado(xml)
				remove_x_just_ator_interessado(xml)
				remove_ch_nfe_ref_ator_interessado(xml)
				remove_x_correcao_ator_interessado(xml)
				remove_dh_emi_ator_interessado(xml)
				remove_tp_nf_ator_interessado(xml)
				remove_ie_ator_interessado(xml)
				remove_dest_ator_interessado(xml)
				remove_v_nf_ator_interessado(xml)
				remove_v_icms_ator_interessado(xml)
				remove_v_st_ator_interessado(xml)
				remove_item_pedido_ator_interessado(xml)
				remove_qtde_item_ator_interessado(xml)
				corrige_desc_evento_ator_interessado(xml)
				corrige_c_orgao_autor_ator_interessado(xml)
				corrige_tp_autor_ator_interessado(xml)
				corrige_ver_aplic_ator_interessado(xml)
				corrige_x_cond_uso_ator_interessado(xml)
				corrige_versao_env_evento_ator_interessado(xml)
				corrige_tp_evento_ator_interessado(xml)
				corrige_ver_evento_ator_interessado(xml)
				corrige_versao_det_evento_ator_interessado(xml)
				remove_num_item_ator_interessado(xml)
				xml
			end

			def verifica_confirmacao_da_operacao(xml)
				corrige_versao_env_evento_confirmacao_da_operacao(xml)
				corrige_tp_evento_confirmacao_da_operacao(xml)
				corrige_ver_evento_confirmacao_da_operacao(xml)
				corrige_versao_det_evento_confirmacao_da_operacao(xml)
				corrige_x_just_confirmacao_da_operacao(xml)
				remove_num_item_det_evento_confirmacao_da_operacao(xml)
				corrige_desc_evento_confirmacao_da_operacao(xml)
				remove_c_orgao_autor_confirmacao_da_operacao(xml)
				remove_tp_autor_confirmacao_da_operacao(xml)
				remove_ver_aplic_confirmacao_da_operacao(xml)
				remove_n_prot_confirmacao_da_operacao(xml)
				remove_ch_nfe_ref_confirmacao_da_operacao(xml)
				remove_x_correcao_confirmacao_da_operacao(xml)
				remove_x_cond_uso_confirmacao_da_operacao(xml)
				remove_dh_emi_confirmacao_da_operacao(xml)
				remove_tp_nf_confirmacao_da_operacao(xml)
				remove_ie_confirmacao_da_operacao(xml)
				remove_dest_confirmacao_da_operacao(xml)
				remove_v_nf_confirmacao_da_operacao(xml)
				remove_v_icms_confirmacao_da_operacao(xml)
				remove_v_st_confirmacao_da_operacao(xml)
				remove_item_pedido_confirmacao_da_operacao(xml)
				remove_qtde_item_confirmacao_da_operacao(xml)
				remove_aut_xml_confirmacao_da_operacao(xml)
				remove_tp_autorizacao_confirmacao_da_operacao(xml)
				xml
			end

			def verifica_ciencia_da_operacao(xml)
				corrige_versao_env_evento_ciencia_da_operacao(xml)
				corrige_tp_evento_ciencia_da_operacao(xml)
				corrige_ver_evento_ciencia_da_operacao(xml)
				corrige_versao_det_evento_ciencia_da_operacao(xml)
				corrige_x_just_ciencia_da_operacao(xml)
				remove_num_item_det_evento_ciencia_da_operacao(xml)
				corrige_desc_evento_ciencia_da_operacao(xml)
				remove_c_orgao_autor_ciencia_da_operacao(xml)
				remove_tp_autor_ciencia_da_operacao(xml)
				remove_ver_aplic_ciencia_da_operacao(xml)
				remove_n_prot_ciencia_da_operacao(xml)
				remove_ch_nfe_ref_ciencia_da_operacao(xml)
				remove_x_correcao_ciencia_da_operacao(xml)
				remove_x_cond_uso_ciencia_da_operacao(xml)
				remove_dh_emi_ciencia_da_operacao(xml)
				remove_tp_nf_ciencia_da_operacao(xml)
				remove_ie_ciencia_da_operacao(xml)
				remove_dest_ciencia_da_operacao(xml)
				remove_v_nf_ciencia_da_operacao(xml)
				remove_v_icms_ciencia_da_operacao(xml)
				remove_v_st_ciencia_da_operacao(xml)
				remove_item_pedido_ciencia_da_operacao(xml)
				remove_qtde_item_ciencia_da_operacao(xml)
				remove_aut_xml_ciencia_da_operacao(xml)
				remove_tp_autorizacao_ciencia_da_operacao(xml)
				xml
			end

			def verifica_desconhecimento_da_operacao(xml)
				corrige_versao_env_evento_desconhecimento_da_operacao(xml)
				corrige_tp_evento_desconhecimento_da_operacao(xml)
				corrige_ver_evento_desconhecimento_da_operacao(xml)
				corrige_versao_det_evento_desconhecimento_da_operacao(xml)
				corrige_x_just_desconhecimento_da_operacao(xml)
				remove_num_item_det_evento_desconhecimento_da_operacao(xml)
				corrige_desc_evento_desconhecimento_da_operacao(xml)
				remove_c_orgao_autor_desconhecimento_da_operacao(xml)
				remove_tp_autor_desconhecimento_da_operacao(xml)
				remove_ver_aplic_desconhecimento_da_operacao(xml)
				remove_n_prot_desconhecimento_da_operacao(xml)
				remove_ch_nfe_ref_desconhecimento_da_operacao(xml)
				remove_x_correcao_desconhecimento_da_operacao(xml)
				remove_x_cond_uso_desconhecimento_da_operacao(xml)
				remove_dh_emi_desconhecimento_da_operacao(xml)
				remove_tp_nf_desconhecimento_da_operacao(xml)
				remove_ie_desconhecimento_da_operacao(xml)
				remove_dest_desconhecimento_da_operacao(xml)
				remove_v_nf_desconhecimento_da_operacao(xml)
				remove_v_icms_desconhecimento_da_operacao(xml)
				remove_v_st_desconhecimento_da_operacao(xml)
				remove_item_pedido_desconhecimento_da_operacao(xml)
				remove_qtde_item_desconhecimento_da_operacao(xml)
				remove_aut_xml_desconhecimento_da_operacao(xml)
				remove_tp_autorizacao_desconhecimento_da_operacao(xml)
				xml
			end

			def verifica_operacao_nao_realizada(xml)
				corrige_versao_env_evento_operacao_nao_realizada(xml)
				corrige_tp_evento_operacao_nao_realizada(xml)
				corrige_ver_evento_operacao_nao_realizada(xml)
				corrige_versao_det_evento_operacao_nao_realizada(xml)
				corrige_x_just_operacao_nao_realizada(xml)
				remove_num_item_det_evento_operacao_nao_realizada(xml)
				corrige_desc_evento_operacao_nao_realizada(xml)
				remove_c_orgao_autor_operacao_nao_realizada(xml)
				remove_tp_autor_operacao_nao_realizada(xml)
				remove_ver_aplic_operacao_nao_realizada(xml)
				remove_n_prot_operacao_nao_realizada(xml)
				remove_ch_nfe_ref_operacao_nao_realizada(xml)
				remove_x_correcao_operacao_nao_realizada(xml)
				remove_x_cond_uso_operacao_nao_realizada(xml)
				remove_dh_emi_operacao_nao_realizada(xml)
				remove_tp_nf_operacao_nao_realizada(xml)
				remove_ie_operacao_nao_realizada(xml)
				remove_dest_operacao_nao_realizada(xml)
				remove_v_nf_operacao_nao_realizada(xml)
				remove_v_icms_operacao_nao_realizada(xml)
				remove_v_st_operacao_nao_realizada(xml)
				remove_item_pedido_operacao_nao_realizada(xml)
				remove_qtde_item_operacao_nao_realizada(xml)
				remove_aut_xml_operacao_nao_realizada(xml)
				remove_tp_autorizacao_operacao_nao_realizada(xml)
				xml
			end

			def verifica_emissao_contingencia(xml)
				corrige_tipo_autor_emissao_em_contingencia(xml)
				corrige_n_prot_emissao_em_contingencia(xml)
				remove_ch_nfe_ref_emissao_em_contingencia(xml)
				remove_x_correcao_emissao_em_contingencia(xml)
				remove_x_cond_uso_emissao_em_contingencia(xml)
				remove_x_just_emissao_em_contingencia(xml)
				corrige_versao_env_evento_emissao_em_contingencia(xml)
				corrige_tp_evento_emissao_em_contingencia(xml)
				corrige_ver_evento_emissao_em_contingencia(xml)
				corrige_versao_det_evento_emissao_em_contingencia(xml)
				corrige_num_item_det_evento_emissao_em_contingencia(xml)
				corrige_desc_evento_emissao_em_contingencia(xml)
				corrige_c_orgao_autor_emissao_em_contingencia(xml)
				corrige_ver_aplic_emissao_em_contingencia(xml)
				remove_item_pedido_emissao_em_contingencia(xml)
				remove_qtde_item_emissao_em_contingencia(xml)
				remove_aut_xml_emissao_em_contingencia(xml)
				remove_tp_autorizacao_emissao_em_contingencia(xml)
				corrige_c_orgao_emissao_em_contingencia(xml)
				xml
			end

			def verifica_cancelamento_prazo_1(xml)
				corrige_tipo_evento_cancelamento_prazo_1(xml)
				corrige_versao_env_evento_cancelamento_prazo_1(xml)
				corrige_desc_evento_cancelamento_prazo_1(xml)
				corrige_nprot_cancelamento_prazo_1(xml)
				corrige_qtde_item_cancelamento_prazo_1(xml)
				xml
			end

			def verifica_cancelamento_prazo_2(xml)
				corrige_tipo_evento_cancelamento_prazo_2(xml)
				corrige_versao_env_evento_cancelamento_prazo_2(xml)
				corrige_desc_evento_cancelamento_prazo_2(xml)
				corrige_nprot_cancelamento_prazo_2(xml)
				corrige_qtde_item_cancelamento_prazo_2(xml)
				xml
			end

			def verifica_consultar_retorno_autorizacao(xml)
				corrige_versao_cons_reci_nfe_consultar_retorno_autorizacao(xml)
				xml
			end

			def verifica_consultar_protocolo(xml)
				corrige_versao_cons_sit_nfe_consultar_protocolo(xml)
				xml
			end

			private

				def corrige_versao_cons_sit_nfe_consultar_protocolo(xml)
					versao = xml.xpath("//xs:consSitNFe//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
					versao.content = '4.00'
				end

				def corrige_versao_cons_reci_nfe_consultar_retorno_autorizacao(xml)
					versao = xml.xpath("//xs:consReciNFe//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
					versao.content = '4.00'
				end

				def corrige_tipo_evento_cancelamento_prazo_1(xml)
					tp_evento = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:tpEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
					tp_evento.content = '111502'
				end

				def corrige_versao_env_evento_cancelamento_prazo_1(xml)
				  versao = xml.xpath("//xs:envEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
					versao.content = '1.00'
				end

				def corrige_desc_evento_cancelamento_prazo_1(xml)
					desc_evento = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe")
					desc_evento[1..-1].remove
					desc_evento.first.content = 'Pedido de Prorrogacao'
				end

				def corrige_nprot_cancelamento_prazo_1(xml)
					nprot = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:nProt","xs" => "http://www.portalfiscal.inf.br/nfe")
					nprot[1..-1].remove
				end

				def corrige_qtde_item_cancelamento_prazo_1(xml)
					qtde_item = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:qtdeItem","xs" => "http://www.portalfiscal.inf.br/nfe")
					qtde_item[0..-2].remove
				end

				def corrige_tipo_evento_cancelamento_prazo_2(xml)
					tp_evento = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:tpEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
					tp_evento.content = '111503'
				end

				def corrige_versao_env_evento_cancelamento_prazo_2(xml)
				  versao = xml.xpath("//xs:envEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
					versao.content = '1.00'
				end

				def corrige_desc_evento_cancelamento_prazo_2(xml)
					desc_evento = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe")
					desc_evento[1..-1].remove
					desc_evento.first.content = 'Pedido de Prorrogacao'
				end

				def corrige_nprot_cancelamento_prazo_2(xml)
					nprot = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:nProt","xs" => "http://www.portalfiscal.inf.br/nfe")
					nprot[1..-1].remove
				end

				def corrige_qtde_item_cancelamento_prazo_2(xml)
					qtde_item = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:qtdeItem","xs" => "http://www.portalfiscal.inf.br/nfe")
					qtde_item[0..-2].remove
				end

				def corrige_c_orgao_emissao_em_contingencia(xml)
				  c_orgao = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:cOrgao","xs" => "http://www.portalfiscal.inf.br/nfe")
					c_orgao.first.content = /^11|12|13|14|15|16|17|21|22|23|24|25|26|27|28|29|31|32|33|35|41|42|43|50|51|52|53|91$/.random_example
				end

				def remove_tp_autorizacao_emissao_em_contingencia(xml)
				  tp_autorizacao = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpAutorizacao","xs" => "http://www.portalfiscal.inf.br/nfe")
					tp_autorizacao.remove
				end

				def remove_aut_xml_emissao_em_contingencia(xml)
				  aut_xml = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:autXML","xs" => "http://www.portalfiscal.inf.br/nfe")
					aut_xml.remove
				end

				def corrige_c_orgao_autor_emissao_em_contingencia(xml)
				  c_orgao_autor = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:cOrgaoAutor","xs" => "http://www.portalfiscal.inf.br/nfe")
					c_orgao_autor[1..-1].remove
				end
				
				def corrige_ver_aplic_emissao_em_contingencia(xml)
				  ver_aplic = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:verAplic","xs" => "http://www.portalfiscal.inf.br/nfe")
					ver_aplic[1..-1].remove
				end

				def remove_item_pedido_emissao_em_contingencia(xml)
				  item_pedido = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:itemPedido","xs" => "http://www.portalfiscal.inf.br/nfe")
					item_pedido.remove
				end
				
				def remove_qtde_item_emissao_em_contingencia(xml)
					qtde_item = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:qtdeItem","xs" => "http://www.portalfiscal.inf.br/nfe")
					qtde_item.remove	
				end

				def corrige_tipo_autor_emissao_em_contingencia(xml)
				  tipo_autores = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpAutor","xs" => "http://www.portalfiscal.inf.br/nfe")
					tipo_autores[1..-1].each{|tag| tipo_autores.delete(tag).remove }
					tipo_autores.first.content = '1'
				end
				
				def corrige_n_prot_emissao_em_contingencia(xml)
					nprot = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:nProt","xs" => "http://www.portalfiscal.inf.br/nfe")
					nprot.remove
				end
				
				def remove_ch_nfe_ref_emissao_em_contingencia(xml)
				  chnferef = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:chNFeRef","xs" => "http://www.portalfiscal.inf.br/nfe")
				  chnferef.remove
				end
				
				def remove_x_correcao_emissao_em_contingencia(xml)
				  x_correcao = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xCorrecao","xs" => "http://www.portalfiscal.inf.br/nfe")
					x_correcao.remove
				end
				
				def remove_x_cond_uso_emissao_em_contingencia(xml)
				  x_cond_uso = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xCondUso","xs" => "http://www.portalfiscal.inf.br/nfe")
					x_cond_uso.remove
				end
				
				def remove_x_just_emissao_em_contingencia(xml)
				  x_just = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xJust","xs" => "http://www.portalfiscal.inf.br/nfe")
					x_just.remove
				end
				
				def corrige_versao_env_evento_emissao_em_contingencia(xml)
				  versao = xml.xpath("//xs:envEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
					versao.content = '1.00'
				end
				
				def corrige_tp_evento_emissao_em_contingencia(xml)
					tp_evento = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:tpEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
					tp_evento.content = '110140'
				end
				
				def corrige_ver_evento_emissao_em_contingencia(xml)
				  ver_evento = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:verEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
					ver_evento.content = '1.00'
				end
				
				def corrige_versao_det_evento_emissao_em_contingencia(xml)
				  versao = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
					versao.content = '1.00'
				end
				
				def corrige_num_item_det_evento_emissao_em_contingencia(xml)
				  num_item = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@numItem","xs" => "http://www.portalfiscal.inf.br/nfe").first
					num_item.remove
				end
				
				def corrige_desc_evento_emissao_em_contingencia(xml)
					desc_evento = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe")
					desc_evento[1..-1].remove
					desc_evento.first.content = 'EPEC'
				end

				def corrige_x_just_operacao_nao_realizada(xml)
				  x_just = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xJust","xs" => "http://www.portalfiscal.inf.br/nfe")
					x_just[1..-1].remove
				end

				def corrige_versao_env_evento_operacao_nao_realizada(xml)
				  versao = xml.xpath("//xs:envEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
					versao.content = '1.00'
				end
				
				def corrige_tp_evento_operacao_nao_realizada(xml)
					tp_evento = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:tpEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
					tp_evento.content = '210220'
				end
				
				def corrige_ver_evento_operacao_nao_realizada(xml)
				  ver_evento = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:verEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
					ver_evento.content = '1.00'
				end
				
				def corrige_versao_det_evento_operacao_nao_realizada(xml)
				  versao = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
					versao.content = '1.00'
				end
				
				def remove_num_item_det_evento_operacao_nao_realizada(xml)
				  num_item = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@numItem","xs" => "http://www.portalfiscal.inf.br/nfe").first
					num_item.remove
				end
				
				def corrige_desc_evento_operacao_nao_realizada(xml)
					desc_evento = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe")
					desc_evento[1..-1].remove
					desc_evento.first.content = 'Desconhecimento da Operacao'
				end

				def remove_c_orgao_autor_operacao_nao_realizada(xml)
				  c_orgao_autor = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:cOrgaoAutor","xs" => "http://www.portalfiscal.inf.br/nfe")
					c_orgao_autor.remove
				end
				
				def remove_tp_autor_operacao_nao_realizada(xml)
				  tp_autor = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpAutor","xs" => "http://www.portalfiscal.inf.br/nfe")
					tp_autor.remove
				end
				
				def remove_ver_aplic_operacao_nao_realizada(xml)
				  ver_aplic = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:verAplic","xs" => "http://www.portalfiscal.inf.br/nfe")
					ver_aplic.remove
				end
				
				def remove_n_prot_operacao_nao_realizada(xml)
					nprot = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:nProt","xs" => "http://www.portalfiscal.inf.br/nfe")
					nprot.remove
				end
				
				def remove_ch_nfe_ref_operacao_nao_realizada(xml)
				  chnferef = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:chNFeRef","xs" => "http://www.portalfiscal.inf.br/nfe")
				  chnferef.remove
				end
				
				def remove_x_correcao_operacao_nao_realizada(xml)
				  x_correcao = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xCorrecao","xs" => "http://www.portalfiscal.inf.br/nfe")
					x_correcao.remove
				end
				
				def remove_x_cond_uso_operacao_nao_realizada(xml)
				  x_cond_uso = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xCondUso","xs" => "http://www.portalfiscal.inf.br/nfe")
					x_cond_uso.remove
				end
				
				def remove_dh_emi_operacao_nao_realizada(xml)
				  dhemi = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dhEmi","xs" => "http://www.portalfiscal.inf.br/nfe")
					dhemi.remove
				end
				
				def remove_tp_nf_operacao_nao_realizada(xml)
				  tpnf = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpNF","xs" => "http://www.portalfiscal.inf.br/nfe")
					tpnf.remove
				end
				
				def remove_ie_operacao_nao_realizada(xml)
				  ie = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:IE","xs" => "http://www.portalfiscal.inf.br/nfe")
					ie.remove
				end
				
				def remove_dest_operacao_nao_realizada(xml)
				  dest = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest","xs" => "http://www.portalfiscal.inf.br/nfe")
					dest.remove
				end
				
				def remove_v_nf_operacao_nao_realizada(xml)
				  vnf = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:vNF","xs" => "http://www.portalfiscal.inf.br/nfe")
					vnf.remove
				end
				
				def remove_v_icms_operacao_nao_realizada(xml)
				  vicms = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:vICMS","xs" => "http://www.portalfiscal.inf.br/nfe")
					vicms.remove
				end
				
				def remove_v_st_operacao_nao_realizada(xml)
				  vst = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:vST","xs" => "http://www.portalfiscal.inf.br/nfe")
					vst.remove
				end
				
				def remove_item_pedido_operacao_nao_realizada(xml)
				  item_pedido = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:itemPedido","xs" => "http://www.portalfiscal.inf.br/nfe")
					item_pedido.remove
				end
				
				def remove_qtde_item_operacao_nao_realizada(xml)
					qtde_item = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:qtdeItem","xs" => "http://www.portalfiscal.inf.br/nfe")
					qtde_item.remove
				end
				
				def remove_aut_xml_operacao_nao_realizada(xml)
				 	aut_xml = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:autXML","xs" => "http://www.portalfiscal.inf.br/nfe")
					aut_xml.remove
				end
				
				def remove_tp_autorizacao_operacao_nao_realizada(xml)
				  tp_autorizacao = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpAutorizacao","xs" => "http://www.portalfiscal.inf.br/nfe")
					tp_autorizacao.remove
				end

				def corrige_x_just_desconhecimento_da_operacao(xml)
				  x_just = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xJust","xs" => "http://www.portalfiscal.inf.br/nfe")
					x_just[1..-1].remove
				end

				def corrige_versao_env_evento_desconhecimento_da_operacao(xml)
				  versao = xml.xpath("//xs:envEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
					versao.content = '1.00'
				end
				
				def corrige_tp_evento_desconhecimento_da_operacao(xml)
					tp_evento = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:tpEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
					tp_evento.content = '210220'
				end
				
				def corrige_ver_evento_desconhecimento_da_operacao(xml)
				  ver_evento = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:verEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
					ver_evento.content = '1.00'
				end
				
				def corrige_versao_det_evento_desconhecimento_da_operacao(xml)
				  versao = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
					versao.content = '1.00'
				end
				
				def remove_num_item_det_evento_desconhecimento_da_operacao(xml)
				  num_item = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@numItem","xs" => "http://www.portalfiscal.inf.br/nfe").first
					num_item.remove
				end
				
				def corrige_desc_evento_desconhecimento_da_operacao(xml)
					desc_evento = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe")
					desc_evento[1..-1].remove
					desc_evento.first.content = 'Desconhecimento da Operacao'
				end

				def remove_c_orgao_autor_desconhecimento_da_operacao(xml)
				  c_orgao_autor = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:cOrgaoAutor","xs" => "http://www.portalfiscal.inf.br/nfe")
					c_orgao_autor.remove
				end
				
				def remove_tp_autor_desconhecimento_da_operacao(xml)
				  tp_autor = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpAutor","xs" => "http://www.portalfiscal.inf.br/nfe")
					tp_autor.remove
				end
				
				def remove_ver_aplic_desconhecimento_da_operacao(xml)
				  ver_aplic = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:verAplic","xs" => "http://www.portalfiscal.inf.br/nfe")
					ver_aplic.remove
				end
				
				def remove_n_prot_desconhecimento_da_operacao(xml)
					nprot = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:nProt","xs" => "http://www.portalfiscal.inf.br/nfe")
					nprot.remove
				end
				
				def remove_ch_nfe_ref_desconhecimento_da_operacao(xml)
				  chnferef = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:chNFeRef","xs" => "http://www.portalfiscal.inf.br/nfe")
				  chnferef.remove
				end
				
				def remove_x_correcao_desconhecimento_da_operacao(xml)
				  x_correcao = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xCorrecao","xs" => "http://www.portalfiscal.inf.br/nfe")
					x_correcao.remove
				end
				
				def remove_x_cond_uso_desconhecimento_da_operacao(xml)
				  x_cond_uso = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xCondUso","xs" => "http://www.portalfiscal.inf.br/nfe")
					x_cond_uso.remove
				end
				
				def remove_dh_emi_desconhecimento_da_operacao(xml)
				  dhemi = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dhEmi","xs" => "http://www.portalfiscal.inf.br/nfe")
					dhemi.remove
				end
				
				def remove_tp_nf_desconhecimento_da_operacao(xml)
				  tpnf = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpNF","xs" => "http://www.portalfiscal.inf.br/nfe")
					tpnf.remove
				end
				
				def remove_ie_desconhecimento_da_operacao(xml)
				  ie = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:IE","xs" => "http://www.portalfiscal.inf.br/nfe")
					ie.remove
				end
				
				def remove_dest_desconhecimento_da_operacao(xml)
				  dest = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest","xs" => "http://www.portalfiscal.inf.br/nfe")
					dest.remove
				end
				
				def remove_v_nf_desconhecimento_da_operacao(xml)
				  vnf = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:vNF","xs" => "http://www.portalfiscal.inf.br/nfe")
					vnf.remove
				end
				
				def remove_v_icms_desconhecimento_da_operacao(xml)
				  vicms = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:vICMS","xs" => "http://www.portalfiscal.inf.br/nfe")
					vicms.remove
				end
				
				def remove_v_st_desconhecimento_da_operacao(xml)
				  vst = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:vST","xs" => "http://www.portalfiscal.inf.br/nfe")
					vst.remove
				end
				
				def remove_item_pedido_desconhecimento_da_operacao(xml)
				  item_pedido = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:itemPedido","xs" => "http://www.portalfiscal.inf.br/nfe")
					item_pedido.remove
				end
				
				def remove_qtde_item_desconhecimento_da_operacao(xml)
					qtde_item = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:qtdeItem","xs" => "http://www.portalfiscal.inf.br/nfe")
					qtde_item.remove	
				end
				
				def remove_aut_xml_desconhecimento_da_operacao(xml)
				 	aut_xml = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:autXML","xs" => "http://www.portalfiscal.inf.br/nfe")
					aut_xml.remove
				end
				
				def remove_tp_autorizacao_desconhecimento_da_operacao(xml)
				  tp_autorizacao = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpAutorizacao","xs" => "http://www.portalfiscal.inf.br/nfe")
					tp_autorizacao.remove
				end

				def corrige_x_just_ciencia_da_operacao(xml)
				  x_just = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xJust","xs" => "http://www.portalfiscal.inf.br/nfe")
					x_just[1..-1].remove
				end

				def corrige_versao_env_evento_ciencia_da_operacao(xml)
				  versao = xml.xpath("//xs:envEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
					versao.content = '1.00'
				end
				
				def corrige_tp_evento_ciencia_da_operacao(xml)
					tp_evento = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:tpEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
					tp_evento.content = '210210'
				end
				
				def corrige_ver_evento_ciencia_da_operacao(xml)
				  ver_evento = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:verEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
					ver_evento.content = '1.00'
				end
				
				def corrige_versao_det_evento_ciencia_da_operacao(xml)
				  versao = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
					versao.content = '1.00'
				end
				
				def remove_num_item_det_evento_ciencia_da_operacao(xml)
				  num_item = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@numItem","xs" => "http://www.portalfiscal.inf.br/nfe").first
					num_item.remove
				end
				
				def corrige_desc_evento_ciencia_da_operacao(xml)
					desc_evento = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe")
					desc_evento[1..-1].remove
					desc_evento.first.content = 'Ciencia da Operacao'
				end

				def remove_c_orgao_autor_ciencia_da_operacao(xml)
				  c_orgao_autor = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:cOrgaoAutor","xs" => "http://www.portalfiscal.inf.br/nfe")
					c_orgao_autor.remove
				end
				
				def remove_tp_autor_ciencia_da_operacao(xml)
				  tp_autor = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpAutor","xs" => "http://www.portalfiscal.inf.br/nfe")
					tp_autor.remove
				end
				
				def remove_ver_aplic_ciencia_da_operacao(xml)
				  ver_aplic = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:verAplic","xs" => "http://www.portalfiscal.inf.br/nfe")
					ver_aplic.remove
				end
				
				def remove_n_prot_ciencia_da_operacao(xml)
					nprot = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:nProt","xs" => "http://www.portalfiscal.inf.br/nfe")
					nprot.remove
				end
				
				def remove_ch_nfe_ref_ciencia_da_operacao(xml)
				  chnferef = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:chNFeRef","xs" => "http://www.portalfiscal.inf.br/nfe")
				  chnferef.remove
				end
				
				def remove_x_correcao_ciencia_da_operacao(xml)
				  x_correcao = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xCorrecao","xs" => "http://www.portalfiscal.inf.br/nfe")
					x_correcao.remove
				end
				
				def remove_x_cond_uso_ciencia_da_operacao(xml)
				  x_cond_uso = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xCondUso","xs" => "http://www.portalfiscal.inf.br/nfe")
					x_cond_uso.remove
				end
				
				def remove_dh_emi_ciencia_da_operacao(xml)
				  dhemi = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dhEmi","xs" => "http://www.portalfiscal.inf.br/nfe")
					dhemi.remove
				end
				
				def remove_tp_nf_ciencia_da_operacao(xml)
				  tpnf = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpNF","xs" => "http://www.portalfiscal.inf.br/nfe")
					tpnf.remove
				end
				
				def remove_ie_ciencia_da_operacao(xml)
				  ie = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:IE","xs" => "http://www.portalfiscal.inf.br/nfe")
					ie.remove
				end
				
				def remove_dest_ciencia_da_operacao(xml)
				  dest = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest","xs" => "http://www.portalfiscal.inf.br/nfe")
					dest.remove
				end
				
				def remove_v_nf_ciencia_da_operacao(xml)
				  vnf = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:vNF","xs" => "http://www.portalfiscal.inf.br/nfe")
					vnf.remove
				end
				
				def remove_v_icms_ciencia_da_operacao(xml)
				  vicms = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:vICMS","xs" => "http://www.portalfiscal.inf.br/nfe")
					vicms.remove
				end
				
				def remove_v_st_ciencia_da_operacao(xml)
				  vst = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:vST","xs" => "http://www.portalfiscal.inf.br/nfe")
					vst.remove
				end
				
				def remove_item_pedido_ciencia_da_operacao(xml)
				  item_pedido = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:itemPedido","xs" => "http://www.portalfiscal.inf.br/nfe")
					item_pedido.remove
				end
				
				def remove_qtde_item_ciencia_da_operacao(xml)
					qtde_item = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:qtdeItem","xs" => "http://www.portalfiscal.inf.br/nfe")
					qtde_item.remove	
				end
				
				def remove_aut_xml_ciencia_da_operacao(xml)
				 	aut_xml = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:autXML","xs" => "http://www.portalfiscal.inf.br/nfe")
					aut_xml.remove
				end
				
				def remove_tp_autorizacao_ciencia_da_operacao(xml)
				  tp_autorizacao = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpAutorizacao","xs" => "http://www.portalfiscal.inf.br/nfe")
					tp_autorizacao.remove
				end

				def corrige_x_just_confirmacao_da_operacao(xml)
				  x_just = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xJust","xs" => "http://www.portalfiscal.inf.br/nfe")
					x_just[1..-1].remove
				end

				def corrige_versao_env_evento_confirmacao_da_operacao(xml)
				  versao = xml.xpath("//xs:envEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
					versao.content = '1.00'
				end
				
				def corrige_tp_evento_confirmacao_da_operacao(xml)
					tp_evento = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:tpEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
					tp_evento.content = '210200'
				end
				
				def corrige_ver_evento_confirmacao_da_operacao(xml)
				  ver_evento = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:verEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
					ver_evento.content = '1.00'
				end
				
				def corrige_versao_det_evento_confirmacao_da_operacao(xml)
				  versao = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
					versao.content = '1.00'
				end
				
				def remove_num_item_det_evento_confirmacao_da_operacao(xml)
				  num_item = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@numItem","xs" => "http://www.portalfiscal.inf.br/nfe").first
					num_item.remove
				end
				
				def corrige_desc_evento_confirmacao_da_operacao(xml)
					desc_evento = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe")
					desc_evento[1..-1].remove
					desc_evento.first.content = 'Confirmacao da Operacao'
				end

				def remove_c_orgao_autor_confirmacao_da_operacao(xml)
				  c_orgao_autor = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:cOrgaoAutor","xs" => "http://www.portalfiscal.inf.br/nfe")
					c_orgao_autor.remove
				end
				
				def remove_tp_autor_confirmacao_da_operacao(xml)
				  tp_autor = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpAutor","xs" => "http://www.portalfiscal.inf.br/nfe")
					tp_autor.remove
				end
				
				def remove_ver_aplic_confirmacao_da_operacao(xml)
				  ver_aplic = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:verAplic","xs" => "http://www.portalfiscal.inf.br/nfe")
					ver_aplic.remove
				end
				
				def remove_n_prot_confirmacao_da_operacao(xml)
					nprot = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:nProt","xs" => "http://www.portalfiscal.inf.br/nfe")
					nprot.remove
				end
				
				def remove_ch_nfe_ref_confirmacao_da_operacao(xml)
				  chnferef = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:chNFeRef","xs" => "http://www.portalfiscal.inf.br/nfe")
				  chnferef.remove
				end
				
				def remove_x_correcao_confirmacao_da_operacao(xml)
				  x_correcao = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xCorrecao","xs" => "http://www.portalfiscal.inf.br/nfe")
					x_correcao.remove
				end
				
				def remove_x_cond_uso_confirmacao_da_operacao(xml)
				  x_cond_uso = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xCondUso","xs" => "http://www.portalfiscal.inf.br/nfe")
					x_cond_uso.remove
				end
				
				def remove_dh_emi_confirmacao_da_operacao(xml)
				  dhemi = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dhEmi","xs" => "http://www.portalfiscal.inf.br/nfe")
					dhemi.remove
				end
				
				def remove_tp_nf_confirmacao_da_operacao(xml)
				  tpnf = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpNF","xs" => "http://www.portalfiscal.inf.br/nfe")
					tpnf.remove
				end
				
				def remove_ie_confirmacao_da_operacao(xml)
				  ie = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:IE","xs" => "http://www.portalfiscal.inf.br/nfe")
					ie.remove
				end
				
				def remove_dest_confirmacao_da_operacao(xml)
				  dest = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest","xs" => "http://www.portalfiscal.inf.br/nfe")
					dest.remove
				end
				
				def remove_v_nf_confirmacao_da_operacao(xml)
				  vnf = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:vNF","xs" => "http://www.portalfiscal.inf.br/nfe")
					vnf.remove
				end
				
				def remove_v_icms_confirmacao_da_operacao(xml)
				  vicms = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:vICMS","xs" => "http://www.portalfiscal.inf.br/nfe")
					vicms.remove
				end
				
				def remove_v_st_confirmacao_da_operacao(xml)
				  vst = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:vST","xs" => "http://www.portalfiscal.inf.br/nfe")
					vst.remove
				end
				
				def remove_item_pedido_confirmacao_da_operacao(xml)
				  item_pedido = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:itemPedido","xs" => "http://www.portalfiscal.inf.br/nfe")
					item_pedido.remove
				end
				
				def remove_qtde_item_confirmacao_da_operacao(xml)
					qtde_item = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:qtdeItem","xs" => "http://www.portalfiscal.inf.br/nfe")
					qtde_item.remove	
				end
				
				def remove_aut_xml_confirmacao_da_operacao(xml)
				 	aut_xml = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:autXML","xs" => "http://www.portalfiscal.inf.br/nfe")
					aut_xml.remove
				end
				
				def remove_tp_autorizacao_confirmacao_da_operacao(xml)
				  tp_autorizacao = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpAutorizacao","xs" => "http://www.portalfiscal.inf.br/nfe")
					tp_autorizacao.remove
				end

				def corrige_versao_env_evento_ator_interessado(xml)
				  versao = xml.xpath("//xs:envEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
					versao.content = '1.00'
				end

				def corrige_tp_evento_ator_interessado(xml)
				  tp_evento = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:tpEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
					tp_evento.content = '110150'
				end

				def corrige_ver_evento_ator_interessado(xml)
				  ver_evento = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:verEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
					ver_evento.content = '1.00'
				end

				def corrige_versao_det_evento_ator_interessado(xml)
				  versao = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
					versao.content = '1.00'
				end

				def remove_num_item_ator_interessado(xml)
				  num_item = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@numItem","xs" => "http://www.portalfiscal.inf.br/nfe")
					num_item.remove
				end

				def corrige_desc_evento_ator_interessado(xml)
				  desc_evento = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe")
					desc_evento[1..-1].remove
					desc_evento.first.content = 'Ator interessado na NF-e'	
				end

				def corrige_c_orgao_autor_ator_interessado(xml)
				  c_orgao_autor = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:cOrgaoAutor","xs" => "http://www.portalfiscal.inf.br/nfe")
					c_orgao_autor[1..-1].remove
				end

				def corrige_tp_autor_ator_interessado(xml)
				  tp_autor = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpAutor","xs" => "http://www.portalfiscal.inf.br/nfe")
					tp_autor[1..-1].remove
					tp_autor.first.content = /[1-3]/.random_example
				end

				def corrige_ver_aplic_ator_interessado(xml)
				  ver_aplic = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:verAplic","xs" => "http://www.portalfiscal.inf.br/nfe")
					ver_aplic[1..-1].remove
				end

				def corrige_x_cond_uso_ator_interessado(xml)
				  x_cond_uso = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xCondUso","xs" => "http://www.portalfiscal.inf.br/nfe")
					x_cond_uso[0..-2].remove
				end

				def remove_n_prot_ator_interessado(xml)
					nprot = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:nProt","xs" => "http://www.portalfiscal.inf.br/nfe")
					nprot.remove
				end

				def remove_x_just_ator_interessado(xml)
				  x_just = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xJust","xs" => "http://www.portalfiscal.inf.br/nfe")
					x_just.remove
				end

				def remove_ch_nfe_ref_ator_interessado(xml)
				  chnferef = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:chNFeRef","xs" => "http://www.portalfiscal.inf.br/nfe")
				  chnferef.remove
				end

				def remove_x_correcao_ator_interessado(xml)
				  x_correcao = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xCorrecao","xs" => "http://www.portalfiscal.inf.br/nfe")
					x_correcao.remove
				end

				def remove_dh_emi_ator_interessado(xml)
				  dhemi = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dhEmi","xs" => "http://www.portalfiscal.inf.br/nfe")
					dhemi.remove
				end

				def remove_tp_nf_ator_interessado(xml)
				  tpnf = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpNF","xs" => "http://www.portalfiscal.inf.br/nfe")
					tpnf.remove
				end

				def remove_ie_ator_interessado(xml)
				  ie = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:IE","xs" => "http://www.portalfiscal.inf.br/nfe")
					ie.remove
				end

				def remove_dest_ator_interessado(xml)
				  dest = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest","xs" => "http://www.portalfiscal.inf.br/nfe")
					dest.remove
				end

				def remove_v_nf_ator_interessado(xml)
				  vnf = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:vNF","xs" => "http://www.portalfiscal.inf.br/nfe")
					vnf.remove
				end

				def remove_v_icms_ator_interessado(xml)
				  vicms = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:vICMS","xs" => "http://www.portalfiscal.inf.br/nfe")
					vicms.remove				
				end

				def remove_v_st_ator_interessado(xml)
				  vst = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:vST","xs" => "http://www.portalfiscal.inf.br/nfe")
					vst.remove	
				end

				def remove_item_pedido_ator_interessado(xml)
				  item_pedido = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:itemPedido","xs" => "http://www.portalfiscal.inf.br/nfe")
					item_pedido.remove
				end

				def remove_qtde_item_ator_interessado(xml)
					qtde_item = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:qtdeItem","xs" => "http://www.portalfiscal.inf.br/nfe")
					qtde_item.remove				
				end


				def corrige_tipo_evento_prorrogar_prazo_2(xml)
					tp_evento = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:tpEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
					tp_evento.content = '111501'
				end

				def corrige_versao_env_evento_prorrogar_prazo_2(xml)
				  versao = xml.xpath("//xs:envEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
					versao.content = '1.00'
				end

				def corrige_desc_evento_prorrogar_prazo_2(xml)
					desc_evento = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe")
					desc_evento[1..-1].remove
					desc_evento.first.content = 'Pedido de Prorrogacao'
				end

				def corrige_nprot_prorrogar_prazo_2(xml)
					nprot = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:nProt","xs" => "http://www.portalfiscal.inf.br/nfe")
					nprot[1..-1].remove
				end

				def corrige_qtde_item_prorrogar_prazo_2(xml)
					qtde_item = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:qtdeItem","xs" => "http://www.portalfiscal.inf.br/nfe")
					qtde_item[0..-2].remove
				end

				def corrige_tipo_evento_prorrogar_prazo_1(xml)
					tp_evento = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:tpEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
					tp_evento.content = '111500'
				end

				def corrige_versao_env_evento_prorrogar_prazo_1(xml)
				  versao = xml.xpath("//xs:envEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
					versao.content = '1.00'
				end

				def corrige_desc_evento_prorrogar_prazo_1(xml)
					desc_evento = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe")
					desc_evento[1..-1].remove
					desc_evento.first.content = 'Pedido de Prorrogacao'
				end

				def corrige_nprot_prorrogar_prazo_1(xml)
					nprot = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:nProt","xs" => "http://www.portalfiscal.inf.br/nfe")
					nprot[1..-1].remove
				end

				def corrige_qtde_item_prorrogar_prazo_1(xml)
					qtde_item = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:qtdeItem","xs" => "http://www.portalfiscal.inf.br/nfe")
					qtde_item[0..-2].remove
				end

				def corrige_xjust_cancelar_nota_substituicao(xml)
				  det_evento = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
				  chnferef = det_evento.children[2].remove
					det_evento.add_child(chnferef)
				end

				def corrige_nprot_cancelar_nota_substituicao(xml)
				  det_evento = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
				  chnferef = det_evento.children[3].remove
					det_evento.add_child(chnferef)
				end

				def remove_xconduso_cancelar_nota_substituicao(xml)
				  x_cond_uso = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xCondUso","xs" => "http://www.portalfiscal.inf.br/nfe")
					x_cond_uso.remove
				end
				
				def remove_xcorrecao_cancelar_nota_substituicao(xml)
				  x_correcao = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xCorrecao","xs" => "http://www.portalfiscal.inf.br/nfe")
					x_correcao.remove
				end
				
				def corrige_chnferef_cancelar_nota_substituicao(xml)
				  det_evento = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
				  chnferef = det_evento.children[1].remove
				  det_evento.add_child(chnferef)
				end

				def corrige_tipo_evento_cancelar_nota_substituicao(xml)
				  tp_evento = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:tpEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
					tp_evento.content = '110112'
				end

				def corrige_versao_env_evento_cancelar_nota_substituicao(xml)
				  versao = xml.xpath("//xs:envEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
					versao.content = '1.00'
				end

				def corrige_versao_det_evento_cancelar_nota_substituicao(xml)
				  versao = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
					versao.content = '1.00'
				end

				def corrige_ver_evento_cancelar_nota_substituicao(xml)
				  ver_evento = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:verEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
					ver_evento.content = '1.00'
				end

				def remove_num_item_cancelar_nota_substituicao(xml)
				  num_item = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@numItem","xs" => "http://www.portalfiscal.inf.br/nfe").first
					num_item.remove
				end

				def corrige_descricao_cancelar_nota_substituicao(xml)
				  descricoes = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe")
					descricoes[1..-1].each{|tag| descricoes.delete(tag).remove }
					descricoes.first.content = 'Cancelamento por substituicao'
				end

				def corrige_tipo_autor_cancelar_nota_substituicao(xml)
				  tipo_autores = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpAutor","xs" => "http://www.portalfiscal.inf.br/nfe")
					tipo_autores[0..-2].each{|tag| tipo_autores.delete(tag).remove }
					tipo_autores.first.content = '1'
				end

				def remove_dhemi_cancelar_nota_substituicao(xml)
				  dhemi = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dhEmi","xs" => "http://www.portalfiscal.inf.br/nfe")
					dhemi.remove
				end

				def remove_tpnf_cancelar_nota_substituicao(xml)
				  tpnf = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpNF","xs" => "http://www.portalfiscal.inf.br/nfe")
					tpnf.remove
				end

				def remove_ie_cancelar_nota_substituicao(xml)
				  ie = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:IE","xs" => "http://www.portalfiscal.inf.br/nfe")
					ie.remove
				end

				def remove_dest_cancelar_nota_substituicao(xml)
				  dest = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest","xs" => "http://www.portalfiscal.inf.br/nfe")
					dest.remove
				end

				def remove_vnf_cancelar_nota_substituicao(xml)
				  vnf = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:vNF","xs" => "http://www.portalfiscal.inf.br/nfe")
					vnf.remove
				end

				def remove_vicms_cancelar_nota_substituicao(xml)
				  vicms = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:vICMS","xs" => "http://www.portalfiscal.inf.br/nfe")
					vicms.remove
				end

				def remove_vst_cancelar_nota_substituicao(xml)
				  vst = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:vST","xs" => "http://www.portalfiscal.inf.br/nfe")
					vst.remove
				end

				def remove_item_pedido_cancelar_nota_substituicao(xml)
				  item_pedido = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:itemPedido","xs" => "http://www.portalfiscal.inf.br/nfe")
					item_pedido.remove
				end

				def remove_qtde_item_cancelar_nota_substituicao(xml)
				  qtde_item = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:qtdeItem","xs" => "http://www.portalfiscal.inf.br/nfe")
					qtde_item.remove
				end

				def remove_xjust_cancelar_nota_substituicao(xml)
				  xjust = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xJust","xs" => "http://www.portalfiscal.inf.br/nfe")
					xjust[0..-2].remove
				end

				def remove_c_orgao_autor_cancelar_nota_substituicao(xml)
				  c_orgao_autores = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:cOrgaoAutor","xs" => "http://www.portalfiscal.inf.br/nfe")
					c_orgao_autores[0..-2].remove
				end

				def remove_ver_aplic_cancelar_nota_substituicao(xml)
				  ver_aplic = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:verAplic","xs" => "http://www.portalfiscal.inf.br/nfe")
					ver_aplic[0..-2].remove
				end

				def remove_nprot_cancelar_nota_substituicao(xml)
				  nprot = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:nProt","xs" => "http://www.portalfiscal.inf.br/nfe")
					nprot[0..-2].remove
				end

				def remove_aut_xml_cancelar_nota_substituicao(xml)
				 	aut_xml = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:autXML","xs" => "http://www.portalfiscal.inf.br/nfe")
					aut_xml.remove
				end

				def remove_tp_autorizacao_cancelar_nota_substituicao(xml)
				  tp_autorizacao = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpAutorizacao","xs" => "http://www.portalfiscal.inf.br/nfe")
					tp_autorizacao.remove
				end


				def corrige_versao_consultar_status_servico(xml)
					versao = xml.xpath("//xs:consStatServ//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
					versao.content = '4.00'
				end

				def corrige_tipo_evento_cancelar_nota(xml)
					tipo_eventos = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:tpEvento","xs" => "http://www.portalfiscal.inf.br/nfe")
					tipo_eventos[0..-2].each{|tag| tipo_eventos.delete(tag).remove }
					tipo_evento = tipo_eventos.pop
					tipo_evento.content  = '110111'			
				end

				def corrige_ver_evento_cancelar_nota(xml)
					versoes_env_evento = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:verEvento","xs" => "http://www.portalfiscal.inf.br/nfe")
					versoes_env_evento[0..-2].each{|tag| versoes_env_evento.delete(tag).remove }
					versao_env_evento = versoes_env_evento.pop
					versao_env_evento.content = '1.00'
				end

				def corrige_versao_det_evento_cancelar_nota(xml)
					versoes_det_evento = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe")
					versoes_det_evento[0..-2].each{|tag| versoes_det_evento.delete(tag).remove }
					versao_det_evento = versoes_det_evento.pop
					versao_det_evento.content = '1.00'
				end

				def corrige_versao_env_evento_cancelar_nota(xml)
					versao = xml.xpath("//xs:envEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
					versao.content = '1.00'
				end

				def corrige_descricao_cancelar_nota(xml)
					descricoes_evento = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe")
					descricoes_evento[1..-1].each{|tag| descricoes_evento.delete(tag).remove }
					descricao_evento = descricoes_evento.first
					descricao_evento.content = 'Cancelamento'
				end

				def remove_num_item_cancelar_nota(xml)
					dets_evento = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento","xs" => "http://www.portalfiscal.inf.br/nfe")
					dets_evento[0..-2].each{|tag| dets_evento.delete(tag).remove }
					det_evento = dets_evento.pop
					det_evento.remove_attribute('numItem')
				end

				def remove_c_orgao_autor_cancelar_nota(xml)
				  c_orgao_autores = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:cOrgaoAutor","xs" => "http://www.portalfiscal.inf.br/nfe")
					c_orgao_autores.remove
				end

				def remove_ver_aplic_cancelar_nota(xml)
					versoes_aplic = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:verAplic","xs" => "http://www.portalfiscal.inf.br/nfe")
					versoes_aplic.remove
				end

				def remove_tipo_autor_cancelar_nota(xml)
				 	tipo_autores = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpAutor","xs" => "http://www.portalfiscal.inf.br/nfe")
					tipo_autores.remove
				end

				def remove_chnferef_cancelar_nota(xml)
					chnferef = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:chNFeRef","xs" => "http://www.portalfiscal.inf.br/nfe")
					chnferef.remove
				end

				def remove_xcorrecao_cancelar_nota(xml)
					xcorrecao = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xCorrecao","xs" => "http://www.portalfiscal.inf.br/nfe")
					xcorrecao.remove
				end

				def remove_xconduso_cancelar_nota(xml)
					xconduso = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xCondUso","xs" => "http://www.portalfiscal.inf.br/nfe")
					xconduso.remove
				end

				def remove_xjust_cancelar_nota(xml)
					xjust = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xJust","xs" => "http://www.portalfiscal.inf.br/nfe")
					xjust[1..-1].remove
				end

				def remove_nprot_cancelar_nota(xml)
					nprot = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:nProt","xs" => "http://www.portalfiscal.inf.br/nfe")
					nprot[1..-1].remove
				end

				def remove_dhemi_cancelar_nota(xml)
					dhemi = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dhEmi","xs" => "http://www.portalfiscal.inf.br/nfe")
					dhemi.remove
				end
				
				def remove_tpnf_cancelar_nota(xml)
					tpnf = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpNF","xs" => "http://www.portalfiscal.inf.br/nfe")
					tpnf.remove
				end
				
				def remove_ie_cancelar_nota(xml)
					ie = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:IE","xs" => "http://www.portalfiscal.inf.br/nfe")
					ie.remove
				end
				
				def remove_dest_cancelar_nota(xml)
					dest = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest","xs" => "http://www.portalfiscal.inf.br/nfe")
					dest.remove
				end
				
				def remove_vnf_cancelar_nota(xml)
					vnf = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:vNF","xs" => "http://www.portalfiscal.inf.br/nfe")
					vnf.remove
				end
				
				def remove_vicms_cancelar_nota(xml)
					vicms = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:vICMS","xs" => "http://www.portalfiscal.inf.br/nfe")
					vicms.remove
				end
				
				def remove_vst_cancelar_nota(xml)
					vst = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:vST","xs" => "http://www.portalfiscal.inf.br/nfe")
					vst.remove
				end
				
				def remove_item_pedido_cancelar_nota(xml)
					item_pedido = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:itemPedido","xs" => "http://www.portalfiscal.inf.br/nfe")
					item_pedido.remove
				end
				
				def remove_qtde_item_cancelar_nota(xml)
					qtde_item = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:qtdeItem","xs" => "http://www.portalfiscal.inf.br/nfe")
					qtde_item.remove
				end
				
				def remove_aut_xml_cancelar_nota(xml)
					aut_xml = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:autXML","xs" => "http://www.portalfiscal.inf.br/nfe")
					aut_xml.remove
				end
				
				def remove_tp_autorizacao_cancelar_nota(xml)
					tp_autorizacao = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpAutorizacao","xs" => "http://www.portalfiscal.inf.br/nfe")
					tp_autorizacao.remove
				end


				def corrige_tipo_evento_carta_correcao(xml)
					tipo_eventos = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:tpEvento","xs" => "http://www.portalfiscal.inf.br/nfe")
					tipo_eventos[0..-2].each{|tag| tipo_eventos.delete(tag).remove }
					tipo_evento = tipo_eventos.pop
					tipo_evento.content  = '110110'
				end

				def corrige_versao_carta_correcao(xml)
					env_eventos = xml.xpath("//xs:envEvento","xs" => "http://www.portalfiscal.inf.br/nfe")
					env_eventos[0..-2].each{|tag| env_eventos.delete(tag).remove }
					env_evento = env_eventos.pop
					env_evento['versao'] = '1.00'
				end

				def corrige_ver_evento_carta_correcao(xml)
					versoes_env_evento = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:verEvento","xs" => "http://www.portalfiscal.inf.br/nfe")
					versoes_env_evento[0..-2].each{|tag| versoes_env_evento.delete(tag).remove }
					versao_env_evento = versoes_env_evento.pop
					versao_env_evento.content = '1.00'
				end

				def corrige_versao_det_evento_carta_correcao(xml)
					versoes_det_evento = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe")
					versoes_det_evento[0..-2].each{|tag| versoes_det_evento.delete(tag).remove }
					versao_det_evento = versoes_det_evento.pop
					versao_det_evento.content = '1.00'
				end

				def corrige_versao_env_evento_carta_correcao(xml)
					versao = xml.xpath("//xs:envEvento//@versao","xs" => "http://www.portalfiscal.inf.br/nfe").first
					versao.content = '1.00'
				end

				def remove_num_item_carta_correcao(xml)
					dets_evento = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento","xs" => "http://www.portalfiscal.inf.br/nfe")
					dets_evento[0..-2].each{|tag| dets_evento.delete(tag).remove }
					det_evento = dets_evento.pop
					det_evento.remove_attribute('numItem')
				end

				def corrige_descricao_carta_correcao(xml)
					descricoes_evento = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe")
					descricoes_evento[1..-1].each{|tag| descricoes_evento.delete(tag).remove }
					descricao_evento = descricoes_evento.first
					descricao_evento.content = 'Carta de Correcao'
				end

				def corrige_condicao_uso_carta_correcao(xml)
					condicoes_uso = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xCondUso","xs" => "http://www.portalfiscal.inf.br/nfe")
					condicoes_uso[1..-1].each{|tag| condicoes_uso.delete(tag).remove }
					condicao_uso = condicoes_uso.first
					condicao_uso.content = "A Carta de Correcao e disciplinada pelo paragrafo 1o-A do art. 7o do Convenio S/N, de 15 de dezembro de 1970 e pode ser utilizada para regularizacao de erro ocorrido na emissao de documento fiscal, desde que o erro nao esteja relacionado com: I - as variaveis que determinam o valor do imposto tais como: base de calculo, aliquota, diferenca de preco, quantidade, valor da operacao ou da prestacao; II - a correcao de dados cadastrais que implique mudanca do remetente ou do destinatario; III - a data de emissao ou de saida."
				end

				def remove_c_orgao_autor_carta_correcao(xml)
				  c_orgao_autores = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:cOrgaoAutor","xs" => "http://www.portalfiscal.inf.br/nfe")
					c_orgao_autores.remove
				end

				def remove_tipo_autor_carta_correcao(xml)
				 	tipo_autores = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpAutor","xs" => "http://www.portalfiscal.inf.br/nfe")
					tipo_autores.remove
				end

				def remove_ver_aplic_carta_correcao(xml)
					versoes_aplic = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:verAplic","xs" => "http://www.portalfiscal.inf.br/nfe")
					versoes_aplic.remove
				end

				def remove_nprot_carta_correcao(xml)
					n_prots = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:nProt","xs" => "http://www.portalfiscal.inf.br/nfe")
					n_prots.remove
				end

				def remove_xjust_carta_correcao(xml)
					x_justs = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xJust","xs" => "http://www.portalfiscal.inf.br/nfe")
					x_justs.remove
				end

				def remove_chnferef_carta_correcao(xml)
					chnferef = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:chNFeRef","xs" => "http://www.portalfiscal.inf.br/nfe")
					chnferef.remove
				end

				def remove_dhemi_carta_correcao(xml)
					dhemis = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dhEmi","xs" => "http://www.portalfiscal.inf.br/nfe")
					dhemis.remove
				end

				def remove_tpnf_carta_correcao(xml)
					tpnfs = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpNF","xs" => "http://www.portalfiscal.inf.br/nfe")
					tpnfs.remove									
				end

				def remove_ie_carta_correcao(xml)
					ies = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:IE","xs" => "http://www.portalfiscal.inf.br/nfe")
					ies.remove									
				end

				def remove_dest_carta_correcao(xml)
					dests = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest","xs" => "http://www.portalfiscal.inf.br/nfe")
					dests.remove									
				end

				def remove_vnf_carta_correcao(xml)
					vnfs = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:vNF","xs" => "http://www.portalfiscal.inf.br/nfe")
					vnfs.remove									
				end

				def remove_vicms_carta_correcao(xml)
					vicmss = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:vICMS","xs" => "http://www.portalfiscal.inf.br/nfe")
					vicmss.remove									
				end

				def remove_vst_carta_correcao(xml)
					vsts = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:vST","xs" => "http://www.portalfiscal.inf.br/nfe")
					vsts.remove									
				end

				def remove_item_pedido_carta_correcao(xml)
					itens_pedidos = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:itemPedido","xs" => "http://www.portalfiscal.inf.br/nfe")
					itens_pedidos.remove									
				end

				def remove_qtde_item_carta_correcao(xml)
					qtde_itens = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:qtdeItem","xs" => "http://www.portalfiscal.inf.br/nfe")
					qtde_itens.remove									
				end

				def remove_aut_xml_carta_correcao(xml)
					aut_xmls = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:autXML","xs" => "http://www.portalfiscal.inf.br/nfe")
					aut_xmls.remove
				end

				def remove_tp_autorizacao_carta_correcao(xml)
					tp_autorizacoes = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpAutorizacao","xs" => "http://www.portalfiscal.inf.br/nfe")
					tp_autorizacoes.remove									
				end


				def nfref_filho_unico(xml)
					nfref = xml.xpath("//xs:enviNFe//xs:NFe//xs:ide//xs:NFref","xs" => "http://www.portalfiscal.inf.br/nfe").first
					if nfref.children.length > 1
						nfref.children = nfref.elements.first
					end
				end

				def regra_e16a_10(xml)
					indicador_destinatario = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:indIEDest","xs" => "http://www.portalfiscal.inf.br/nfe").first
					modelo = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:mod","xs" => "http://www.portalfiscal.inf.br/nfe").first
					
					if modelo.content == '65'
						indicador_destinatario.content = "9"
					end
				end

				def regra_x25a_10(xml)
					vagao = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:vagao","xs" => "http://www.portalfiscal.inf.br/nfe").first
					modelo = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:mod","xs" => "http://www.portalfiscal.inf.br/nfe").first
					
					if modelo.content == "65"
						vagao.remove unless vagao.nil?
					end
				end

				def regra_x25b_10(xml)
					balsa = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:balsa","xs" => "http://www.portalfiscal.inf.br/nfe").first
					modelo = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:mod","xs" => "http://www.portalfiscal.inf.br/nfe").first
					
					if modelo.content == "65"
						balsa.remove unless balsa.nil?
					end
				end

				def regra_e16a_20(xml)
					indicador_destinatario = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:indIEDest","xs" => "http://www.portalfiscal.inf.br/nfe").first
					indicador_operacao = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:idDest","xs" => "http://www.portalfiscal.inf.br/nfe").first
					modelo = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:mod","xs" => "http://www.portalfiscal.inf.br/nfe").first

					if modelo.content == "55"
						if indicador_operacao.content == "3"
							indicador_destinatario.content = "9"
						end
					end
				end

				def regra_e16a_30(xml)
					indicador_destinatario = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:indIEDest","xs" => "http://www.portalfiscal.inf.br/nfe").first
					indicador_operacao = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:idDest","xs" => "http://www.portalfiscal.inf.br/nfe").first
					modelo = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:mod","xs" => "http://www.portalfiscal.inf.br/nfe").first

					if modelo.content == "55"
						if indicador_operacao.content == "2"
							indicador_destinatario.content = /[19]{1}/.random_example
						end
					end
				end

				def regra_ie_transp(xml)
					transportador_cpf = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:transporta//xs:CPF","xs" => "http://www.portalfiscal.inf.br/nfe").first
					transportador_inscricao_estadual = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:transporta//xs:IE","xs" => "http://www.portalfiscal.inf.br/nfe").first

					if !transportador_cpf.nil? and !transportador_inscricao_estadual.nil?
						transportador_inscricao_estadual.remove
					end

				end

				def regra_e17_30(xml)
					modelo = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:mod","xs" => "http://www.portalfiscal.inf.br/nfe").first
					destinatario_indicador = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:indIEDest","xs" => "http://www.portalfiscal.inf.br/nfe").first
					destinatario_inscricao_estadual = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:IE","xs" => "http://www.portalfiscal.inf.br/nfe").first

					if modelo.content == '55' and !destinatario_indicador.nil? and destinatario_indicador.content == "2"
						destinatario_inscricao_estadual.remove
					end
				end

				def regra_ie_dest(xml)
					destinatario_cnpj = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:CNPJ","xs" => "http://www.portalfiscal.inf.br/nfe").first
					destinatario_inscricao_estadual = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:IE","xs" => "http://www.portalfiscal.inf.br/nfe").first

					if destinatario_cnpj.nil? and !destinatario_inscricao_estadual.nil?
						destinatario_inscricao_estadual.remove
					end
				end

				def regra_e18_10(xml)
					inscricao_suframa = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:ISUF","xs" => "http://www.portalfiscal.inf.br/nfe").first
					modelo = xml.xpath("xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:mod","xs" => "http://www.portalfiscal.inf.br/nfe").first

					if modelo.content == '65' and !inscricao_suframa.nil?
						inscricao_suframa.remove
					end

				end

				def cria_mapa_tags()
					tags = CSV.read('tags.csv',col_sep:";",headers:true)
					tag_map = {}
					tags.each do |tag|
						dados_tag = {}
						dados_tag["id"] = tag["id"]
						dados_tag["nome"] = tag["nome"]
						dados_tag["tipo"] = tag["tipo"]
						dados_tag["pai"] = tag["pai"]
						dados_tag["min"] = tag["min"]
						dados_tag["max"] = tag["max"]
						dados_tag["regex"] = tag["regex"]
						dados_tag["namespace"] = tag["namespace"]
						dados_tag["filhos"] = []
						dados_tag["atributos"] = []
						tag_map["#{tag["id"]}"] = dados_tag

						if tag_map.key?(tag["pai"])
							if ATRIBUTOS.include?(tag["tipo"])
								tag_map[tag["pai"]]["atributos"] << tag["id"]
							else
								tag_map[tag["pai"]]["filhos"] << tag["id"]
							end
						end

					end
					tag_map
				end

		end

	end

end