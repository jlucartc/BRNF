require 'bigdecimal/util'
require_relative 'webservices'
require 'digest'

module BRNF

    module TagLambdas

      LAMBDAS = {
      	"//xs:enviNFe//xs:idLote" => lambda{|msg,xml|
      		lote_xml_tag = xml.xpath("//xs:enviNFe//xs:idLote","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		lote_xml_tag&.content = msg["lote"]
      	},
      	"//xs:enviNFe//xs:indSinc" => lambda{|msg,xml|
      		indsinc_xml_tag = xml.xpath("//xs:enviNFe//xs:indSinc","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		indsinc_xml_tag&.content = 1
      	},
      	"//xs:consReciNFe//xs:tpAmb" => lambda{|msg,xml|
      		ambiente_xml_tag = xml.xpath("//xs:consReciNFe//xs:tpAmb","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		ambiente_xml_tag&.content = msg["ambiente"]
      	},
      	"//xs:consReciNFe//xs:nRec" => lambda{|msg,xml|
      		recibo_xml_tag = xml.xpath("//xs:consReciNFe//xs:nRec","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		recibo_xml_tag&.content = msg["recibo"]
      	},
      	"//xs:inutNFe//xs:infInut//@Id" => lambda{|msg,xml|
      		id_xml_tag = xml.xpath("//xs:inutNFe//xs:infInut//@Id","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		id_xml_tag&.content = "ID"
          id_xml_tag&.content += "%02d" % msg["codigo_uf"]
          id_xml_tag&.content += "%02d" % msg["ano"]
          id_xml_tag&.content += "%014d" % msg["cnpj"]
          id_xml_tag&.content += "%02d" % msg["modelo"]
          id_xml_tag&.content += "%03d" % msg["serie"]
          id_xml_tag&.content += "%09d" % msg["numero_inicial"]
          id_xml_tag&.content += "%09d" % msg["numero_final"]
      	},
      	"//xs:inutNFe//xs:infInut//xs:tpAmb" => lambda{|msg,xml|
      		ambiente_xml_tag = xml.xpath("//xs:inutNFe//xs:infInut//xs:tpAmb","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		ambiente_xml_tag&.content = msg["ambiente"]
      	},
      	"//xs:inutNFe//xs:infInut//xs:cUF" => lambda{|msg,xml|
      		codigo_uf_xml_tag = xml.xpath("//xs:inutNFe//xs:infInut//xs:cUF","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		codigo_uf_xml_tag&.content = msg["codigo_uf"]
      	},
      	"//xs:inutNFe//xs:infInut//xs:ano" => lambda{|msg,xml|
      		ano_xml_tag = xml.xpath("//xs:inutNFe//xs:infInut//xs:ano","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		ano_xml_tag&.content = msg["ano"].nil? ? Time.now.strftime("%Y")[-2..-1] : msg["ano"]
      	},
      	"//xs:inutNFe//xs:infInut//xs:CNPJ" => lambda{|msg,xml|
      		cnpj_xml_tag = xml.xpath("//xs:inutNFe//xs:infInut//xs:CNPJ","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		cnpj_xml_tag&.content = msg["cnpj"]
      	},
      	"//xs:inutNFe//xs:infInut//xs:mod" => lambda{|msg,xml|
      		modelo_xml_tag = xml.xpath("//xs:inutNFe//xs:infInut//xs:mod","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		modelo_xml_tag&.content = msg["modelo"]
      	},
      	"//xs:inutNFe//xs:infInut//xs:serie" => lambda{|msg,xml|
      		serie_xml_tag = xml.xpath("//xs:inutNFe//xs:infInut//xs:serie","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		serie_xml_tag&.content = msg["serie"]
      	},
      	"//xs:inutNFe//xs:infInut//xs:nNFIni" => lambda{|msg,xml|
      		numero_inicial_xml_tag = xml.xpath("//xs:inutNFe//xs:infInut//xs:nNFIni","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		numero_inicial_xml_tag&.content = msg["numero_inicial"]
      	},
      	"//xs:inutNFe//xs:infInut//xs:nNFFin" => lambda{|msg,xml|
      		numero_final_xml_tag = xml.xpath("//xs:inutNFe//xs:infInut//xs:nNFFin","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		numero_final_xml_tag&.content = msg["numero_final"]
      	},
      	"//xs:inutNFe//xs:infInut//xs:xJust" => lambda{|msg,xml|
      		justificativa_xml_tag = xml.xpath("//xs:inutNFe//xs:infInut//xs:xJust","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		justificativa_xml_tag&.content = msg["justificativa"].nil? ? "Numeração não utilizada" : msg["justificativa"]
      	},
      	"//xs:consSitNFe//xs:tpAmb" => lambda{|msg,xml|
      		ambiente_xml_tag = xml.xpath("//xs:consSitNFe//xs:tpAmb","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		ambiente_xml_tag&.content = msg["ambiente"]
      	},
      	"//xs:consSitNFe//xs:chNFe" => lambda{|msg,xml|
      		chave_nota_xml_tag = xml.xpath("//xs:consSitNFe//xs:chNFe","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		chave_nota_xml_tag&.content = msg["chave_nota"]
      	},
      	"//xs:consStatServ//xs:tpAmb" => lambda{|msg,xml|
      		ambiente_xml_tag = xml.xpath("//xs:consStatServ//xs:tpAmb","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		ambiente_xml_tag&.content = msg["ambiente"]
      	},
      	"//xs:consStatServ//xs:cUF" => lambda{|msg,xml|
      		codigo_uf_xml_tag = xml.xpath("//xs:consStatServ//xs:cUF","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		codigo_uf_xml_tag&.content = msg["codigo_uf"]
      	},
      	"//xs:ConsCad//xs:infCons//xs:UF" => lambda{|msg,xml|
      		uf_xml_tag = xml.xpath("//xs:ConsCad//xs:infCons//xs:UF","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		uf_xml_tag&.content = msg["uf"]
      	},
      	"//xs:ConsCad//xs:infCons//xs:IE" => lambda{|msg,xml|
      		inscricao_estadual_xml_tag = xml.xpath("//xs:ConsCad//xs:infCons//xs:IE","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		inscricao_estadual_xml_tag&.content = msg["inscricao_estadual"]
      	},
      	"//xs:ConsCad//xs:infCons//xs:CNPJ" => lambda{|msg,xml|
      		cpf_cnpj_xml_tag = xml.xpath("//xs:ConsCad//xs:infCons//xs:CNPJ","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		cpf_cnpj_xml_tag&.content = msg["cpf_cnpj"] if msg["cpf_cnpj"]&.length == 14
      	},
      	"//xs:ConsCad//xs:infCons//xs:CPF" => lambda{|msg,xml|
      		cpf_cnpj_xml_tag = xml.xpath("//xs:ConsCad//xs:infCons//xs:CPF","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		cpf_cnpj_xml_tag&.content = msg["cpf_cnpj"] if msg["cpf_cnpj"]&.length == 11
      	},
      	"//xs:distDFeInt//xs:tpAmb" => lambda{|msg,xml|
      		ambiente_xml_tag = xml.xpath("//xs:distDFeInt//xs:tpAmb","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		ambiente_xml_tag&.content = msg["ambiente"]
      	},
      	"//xs:distDFeInt//xs:cUFAutor" => lambda{|msg,xml|
      		codigo_uf_autor_xml_tag = xml.xpath("//xs:distDFeInt//xs:cUFAutor","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		codigo_uf_autor_xml_tag&.content = msg["codigo_uf_autor"]
      	},
      	"//xs:distDFeInt//xs:CNPJ" => lambda{|msg,xml|
      		cpf_cnpj_xml_tag = xml.xpath("//xs:distDFeInt//xs:CNPJ","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		cpf_cnpj_xml_tag&.content = msg["cpf_cnpj"] if msg["cpf_cnpj"]&.length == 14
      	},
      	"//xs:distDFeInt//xs:CPF" => lambda{|msg,xml|
      		cpf_cnpj_xml_tag = xml.xpath("//xs:distDFeInt//xs:CPF","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		cpf_cnpj_xml_tag&.content = msg["cpf_cnpj"] if msg["cpf_cnpj"]&.length == 11
      	},
      	"//xs:distDFeInt//xs:distNSU//xs:ultNSU" => lambda{|msg,xml|
      		ultimo_nsu_xml_tag = xml.xpath("//xs:distDFeInt//xs:distNSU//xs:ultNSU","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		ultimo_nsu_xml_tag&.content = msg["ultimo_nsu"]
      	},
      	"//xs:distDFeInt//xs:consNSU//xs:NSU" => lambda{|msg,xml|
      		consulta_nsu_xml_tag = xml.xpath("//xs:distDFeInt//xs:consNSU//xs:NSU","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		consulta_nsu_xml_tag&.content = msg["consulta_nsu"]
      	},
      	"//xs:distDFeInt//xs:consChNFe//xs:chNFe" => lambda{|msg,xml|
      		chave_nota_xml_tag = xml.xpath("//xs:distDFeInt//xs:consChNFe//xs:chNFe","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		chave_nota_xml_tag&.content = msg["chave_nota"]
      	},
      	"//xs:envEvento//xs:idLote" => lambda{|msg,xml|
      		lote_xml_tag = xml.xpath("//xs:envEvento//xs:idLote","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		lote_xml_tag&.content = msg["lote"]
      	},
      	"//xs:envEvento//xs:evento//xs:infEvento//@Id" => lambda{|msg,xml|
      		id_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//@Id","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		id_xml_tag&.content = "ID"
          id_xml_tag&.content += "%06d" % msg["tipo_evento"]
          id_xml_tag&.content += msg["chave_nota"]
          id_xml_tag&.content += "%02d" % msg["sequencia"]
      	},
      	"//xs:envEvento//xs:evento//xs:infEvento//xs:cOrgao" => lambda{|msg,xml|
      		codigo_orgao_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:cOrgao","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		codigo_orgao_xml_tag&.content = msg["codigo_orgao"]
      	},
      	"//xs:envEvento//xs:evento//xs:infEvento//xs:tpAmb" => lambda{|msg,xml|
      		ambiente_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:tpAmb","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		ambiente_xml_tag&.content = msg["ambiente"]
      	},
      	"//xs:envEvento//xs:evento//xs:infEvento//xs:CNPJ" => lambda{|msg,xml|
      		cpf_cnpj_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:CNPJ","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		cpf_cnpj_xml_tag&.content = msg["cpf_cnpj"] if msg["cpf_cnpj"]&.length == 14
      	},
      	"//xs:envEvento//xs:evento//xs:infEvento//xs:CPF" => lambda{|msg,xml|
      		cpf_cnpj_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:CPF","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		cpf_cnpj_xml_tag&.content = msg["cpf_cnpj"] if msg["cpf_cnpj"]&.length == 11
      	},
      	"//xs:envEvento//xs:evento//xs:infEvento//xs:chNFe" => lambda{|msg,xml|
      		chave_nota_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:chNFe","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		chave_nota_xml_tag&.content = msg["chave_nota"]
      	},
      	"//xs:envEvento//xs:evento//xs:infEvento//xs:dhEvento" => lambda{|msg,xml|
      		dhEvento_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:dhEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		dhEvento_xml_tag&.content = Time.now.strftime("%Y-%m-%dT%T%:z") if !dhEvento_xml_tag.nil?
      	},
      	"//xs:envEvento//xs:evento//xs:infEvento//xs:tpEvento" => lambda{|msg,xml|
      		tipo_evento_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:tpEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		tipo_evento_xml_tag&.content = msg["tipo_evento"]
      	},
      	"//xs:envEvento//xs:evento//xs:infEvento//xs:nSeqEvento" => lambda{|msg,xml|
      		sequencia_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:nSeqEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		sequencia_xml_tag&.content = msg["sequencia"]
      	},
        "//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento" => lambda{|msg,xml|
          desc_evento_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:descEvento","xs" => "http://www.portalfiscal.inf.br/nfe").first
          desc_evento_xml_tag&.content = msg.dig("detalhes","descricao")
        },
      	"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:cOrgaoAutor" => lambda{|msg,xml|
      		codigo_orgao_autor_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:cOrgaoAutor","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		codigo_orgao_autor_xml_tag&.content = msg.dig("detalhes","codigo_orgao_autor")
      	},
      	"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpAutor" => lambda{|msg,xml|
      		tipo_autor_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpAutor","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		tipo_autor_xml_tag&.content = msg.dig("detalhes","tipo_autor")
      	},
      	"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:verAplic" => lambda{|msg,xml|
      		versao_aplicacao_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:verAplic","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		versao_aplicacao_xml_tag&.content = msg.dig("detalhes","versao_aplicacao")
      	},
      	"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:nProt" => lambda{|msg,xml|
      		protocolo_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:nProt","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		protocolo_xml_tag&.content = msg.dig("detalhes","protocolo")
      	},
      	"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xJust" => lambda{|msg,xml|
      		justificativa_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xJust","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		justificativa_xml_tag&.content = msg.dig("detalhes","justificativa")
      	},
      	"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:chNFeRef" => lambda{|msg,xml|
      		chave_nota_substituta_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:chNFeRef","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		chave_nota_substituta_xml_tag&.content = msg.dig("detalhes","chave_nota_substituta")
      	},
      	"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xCorrecao" => lambda{|msg,xml|
      		correcao_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xCorrecao","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		correcao_xml_tag&.content = msg.dig("detalhes","correcao")
      	},
      	"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dhEmi" => lambda{|msg,xml|
      		dhemi_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dhEmi","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		dhemi_xml_tag&.content = Time.now.strftime("%Y-%m-%dT%T%:z") if !dhemi_xml_tag.nil?
      	},
      	"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpNF" => lambda{|msg,xml|
      		tipo_nota_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpNF","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		tipo_nota_xml_tag&.content = msg.dig("detalhes","tipo_operacao")
      	},
      	"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:IE" => lambda{|msg,xml|
      		inscricao_estadual_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:IE","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		inscricao_estadual_xml_tag&.content = msg.dig("detalhes","inscricao_estadual")
      	},
      	"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest//xs:UF" => lambda{|msg,xml|
      		uf_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest//xs:UF","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		uf_xml_tag&.content = msg.dig("detalhes","destinatario","uf")
      	},
      	"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest//xs:CNPJ" => lambda{|msg,xml|
      		cpf_cnpj_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest//xs:CNPJ","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		cpf_cnpj_xml_tag&.content = msg.dig("detalhes","destinatario","cpf_cnpj") if msg.dig("detalhes","destinatario","cpf_cnpj")&.length == 14
      	},
      	"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest//xs:CPF" => lambda{|msg,xml|
      		cpf_cnpj_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest//xs:CPF","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		cpf_cnpj_xml_tag&.content = msg.dig("detalhes","destinatario","cpf_cnpj") if msg.dig("detalhes","destinatario","cpf_cnpj")&.length == 11
      	},
      	"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest//xs:idEstrangeiro" => lambda{|msg,xml|
      		id_estrangeiro_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest//xs:idEstrangeiro","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		id_estrangeiro_xml_tag&.content = msg.dig("detalhes","destinatario","id_estrangeiro")
      	},
      	"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest//xs:IE" => lambda{|msg,xml|
      		ie_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest//xs:IE","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		ie_xml_tag&.content = msg.dig("detalhes","destinatario","ie")
      	},
      	"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest//xs:vNF" => lambda{|msg,xml|
      		valor_total_nota_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest//xs:vNF","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		valor_total_nota_xml_tag&.content = "%.2f" % msg.dig("detalhes","destinatario","valor_nota")
      	},
      	"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest//xs:vICMS" => lambda{|msg,xml|
      		valor_total_icms_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest//xs:vICMS","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		valor_total_icms_xml_tag&.content = "%.2f" % msg.dig("detalhes","destinatario","valor_icms")
      	},
      	"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest//xs:vST" => lambda{|msg,xml|
      		valor_total_icms_st_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:dest//xs:vST","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		valor_total_icms_st_xml_tag&.content = "%.2f" % msg.dig("detalhes","destinatario","valor_icms_st")
      	},
      	"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:itemPedido" => lambda{|msg,xml|
      		itens_pedido = msg["itens_pedido"]
      		itens_pedido_xml_tags = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:itemPedido","xs" => "http://www.portalfiscal.inf.br/nfe")
      		itens_pedido_xml_tags&.each{|item_pedido| item_pedido.remove }
      		sibling_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:nProt","xs" => "http://www.portalfiscal.inf.br/nfe")

      		itens_pedido&.each do |item_pedido|
      			item_pedido_xml_tag = Nokogiri::XML("<itemPedido>").elements.first

      			ultimo_item_pedido_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:itemPedido","xs" => "http://www.portalfiscal.inf.br/nfe").last
      			if ultimo_item_pedido_xml_tag.nil?
      				sibling_xml_tag&.after(item_pedido_xml_tag)
      			else
      				ultimo_item_pedido_xml_tag&.after(item_pedido_xml_tag)
      			end
      		end
      	},
      	"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:itemPedido//@numItem" => lambda{|msg,xml|
      		itens_pedido = msg.dig("detalhes","itens_pedido")
      		item_pedido_xml_tags = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:itemPedido","xs" => "http://www.portalfiscal.inf.br/nfe")

      		item_pedido_xml_tags&.each_with_index do |item_pedido_xml_tag,index|
      			item_pedido_xml_tag["numItem"] = itens_pedido[index].dig("numero_item") if !itens_pedido.nil?
      		end
      	},
      	"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:itemPedido//xs:qtdeItem" => lambda{|msg,xml|
      		itens_pedido = msg.dig("detalhes","itens_pedido")
      		item_pedido_xml_tags = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:itemPedido","xs" => "http://www.portalfiscal.inf.br/nfe")

      		item_pedido_xml_tags&.each_with_index do |item_pedido_xml_tag,index|
      			quantidade_item_xml_tag = Nokogiri::XML("<qtdeItem>").elements.first
      			quantidade_item_xml_tag&.content = itens_pedido[index].dig("quantidade_item") if !itens_pedido.nil?
      			item_pedido_xml_tag&.add_child(quantidade_item_xml_tag)
      		end
      	},
      	"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:autXML//xs:CNPJ" => lambda{|msg,xml|
      		cpf_cnpj_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:autXML//xs:CNPJ","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		cpf_cnpj_xml_tag&.content = msg.dig("detalhes","cpf_cnpj_autorizado") if msg.dig("detalhes","cpf_cnpj_autorizado")&.length == 14
      	},
      	"//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:autXML//xs:CPF" => lambda{|msg,xml|
      		cpf_cnpj_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:autXML//xs:CPF","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		cpf_cnpj_xml_tag&.content = msg.dig("detalhes","cpf_cnpj_autorizado") if msg.dig("detalhes","cpf_cnpj_autorizado")&.length == 11
      	},
        "//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpAutorizacao" => lambda{|msg,xml|
          tipo_autorizacao_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:tpAutorizacao","xs" => "http://www.portalfiscal.inf.br/nfe").first
          tipo_autorizacao_xml_tag&.content = msg.dig("detalhes","tipo_autorizacao")
        },
        "//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xCondUso" => lambda{|msg,xml|
          condicao_uso_xml_tag = xml.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:detEvento//xs:xCondUso","xs" => "http://www.portalfiscal.inf.br/nfe").first
          condicao_uso_xml_tag&.content = msg.dig("detalhes","condicao_uso")
        },
      	"//xs:enviNFe//xs:NFe//xs:infNFe//@Id" => lambda{|msg,xml|
      		infnfe_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		
          if !infnfe_xml_tag.nil?
        		codigo_uf = msg["codigo_uf"]
        		ano_mes = "#{Time.now.strftime("%Y")[-2..-1]}#{Time.now.strftime("%m")}"
        		cpf_cnpj = "%014d" % msg.dig("emissor","cpf_cnpj").to_i
        		modelo = msg["modelo"].to_i
        		serie = "%03d" % msg["serie"].to_i
        		numero_documento = "%09d" % msg["numero_nota"].to_i
        		forma_emissao = "1"
        		codigo_numerico = "%06d" % msg["codigo_numerico"].to_i
        		chave = "#{codigo_uf}#{ano_mes}#{cpf_cnpj}#{modelo}#{serie}#{numero_documento}#{forma_emissao}#{codigo_numerico}"
        		pesos = [4,3,2] + [9,8,7,6,5,4,3,2] * 5
        		
        		digito_verificador = (11  - ((0..42).map{|indice| chave[indice].to_i * pesos[indice]}.sum % 11))
        		digito_verificador = [10,11].include?(digito_verificador) ? 0 : digito_verificador

        		infnfe_xml_tag["Id"] = "NFe#{chave}#{digito_verificador}"
          end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:cUF" => lambda{|msg,xml|
      		codigo_uf_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:cUF","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		codigo_uf_xml_tag&.content = msg["codigo_uf"]
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:cNF" => lambda{|msg,xml|
      		codigo_numerico_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:cNF","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		codigo_numerico_xml_tag&.content = msg["codigo_numerico"]
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:natOp" => lambda{|msg,xml|
      		natureza_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:natOp","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		natureza_xml_tag&.content = msg["natureza"]
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:mod" => lambda{|msg,xml|
      		modelo_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:mod","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		modelo_xml_tag&.content = msg["modelo"]
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:serie" => lambda{|msg,xml|
      		serie_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:serie","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		serie_xml_tag&.content = msg["serie"]
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:nNF" => lambda{|msg,xml|
      		numero_nota_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:nNF","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		numero_nota_xml_tag&.content = msg["numero_nota"]
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:dhEmi" => lambda{|msg,xml|
      		dhemi_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:dhEmi","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		dhemi_xml_tag&.content = Time.now.strftime("%Y-%m-%dT%T%:z") if !dhemi_xml_tag.nil?
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:dhSaiEnt" => lambda{|msg,xml|
      		dhsaient_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:dhSaiEnt","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		dhsaient_xml_tag&.content = Time.now.strftime("%Y-%m-%dT%T%:z") if !dhsaient_xml_tag.nil?
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:tpNF" => lambda{|msg,xml|
      		tipo_operacao_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:tpNF","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		tipo_operacao_xml_tag&.content = msg["tipo_operacao"]
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:idDest" => lambda{|msg,xml|
      		destino_operacao_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:idDest","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		
      		if msg.dig("emissor","uf") == msg.dig("destinatario","uf")
      			destino_operacao_xml_tag&.content = 1 if !destino_operacao_xml_tag.nil?
      		elsif  msg.dig("emissor","cpais") == msg.dig("destinatario","cpais")
      			destino_operacao_xml_tag&.content = 2 if !destino_operacao_xml_tag.nil?
      		else
      			destino_operacao_xml_tag&.content = 3 if !destino_operacao_xml_tag.nil?
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:cMunFG" => lambda{|msg,xml|
      		codigo_municipio_fato_gerador_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:cMunFG","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		codigo_municipio_fato_gerador_xml_tag&.content = msg.dig("emissor","codigo_municipio")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:tpImp" => lambda{|msg,xml|
      		formato_impressao_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:tpImp","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		formato_impressao_xml_tag&.content = 1 if !formato_impressao_xml_tag.nil?
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:tpEmis" => lambda{|msg,xml|
      		tipo_emissao_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:tpEmis","xs" => "http://www.portalfiscal.inf.br/nfe").first

      		if !msg["justificativa_contingencia"].nil?
      			if msg["modelo"] == "55"
      				tipo_emissao_xml_tag&.content = !msg["justificativa_contingencia"].nil? ? 1 : 9
      			elsif msg["modelo"] == "65"
      				tipo_emissao_xml_tag&.content = !msg["justificativa_contingencia"].nil? ? 1 : 9
      			end
      		else
      			tipo_emissao_xml_tag&.content = 1
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:cDV" => lambda{|msg,xml|
      		infnfe_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		cdv_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:cDV","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		cdv_xml_tag&.content = infnfe_xml_tag["Id"][-1]
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:tpAmb" => lambda{|msg,xml|
      		ambiente_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:tpAmb","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		ambiente_xml_tag&.content = msg["ambiente"]
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:finNFe" => lambda{|msg,xml|
      		finalidade_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:finNFe","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		finalidade_xml_tag&.content = msg["finalidade"]
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:indFinal" => lambda{|msg,xml|
      		consumidor_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:indFinal","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		consumidor_xml_tag&.content = msg["consumidor"]
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:indPres" => lambda{|msg,xml|
      		indicador_presencial_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:indPres","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		indicador_presencial_xml_tag&.content = msg["indicador_presencial"]
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:procEmi" => lambda{|msg,xml|
      		processo_emissao_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:procEmi","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		processo_emissao_xml_tag&.content = 0  	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:verProc" => lambda{|msg,xml|
      		versao_aplicacao_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:verProc","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		versao_aplicacao_xml_tag&.content = msg["versao_aplicacao"]
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:dhCont" => lambda{|msg,xml|
      		data_contingencia_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:dhCont","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		data_contingencia_xml_tag&.content = Time.now.strftime("%Y-%m-%dT%T%:z") if !msg["justificativa_contingencia"].nil?
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:xJust" => lambda{|msg,xml|
      		justificativa_contingencia_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:xJust","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		justificativa_contingencia_xml_tag&.content = msg["justificativa_contingencia"]
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref" => lambda{|msg,xml| 
      		justificativa_contingencia_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:xJust","xs" => "http://www.portalfiscal.inf.br/nfe")
      		nfref_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref","xs" => "http://www.portalfiscal.inf.br/nfe")
      		nfref_xml_tags&.each{|nfref_xml_tag| nfref_xml_tag.remove }

      		notas_referenciadas = msg["notas_referenciadas"]

      		notas_referenciadas&.each do |nota|
      			nota_referenciada_xml_tag = Nokogiri::XML("<NFref>").elements.first
      			justificativa_contingencia_xml_tag&.after(nota_referenciada_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNFe" => lambda{|msg,xml|
      		nfref_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref","xs" => "http://www.portalfiscal.inf.br/nfe")

      		notas_referenciadas = msg["notas_referenciadas"]

      		nfref_xml_tags&.each_with_index do |nfref_xml_tag,index|
      			refnfe_present = !notas_referenciadas[index]["chave_nota_referenciada"].nil?
      			refnfe_xml_tag = Nokogiri::XML("<refNFe>").elements.first
      			refnfe_xml_tag&.content = notas_referenciadas[index].dig("chave_nota_referenciada")
      			nfref_xml_tag&.add_child(refnfe_xml_tag) if refnfe_present
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNF" => lambda{|msg,xml|
      		nfref_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref","xs" => "http://www.portalfiscal.inf.br/nfe")

      		notas_referenciadas = msg["notas_referenciadas"]

      		nfref_xml_tags&.each_with_index do |nfref_xml_tag,index|
      			refnf_present = !notas_referenciadas[index]["codigo_uf_referenciado"].nil? and 
      											!notas_referenciadas[index]["ano_mes_referenciado"].nil? and
      											!notas_referenciadas[index]["cpf_cnpj_referenciado"].nil? and
      											!notas_referenciadas[index]["modelo_referenciado"].nil? and
      											!notas_referenciadas[index]["serie_referenciada"].nil? and
      											!notas_referenciadas[index]["numero_documento_referenciado"].nil?

      			refnf_xml_tag = Nokogiri::XML("<refNF>").elements.first
      			nfref_xml_tag&.add_child(refnf_xml_tag) if refnf_present
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNF//xs:cUF" => lambda{|msg,xml|
      		nfref_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref","xs" => "http://www.portalfiscal.inf.br/nfe")

      		notas_referenciadas = msg["notas_referenciadas"]

      		nfref_xml_tags&.each_with_index do |nfref_xml_tag,index|
      			refnf_xml_tag = nfref_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNF","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			
      			if !refnf_xml_tag.nil?
      				codigo_uf_referenciado_xml_tag = Nokogiri::XML("<cUF>").elements.first
      				codigo_uf_referenciado_xml_tag&.content = notas_referenciadas[index]["codigo_uf_referenciado"]
      				refnf_xml_tag&.add_child(codigo_uf_referenciado_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNF//xs:AAMM" => lambda{|msg,xml|
      		nfref_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref","xs" => "http://www.portalfiscal.inf.br/nfe")

      		notas_referenciadas = msg["notas_referenciadas"]

      		nfref_xml_tags&.each_with_index do |nfref_xml_tag,index|
      			refnf_xml_tag = nfref_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNF","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			
      			if !refnf_xml_tag.nil?
      				ano_mes_referenciado_xml_tag = Nokogiri::XML("<AAMM>").elements.first
      				ano_mes_referenciado_xml_tag&.content = notas_referenciadas[index]["ano_mes_referenciado"]
      				refnf_xml_tag&.add_child(ano_mes_referenciado_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNF//xs:CNPJ" => lambda{|msg,xml|
      		nfref_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref","xs" => "http://www.portalfiscal.inf.br/nfe")

      		notas_referenciadas = msg["notas_referenciadas"]

      		nfref_xml_tags&.each_with_index do |nfref_xml_tag,index|
      			refnf_xml_tag = nfref_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNF","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			
      			if !refnf_xml_tag.nil?
      				cpf_cnpj_referenciado_xml_tag = Nokogiri::XML("<CNPJ>").elements.first
      				cpf_cnpj_referenciado_xml_tag&.content = notas_referenciadas[index]["cpf_cnpj_referenciado"]
      				refnf_xml_tag&.add_child(cpf_cnpj_referenciado_xml_tag) if notas_referenciadas[index]["cpf_cnpj_referenciado"]&.length == 14
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNF//xs:mod" => lambda{|msg,xml|
      		nfref_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref","xs" => "http://www.portalfiscal.inf.br/nfe")

      		notas_referenciadas = msg["notas_referenciadas"]

      		nfref_xml_tags&.each_with_index do |nfref_xml_tag,index|
      			refnf_xml_tag = nfref_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNF","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			
      			if !refnf_xml_tag.nil?
      				modelo_referenciado_xml_tag = Nokogiri::XML("<mod>").elements.first
      				modelo_referenciado_xml_tag&.content = notas_referenciadas[index]["modelo_referenciado"]
      				refnf_xml_tag&.add_child(modelo_referenciado_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNF//xs:serie" => lambda{|msg,xml|
      		nfref_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref","xs" => "http://www.portalfiscal.inf.br/nfe")

      		notas_referenciadas = msg["notas_referenciadas"]

      		nfref_xml_tags&.each_with_index do |nfref_xml_tag,index|
      			refnf_xml_tag = nfref_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNF","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			
      			if !refnf_xml_tag.nil?
      				serie_referenciada_xml_tag = Nokogiri::XML("<serie>").elements.first
      				serie_referenciada_xml_tag&.content = notas_referenciadas[index]["serie_referenciada"]
      				refnf_xml_tag&.add_child(serie_referenciada_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNF//xs:nNF" => lambda{|msg,xml|
      		nfref_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref","xs" => "http://www.portalfiscal.inf.br/nfe")

      		notas_referenciadas = msg["notas_referenciadas"]

      		nfref_xml_tags&.each_with_index do |nfref_xml_tag,index|
      			refnf_xml_tag = nfref_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNF","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			
      			if !refnf_xml_tag.nil?
      				numero_documento_referenciado_xml_tag = Nokogiri::XML("<nNF>").elements.first
      				numero_documento_referenciado_xml_tag&.content = notas_referenciadas[index]["numero_documento_referenciado"]
      				refnf_xml_tag&.add_child(numero_documento_referenciado_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNFP" => lambda{|msg,xml|
      		nfref_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref","xs" => "http://www.portalfiscal.inf.br/nfe")

      		notas_referenciadas = msg["notas_referenciadas"]

      		nfref_xml_tags&.each_with_index do |nfref_xml_tag,index|
      			refnfp_present = !notas_referenciadas[index]["codigo_uf_referenciado"].nil? and 
      											 !notas_referenciadas[index]["ano_mes_referenciado"].nil? and
      											 !notas_referenciadas[index]["cpf_cnpj_referenciado"].nil? and
      											 !notas_referenciadas[index]["inscricao_estadual_referenciada"].nil? and
      											 !notas_referenciadas[index]["modelo_referenciado"].nil? and
      											 !notas_referenciadas[index]["serie_referenciada"].nil? and
      											 !notas_referenciadas[index]["numero_documento_referenciado"].nil?

      			refnfp_xml_tag = Nokogiri::XML("<refNFP>").elements.first
      			nfref_xml_tag&.add_child(refnfp_xml_tag) if refnfp_present
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNFP//xs:cUF" => lambda{|msg,xml|
      		nfref_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref","xs" => "http://www.portalfiscal.inf.br/nfe")

      		notas_referenciadas = msg["notas_referenciadas"]

      		nfref_xml_tags&.each_with_index do |nfref_xml_tag,index|
      			refnfp_xml_tag = nfref_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNFP","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			
      			if !refnfp_xml_tag.nil?
      				codigo_uf_referenciado_xml_tag = Nokogiri::XML("<cUF>").elements.first
      				codigo_uf_referenciado_xml_tag&.content = notas_referenciadas[index]["codigo_uf_referenciado"]
      				refnfp_xml_tag&.add_child(codigo_uf_referenciado_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNFP//xs:AAMM" => lambda{|msg,xml|
      		nfref_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref","xs" => "http://www.portalfiscal.inf.br/nfe")

      		notas_referenciadas = msg["notas_referenciadas"]

      		nfref_xml_tags&.each_with_index do |nfref_xml_tag,index|
      			refnfp_xml_tag = nfref_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNFP","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			
      			if !refnfp_xml_tag.nil?
      				ano_mes_referenciado_xml_tag = Nokogiri::XML("<AAMM>").elements.first
      				ano_mes_referenciado_xml_tag&.content = notas_referenciadas[index]["ano_mes_referenciado"]
      				refnfp_xml_tag&.add_child(ano_mes_referenciado_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNFP//xs:CNPJ" => lambda{|msg,xml|
      		nfref_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref","xs" => "http://www.portalfiscal.inf.br/nfe")

      		notas_referenciadas = msg["notas_referenciadas"]

      		nfref_xml_tags&.each_with_index do |nfref_xml_tag,index|
      			refnfp_xml_tag = nfref_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNFP","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			
      			if !refnfp_xml_tag.nil?
      				cpf_cnpj_referenciado_xml_tag = Nokogiri::XML("<CNPJ>").elements.first
      				cpf_cnpj_referenciado_xml_tag&.content = notas_referenciadas[index]["cpf_cnpj_referenciado"]
      				refnfp_xml_tag&.add_child(cpf_cnpj_referenciado_xml_tag) if notas_referenciadas[index]["cpf_cnpj_referenciado"]&.length == 14
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNFP//xs:CPF" => lambda{|msg,xml|
      		nfref_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref","xs" => "http://www.portalfiscal.inf.br/nfe")

      		notas_referenciadas = msg["notas_referenciadas"]

      		nfref_xml_tags&.each_with_index do |nfref_xml_tag,index|
      			refnfp_xml_tag = nfref_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNFP","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			
      			if !refnfp_xml_tag.nil?
      				cpf_cnpj_referenciado_xml_tag = Nokogiri::XML("<CPF>").elements.first
      				cpf_cnpj_referenciado_xml_tag&.content = notas_referenciadas[index]["cpf_cnpj_referenciado"]
      				refnfp_xml_tag&.add_child(cpf_cnpj_referenciado_xml_tag) if notas_referenciadas[index]["cpf_cnpj_referenciado"]&.length == 11
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNFP//xs:IE" => lambda{|msg,xml|
      		nfref_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref","xs" => "http://www.portalfiscal.inf.br/nfe")

      		notas_referenciadas = msg["notas_referenciadas"]

      		nfref_xml_tags&.each_with_index do |nfref_xml_tag,index|
      			refnfp_xml_tag = nfref_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNFP","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			
      			if !refnfp_xml_tag.nil?
      				inscricao_estadual_referenciada_xml_tag = Nokogiri::XML("<IE>").elements.first
      				inscricao_estadual_referenciada_xml_tag&.content = notas_referenciadas[index]["inscricao_estadual_referenciada"]
      				refnfp_xml_tag&.add_child(inscricao_estadual_referenciada_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNFP//xs:mod" => lambda{|msg,xml|
      		nfref_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref","xs" => "http://www.portalfiscal.inf.br/nfe")

      		notas_referenciadas = msg["notas_referenciadas"]

      		nfref_xml_tags&.each_with_index do |nfref_xml_tag,index|
      			refnfp_xml_tag = nfref_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNFP","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			
      			if !refnfp_xml_tag.nil?
      				modelo_referenciado_xml_tag = Nokogiri::XML("<mod>").elements.first
      				modelo_referenciado_xml_tag&.content = notas_referenciadas[index]["modelo_referenciado"]
      				refnfp_xml_tag&.add_child(modelo_referenciado_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNFP//xs:serie" => lambda{|msg,xml|
      		nfref_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref","xs" => "http://www.portalfiscal.inf.br/nfe")

      		notas_referenciadas = msg["notas_referenciadas"]

      		nfref_xml_tags&.each_with_index do |nfref_xml_tag,index|
      			refnfp_xml_tag = nfref_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNFP","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			
      			if !refnfp_xml_tag.nil?
      				serie_referenciada_xml_tag = Nokogiri::XML("<serie>").elements.first
      				serie_referenciada_xml_tag&.content = notas_referenciadas[index]["serie_referenciada"]
      				refnfp_xml_tag&.add_child(serie_referenciada_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNFP//xs:nNF" => lambda{|msg,xml|
      		nfref_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref","xs" => "http://www.portalfiscal.inf.br/nfe")

      		notas_referenciadas = msg["notas_referenciadas"]

      		nfref_xml_tags&.each_with_index do |nfref_xml_tag,index|
      			refnfp_xml_tag = nfref_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refNFP","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			
      			if !refnfp_xml_tag.nil?
      				numero_documento_referenciado_xml_tag = Nokogiri::XML("<nNF>").elements.first
      				numero_documento_referenciado_xml_tag&.content = notas_referenciadas[index]["numero_documento_referenciado"]
      				refnfp_xml_tag&.add_child(numero_documento_referenciado_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refCTe" => lambda{|msg,xml|
      		nfref_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref","xs" => "http://www.portalfiscal.inf.br/nfe")

      		notas_referenciadas = msg["notas_referenciadas"]

      		nfref_xml_tags&.each_with_index do |nfref_xml_tag,index|
      			refcte_tag_xml = Nokogiri::XML("<refCTe>").elements.first
      			refcte_tag_xml&.content = notas_referenciadas[index]["chave_cte"]
      			nfref_xml_tag&.add_child(refcte_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refECF" => lambda{|msg,xml|
      		nfref_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref","xs" => "http://www.portalfiscal.inf.br/nfe")

      		notas_referenciadas = msg["notas_referenciadas"]

      		nfref_xml_tags&.each_with_index do |nfref_xml_tag,index|
      			refecf_present = !notas_referenciadas[index]["modelo_referenciado"].nil? and
      											 !notas_referenciadas[index]["numero_ecf"].nil? and
      											 !notas_referenciadas[index]["numero_coo"].nil?

      			refecf_xml_tag = Nokogiri::XML("<refECF>").elements.first
      			nfref_xml_tag&.add_child(refecf_xml_tag) if refecf_present
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refECF//xs:mod" => lambda{|msg,xml|
      		nfref_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref","xs" => "http://www.portalfiscal.inf.br/nfe")

      		notas_referenciadas = msg["notas_referenciadas"]

      		nfref_xml_tags&.each_with_index do |nfref_xml_tag,index|
      			refecf_xml_tag = nfref_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refECF","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			
      			if !refecf_xml_tag.nil?
      				modelo_referenciado_xml_tag = Nokogiri::XML("<mod>").elements.first
      				modelo_referenciado_xml_tag&.content = notas_referenciadas[index]["modelo_referenciado"]
      				refecf_xml_tag&.add_child(modelo_referenciado_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refECF//xs:nECF" => lambda{|msg,xml|
      		nfref_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref","xs" => "http://www.portalfiscal.inf.br/nfe")

      		notas_referenciadas = msg["notas_referenciadas"]

      		nfref_xml_tags&.each_with_index do |nfref_xml_tag,index|
      			refecf_xml_tag = nfref_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refECF","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			
      			if !refecf_xml_tag.nil?
      				numero_ecf_xml_tag = Nokogiri::XML("<nECF>").elements.first
      				numero_ecf_xml_tag&.content = notas_referenciadas[index]["numero_ecf"]
      				refecf_xml_tag&.add_child(numero_ecf_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refECF//xs:nCOO" => lambda{|msg,xml|
      		nfref_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref","xs" => "http://www.portalfiscal.inf.br/nfe")

      		notas_referenciadas = msg["notas_referenciadas"]

      		nfref_xml_tags&.each_with_index do |nfref_xml_tag,index|
      			refecf_xml_tag = nfref_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:NFref//xs:refECF","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			
      			if !refecf_xml_tag.nil?
      				numero_coo_xml_tag = Nokogiri::XML("<nCOO>").elements.first
      				numero_coo_xml_tag&.content = notas_referenciadas[index]["numero_coo"]
      				refecf_xml_tag&.add_child(numero_coo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:CNPJ" => lambda{|msg,xml|
      		cpf_cnpj_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:CNPJ","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		cpf_cnpj_xml_tag&.content = msg.dig("emissor","cpf_cnpj") if msg.dig("emissor","cpf_cnpj")&.length == 14
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:CPF" => lambda{|msg,xml|
      		cpf_cnpj_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:CPF","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		cpf_cnpj_xml_tag&.content = msg.dig("emissor","cpf_cnpj") if msg.dig("emissor","cpf_cnpj")&.length == 11
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:xNome" => lambda{|msg,xml|
      		nome_razao_social_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:xNome","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		nome_razao_social_xml_tag&.content = msg.dig("emissor","nome_razao_social")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:xFant" => lambda{|msg,xml|
      		nome_fantasia_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:xFant","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		nome_fantasia_xml_tag&.content = msg.dig("emissor","nome_fantasia")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:enderEmit//xs:xLgr" => lambda{|msg,xml|
      		logradouro_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:enderEmit//xs:xLgr","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		logradouro_xml_tag&.content = msg.dig("emissor","logradouro")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:enderEmit//xs:nro" => lambda{|msg,xml|
      		numero_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:enderEmit//xs:nro","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		numero_xml_tag&.content = msg.dig("emissor","numero")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:enderEmit//xs:xCpl" => lambda{|msg,xml|
      		complemento_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:enderEmit//xs:xCpl","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		complemento_xml_tag&.content = msg.dig("emissor","complemento")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:enderEmit//xs:xBairro" => lambda{|msg,xml|
      		bairro_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:enderEmit//xs:xBairro","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		bairro_xml_tag&.content = msg.dig("emissor","bairro")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:enderEmit//xs:cMun" => lambda{|msg,xml|
      		codigo_municipio_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:enderEmit//xs:cMun","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		codigo_municipio_xml_tag&.content = msg.dig("emissor","codigo_municipio")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:enderEmit//xs:xMun" => lambda{|msg,xml|
      		nome_municipio_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:enderEmit//xs:xMun","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		nome_municipio_xml_tag&.content = msg.dig("emissor","nome_municipio")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:enderEmit//xs:UF" => lambda{|msg,xml|
      		uf_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:enderEmit//xs:UF","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		uf_xml_tag&.content = msg.dig("emissor","uf")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:enderEmit//xs:CEP" => lambda{|msg,xml|
      		cep_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:enderEmit//xs:CEP","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		cep_xml_tag&.content = msg.dig("emissor","cep")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:enderEmit//xs:xPais" => lambda{|msg,xml|
      		nome_pais_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:enderEmit//xs:xPais","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		nome_pais_xml_tag&.content = 'BRASIL'
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:enderEmit//xs:fone" => lambda{|msg,xml|
      		fone_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:enderEmit//xs:fone","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		fone_xml_tag&.content = msg.dig("emissor","fone")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:IE" => lambda{|msg,xml|
      		inscricao_estadual_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:IE","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		inscricao_estadual_xml_tag&.content = msg.dig("emissor","inscricao_estadual")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:IEST" => lambda{|msg,xml|
      		incricao_estadual_substituto_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:IEST","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		incricao_estadual_substituto_xml_tag&.content = msg.dig("emissor","incricao_estadual_substituto")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:IM" => lambda{|msg,xml|
      		inscricao_municipal_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:IM","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		inscricao_municipal_xml_tag&.content = msg.dig("emissor","inscricao_municipal")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:CNAE" => lambda{|msg,xml|
      		cnae_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:CNAE","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		cnae_xml_tag&.content = msg.dig("emissor","cnae")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:CRT" => lambda{|msg,xml|
      		regime_tributario_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:CRT","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		regime_tributario_xml_tag&.content = msg.dig("emissor","regime_tributario")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:CNPJ" => lambda{|msg,xml|
      		cpf_cnpj_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:CNPJ","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		cpf_cnpj_xml_tag&.content = msg.dig("destinatario","cpf_cnpj") if msg.dig("destinatario","cpf_cnpj")&.length == 14
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:CPF" => lambda{|msg,xml|
      		cpf_cnpj_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:CPF","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		cpf_cnpj_xml_tag&.content = msg.dig("destinatario","cpf_cnpj") if msg.dig("destinatario","cpf_cnpj")&.length == 11
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:idEstrangeiro" => lambda{|msg,xml|
      		id_estrangeiro_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:idEstrangeiro","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		id_estrangeiro_xml_tag&.content = msg.dig("destinatario","id_estrangeiro")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:xNome" => lambda{|msg,xml|
      		nome_razao_social_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:xNome","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		nome_razao_social_xml_tag&.content = msg.dig("destinatario","nome_razao_social")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:enderDest//xs:xLgr" => lambda{|msg,xml|
      		logradouro_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:enderDest//xs:xLgr","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		logradouro_xml_tag&.content = msg.dig("destinatario","logradouro")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:enderDest//xs:nro" => lambda{|msg,xml|
      		numero_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:enderDest//xs:nro","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		numero_xml_tag&.content = msg.dig("destinatario","numero")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:enderDest//xs:xCpl" => lambda{|msg,xml|
      		complemento_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:enderDest//xs:xCpl","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		complemento_xml_tag&.content = msg.dig("destinatario","complemento")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:enderDest//xs:xBairro" => lambda{|msg,xml|
      		bairro_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:enderDest//xs:xBairro","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		bairro_xml_tag&.content = msg.dig("destinatario","bairro")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:enderDest//xs:cMun" => lambda{|msg,xml|
      		codigo_municipio_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:enderDest//xs:cMun","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		codigo_municipio_xml_tag&.content = msg.dig("destinatario","codigo_municipio")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:enderDest//xs:xMun" => lambda{|msg,xml|
      		nome_municipio_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:enderDest//xs:xMun","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		nome_municipio_xml_tag&.content = msg.dig("destinatario","nome_municipio")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:enderDest//xs:UF" => lambda{|msg,xml|
      		uf_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:enderDest//xs:UF","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		uf_xml_tag&.content = msg.dig("destinatario","uf")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:enderDest//xs:CEP" => lambda{|msg,xml|
      		cep_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:enderDest//xs:CEP","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		cep_xml_tag&.content = msg.dig("destinatario","cep")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:enderDest//xs:cPais" => lambda{|msg,xml|
      		codigo_pais_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:enderDest//xs:cPais","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		codigo_pais_xml_tag&.content = msg.dig("destinatario","codigo_pais")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:enderDest//xs:xPais" => lambda{|msg,xml|
      		nome_pais_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:enderDest//xs:xPais","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		nome_pais_xml_tag&.content = msg.dig("destinatario","nome_pais")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:enderDest//xs:fone" => lambda{|msg,xml|
      		fone_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:enderDest//xs:fone","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		fone_xml_tag&.content = msg.dig("destinatario","fone")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:indIEDest" => lambda{|msg,xml|
      		contribuinte_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:indIEDest","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		contribuinte_xml_tag&.content = msg.dig("destinatario","contribuinte")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:IE" => lambda{|msg,xml|
      		inscricao_estadual_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:IE","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		inscricao_estadual_xml_tag&.content = msg.dig("destinatario","inscricao_estadual")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:ISUF" => lambda{|msg,xml|
      		inscricao_suframa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:ISUF","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		inscricao_suframa_xml_tag&.content = msg.dig("destinatario","inscricao_suframa")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:IM" => lambda{|msg,xml|
      		inscricao_municipal_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:IM","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		inscricao_municipal_xml_tag&.content = msg.dig("destinatario","inscricao_municipal")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:email" => lambda{|msg,xml|
      		email_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:dest//xs:email","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		email_xml_tag&.content = msg.dig("destinatario","email")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:retirada//xs:CNPJ" => lambda{|msg,xml|
      		cpf_cnpj_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:retirada//xs:CNPJ","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		cpf_cnpj_xml_tag&.content = msg.dig("retirada","cpf_cnpj") if msg.dig("retirada","cpf_cnpj")&.length == 14
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:retirada//xs:CPF" => lambda{|msg,xml|
      		cpf_cnpj_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:retirada//xs:CPF","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		cpf_cnpj_xml_tag&.content = msg.dig("retirada","cpf_cnpj") if msg.dig("retirada","cpf_cnpj")&.length == 11
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:retirada//xs:xLgr" => lambda{|msg,xml|
      		logradouro_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:retirada//xs:xLgr","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		logradouro_xml_tag&.content = msg.dig("retirada","logradouro")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:retirada//xs:nro" => lambda{|msg,xml|
      		numero_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:retirada//xs:nro","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		numero_xml_tag&.content = msg.dig("retirada","numero")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:retirada//xs:xCpl" => lambda{|msg,xml|
      		complemento_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:retirada//xs:xCpl","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		complemento_xml_tag&.content = msg.dig("retirada","complemento")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:retirada//xs:xBairro" => lambda{|msg,xml|
      		bairro_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:retirada//xs:xBairro","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		bairro_xml_tag&.content = msg.dig("retirada","bairro")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:retirada//xs:cMun" => lambda{|msg,xml|
      		codigo_municipio_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:retirada//xs:cMun","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		codigo_municipio_xml_tag&.content = msg.dig("retirada","codigo_municipio")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:retirada//xs:xMun" => lambda{|msg,xml|
      		nome_municipio_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:retirada//xs:xMun","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		nome_municipio_xml_tag&.content = msg.dig("retirada","nome_municipio")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:retirada//xs:UF" => lambda{|msg,xml|
      		uf_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:retirada//xs:UF","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		uf_xml_tag&.content = msg.dig("retirada","uf")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:entrega//xs:CNPJ" => lambda{|msg,xml|
      		cpf_cnpj_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:entrega//xs:CNPJ","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		cpf_cnpj_xml_tag&.content = msg.dig("entrega","cpf_cnpj") if msg.dig("entrega","cpf_cnpj")&.length == 14
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:entrega//xs:CPF" => lambda{|msg,xml|
      		cpf_cnpj_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:entrega//xs:CPF","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		cpf_cnpj_xml_tag&.content = msg.dig("entrega","cpf_cnpj") if msg.dig("entrega","cpf_cnpj")&.length == 11
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:entrega//xs:xLgr" => lambda{|msg,xml|
      		logradouro_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:entrega//xs:xLgr","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		logradouro_xml_tag&.content = msg.dig("entrega","logradouro")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:entrega//xs:nro" => lambda{|msg,xml|
      		numero_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:entrega//xs:nro","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		numero_xml_tag&.content = msg.dig("entrega","numero")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:entrega//xs:xCpl" => lambda{|msg,xml|
      		complemento_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:entrega//xs:xCpl","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		complemento_xml_tag&.content = msg.dig("entrega","complemento")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:entrega//xs:xBairro" => lambda{|msg,xml|
      		bairro_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:entrega//xs:xBairro","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		bairro_xml_tag&.content = msg.dig("entrega","bairro")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:entrega//xs:cMun" => lambda{|msg,xml|
      		codigo_municipio_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:entrega//xs:cMun","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		codigo_municipio_xml_tag&.content = msg.dig("entrega","codigo_municipio")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:entrega//xs:xMun" => lambda{|msg,xml|
      		nome_municipio_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:entrega//xs:xMun","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		nome_municipio_xml_tag&.content = msg.dig("entrega","nome_municipio")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:entrega//xs:UF" => lambda{|msg,xml|
      		uf_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:entrega//xs:UF","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		uf_xml_tag&.content = msg.dig("entrega","uf")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:autXML" => lambda{|msg,xml|
      		autorizacoes_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:autXML","xs" => "http://www.portalfiscal.inf.br/nfe")
      		autorizacoes_xml_tags&.each{|autorizacao_xml_tag| autorizacao_xml_tag.remove }
          autorizacoes = msg["autorizacoes"]

      		sibling_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		
      		autorizacoes&.each do |autorizacao|
      			autorizacao_xml_tag = Nokogiri::XML("<autXML>").elements.first
      			sibling_xml_tag.before(autorizacao_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:autXML//xs:CNPJ" => lambda{|msg,xml|
      		autorizacoes_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:autXML","xs" => "http://www.portalfiscal.inf.br/nfe")
      		
      		autorizacoes = msg["autorizacoes"]

      		autorizacoes_xml_tags&.each_with_index do |autorizacao_xml_tag,index|
      			cpf_cnpj_xml_tag = Nokogiri::XML("<CNPJ>").elements.first
      			cpf_cnpj_xml_tag&.content = autorizacoes[index]["cpf_cnpj"]
      			autorizacao_xml_tag&.add_child(cpf_cnpj_xml_tag) if autorizacoes[index]["cpf_cnpj"]&.length == 14
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:autXML//xs:CPF" => lambda{|msg,xml|
      		autorizacoes_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:autXML","xs" => "http://www.portalfiscal.inf.br/nfe")
      		
      		autorizacoes = msg["autorizacoes"]

      		autorizacoes_xml_tags&.each_with_index do |autorizacao_xml_tag,index|
      			cpf_cnpj_xml_tag = Nokogiri::XML("<CPF>").elements.first
      			cpf_cnpj_xml_tag&.content = autorizacoes[index]["cpf_cnpj"]
      			autorizacao_xml_tag&.add_child(cpf_cnpj_xml_tag) if autorizacoes[index]["cpf_cnpj"]&.length == 11
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det" => lambda{|msg,xml|
      		det_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det","xs" => "http://www.portalfiscal.inf.br/nfe")
      		det_xml_tags&.each{|det| det.remove }

      		total_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:total","xs" => "http://www.portalfiscal.inf.br/nfe").last

      		produtos = msg["produtos"]

      		produtos&.each_with_index do |produto,produto_index|
      			det_xml_tag = Nokogiri::XML("<det>").elements.first
      			det_xml_tag["nItem"] = produto_index+1
      			
      			total_xml_tag&.before(det_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod" => lambda{|msg,xml|
      		det_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det","xs"=>"http://www.portalfiscal.inf.br/nfe")

      		det_xml_tags&.each do |det_xml_tag,det_index|
      			prod_xml_tag = Nokogiri::XML("<prod>").elements.first
      			det_xml_tag&.add_child(prod_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:cProd" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      		produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			codigo_produto_xml_tag = Nokogiri::XML("<cProd>").elements.first
      			codigo_produto_xml_tag&.content = produtos[index]["codigo_produto"]
      			produto_xml_tag&.add_child(codigo_produto_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:cEAN" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			cean_xml_tag = Nokogiri::XML("<cEAN>").elements.first
      			cean_xml_tag&.content = produtos[index]["cean"].nil? ? "SEM GTIN" : produtos[index]["cean"]
      			produto_xml_tag&.add_child(cean_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:xProd" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			descricao_produto_xml_tag = Nokogiri::XML("<xProd>").elements.first
      			descricao_produto_xml_tag&.content = produtos[index]["descricao_produto"]
      			produto_xml_tag&.add_child(descricao_produto_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:NCM" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			ncm_xml_tag = Nokogiri::XML("<NCM>").elements.first
      			ncm_xml_tag&.content = produtos[index]["ncm"]
      			produto_xml_tag&.add_child(ncm_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:NVE" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			nve_xml_tags = Nokogiri::XML("<NVE>").elements.first
      			
      			nve_xml_tags&.each_with_index do |nve_xml_tag,nve_index|
      				nve_xml_tag&.content = produtos[index]["nve"][nve_index]["codigo"]
      				produto_xml_tag&.add_child(nve_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:CEST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			cest_xml_tag = Nokogiri::XML("<CEST>").elements.first
      			cest_xml_tag&.content = produtos[index]["cest"]
      			produto_xml_tag&.add_child(cest_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:indEscala" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			indicador_escala_xml_tag = Nokogiri::XML("<indEscala>").elements.first
      			indicador_escala_xml_tag&.content = produtos[index]["indicador_escala"]
      			produto_xml_tag&.add_child(indicador_escala_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:CNPJFab" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			cnpj_fabricante_xml_tag = Nokogiri::XML("<CNPJFab>").elements.first
      			cnpj_fabricante_xml_tag&.content = produtos[index]["cnpj_fabricante"]
      			produto_xml_tag&.add_child(cnpj_fabricante_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:EXTIPI" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			extipi_xml_tag = Nokogiri::XML("<EXTIPI>").elements.first
      			extipi_xml_tag&.content = produtos[index]["extipi"]
      			produto_xml_tag&.add_child(extipi_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:CFOP" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			cfop_xml_tag = Nokogiri::XML("<CFOP>").elements.first
      			cfop_xml_tag&.content = produtos[index]["cfop"]
      			produto_xml_tag&.add_child(cfop_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:uCom" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			unidade_comercial_xml_tag = Nokogiri::XML("<uCom>").elements.first
      			unidade_comercial_xml_tag&.content = produtos[index]["unidade_comercial"].nil? ? "UN" : produtos[index]["unidade_comercial"] 
      			produto_xml_tag&.add_child(unidade_comercial_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:qCom" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			quantidade_xml_tag = Nokogiri::XML("<qCom>").elements.first
      			quantidade_xml_tag&.content = produtos[index]["quantidade"]
      			produto_xml_tag&.add_child(quantidade_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:vUnCom" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			preco_xml_tag = Nokogiri::XML("<vUnCom>").elements.first
      			preco_xml_tag&.content = produtos[index]["preco"]
      			produto_xml_tag&.add_child(preco_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:vProd" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			valor_produto_xml_tag = Nokogiri::XML("<vProd>").elements.first
      			valor_produto_xml_tag&.content = "%.2f" % (produtos[index]["preco"].to_d * produtos[index]["quantidade"].to_d).truncate(2).to_digits
      			produto_xml_tag&.add_child(valor_produto_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:cEANTrib" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			codigo_ean_tributo_xml_tag = Nokogiri::XML("<cEANTrib>").elements.first
      			codigo_ean_tributo_xml_tag&.content = produtos[index]["codigo_ean_tributo"].nil? ? "SEM GTIN" : produtos[index]["codigo_ean_tributo"]
      			produto_xml_tag&.add_child(codigo_ean_tributo_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:uTrib" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			unidade_tributada_xml_tag = Nokogiri::XML("<uTrib>").elements.first
      			unidade_tributada_xml_tag&.content = produtos[index]["unidade_comercial"].nil? ? "UN" : produtos[index]["unidade_comercial"]
      			produto_xml_tag&.add_child(unidade_tributada_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:qTrib" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			quantidade_tributada_xml_tag = Nokogiri::XML("<qTrib>").elements.first
      			quantidade_tributada_xml_tag&.content = produtos[index]["quantidade"]
      			produto_xml_tag&.add_child(quantidade_tributada_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:vUnTrib" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			valor_tributado_xml_tag = Nokogiri::XML("<vUnTrib>").elements.first
      			valor_tributado_xml_tag&.content = produtos[index]["preco"]
      			produto_xml_tag&.add_child(valor_tributado_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:vFrete" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			valor_frete_xml_tag = Nokogiri::XML("<vFrete>").elements.first
      			valor_frete_xml_tag&.content = produtos[index]["valor_frete"].nil? ? nil : "%.2f" % produtos[index]["valor_frete"].to_d.truncate(2)
      			produto_xml_tag&.add_child(valor_frete_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:vSeg" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			valor_seguro_xml_tag = Nokogiri::XML("<vSeg>").elements.first
      			valor_seguro_xml_tag&.content = produtos[index]["valor_seguro"].nil? ? nil : "%.2f" % produtos[index]["valor_seguro"].to_d.truncate(2)
      			produto_xml_tag&.add_child(valor_seguro_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:vDesc" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			valor_desconto_xml_tag = Nokogiri::XML("<vDesc>").elements.first
      			valor_desconto_xml_tag&.content = produtos[index]["valor_desconto"].nil? ? nil : "%.2f" % produtos[index]["valor_desconto"].to_d.truncate(2)
      			produto_xml_tag&.add_child(valor_desconto_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:vOutro" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			valor_outro_xml_tag = Nokogiri::XML("<vOutro>").elements.first
      			valor_outro_xml_tag&.content = produtos[index]["valor_outro"].nil? ? nil : "%.2f" % produtos[index]["valor_outro"].to_d.truncate(2)
      			produto_xml_tag&.add_child(valor_outro_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:indTot" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			indicador_total_xml_tag = Nokogiri::XML("<indTot>").elements.first
      			indicador_total_xml_tag&.content = produtos[index]["indicador_total"].nil? ? 1 : produtos[index]["indicador_total"]
      			produto_xml_tag&.add_child(indicador_total_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,produto_index|
      			importacoes = produtos[produto_index]["importacoes"]

      			importacoes&.each do |importacao|
      				importacao_xml_tag = Nokogiri::XML("<DI>").elements.first
      				produto_xml_tag&.add_child(importacao_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI//xs:nDI" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,produto_index|
      			importacoes = produtos[produto_index]["importacoes"]
      			importacoes_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI","xs" => "http://www.portalfiscal.inf.br/nfe")

      			importacoes_xml_tags&.each_with_index do |importacao_xml_tag,importacao_index|
      				numero_documento_xml_tag = Nokogiri::XML("<nDI>").elements.first
      				numero_documento_xml_tag&.content = importacoes[importacao_index]["numero_documento"]
      				importacao_xml_tag&.add_child(numero_documento_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI//xs:dDI" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,produto_index|
      			importacoes = produtos[produto_index]["importacoes"]
      			importacoes_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI","xs" => "http://www.portalfiscal.inf.br/nfe")

      			importacoes_xml_tags&.each_with_index do |importacao_xml_tag,importacao_index|
      				data_registro_documento_xml_tag = Nokogiri::XML("<dDI>").elements.first
      				data_registro_documento_xml_tag&.content = importacoes[importacao_index]["data_registro_documento"]
      				importacao_xml_tag&.add_child(data_registro_documento_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI//xs:xLocDesemb" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,produto_index|
      			importacoes = produtos[produto_index]["importacoes"]
      			importacoes_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI","xs" => "http://www.portalfiscal.inf.br/nfe")

      			importacoes_xml_tags&.each_with_index do |importacao_xml_tag,importacao_index|
      				local_desembaraco_xml_tag = Nokogiri::XML("<xLocDesemb>").elements.first
      				local_desembaraco_xml_tag&.content = importacoes[importacao_index]["local_desembaraco"]
      				importacao_xml_tag&.add_child(local_desembaraco_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI//xs:UFDesemb" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,produto_index|
      			importacoes = produtos[produto_index]["importacoes"]
      			importacoes_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI","xs" => "http://www.portalfiscal.inf.br/nfe")

      			importacoes_xml_tags&.each_with_index do |importacao_xml_tag,importacao_index|
      				uf_desembaraco_xml_tag = Nokogiri::XML("<UFDesemb>").elements.first
      				uf_desembaraco_xml_tag&.content = importacoes[importacao_index]["uf_desembaraco"]
      				importacao_xml_tag&.add_child(uf_desembaraco_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI//xs:dDesemb" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,produto_index|
      			importacoes = produtos[produto_index]["importacoes"]
      			importacoes_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI","xs" => "http://www.portalfiscal.inf.br/nfe")

      			importacoes_xml_tags&.each_with_index do |importacao_xml_tag,importacao_index|
      				data_desembaraco_xml_tag = Nokogiri::XML("<dDesemb>").elements.first
      				data_desembaraco_xml_tag&.content = importacoes[importacao_index]["data_desembaraco"]
      				importacao_xml_tag&.add_child(data_desembaraco_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI//xs:tpViaTransp" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,produto_index|
      			importacoes = produtos[produto_index]["importacoes"]
      			importacoes_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI","xs" => "http://www.portalfiscal.inf.br/nfe")

      			importacoes_xml_tags&.each_with_index do |importacao_xml_tag,importacao_index|
      				tipo_transporte_xml_tag = Nokogiri::XML("<tpViaTransp>").elements.first
      				tipo_transporte_xml_tag&.content = importacoes[importacao_index]["tipo_transporte"]
      				importacao_xml_tag&.add_child(tipo_transporte_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI//xs:vAFRMM" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,produto_index|
      			importacoes = produtos[produto_index]["importacoes"]
      			importacoes_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI","xs" => "http://www.portalfiscal.inf.br/nfe")

      			importacoes_xml_tags&.each_with_index do |importacao_xml_tag,importacao_index|
      				valor_afrmm_xml_tag = Nokogiri::XML("<vAFRMM>").elements.first
      				valor_afrmm_xml_tag&.content = importacoes[importacao_index]["valor_afrmm"]
      				importacao_xml_tag&.add_child(valor_afrmm_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI//xs:tpIntermedio" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,produto_index|
      			importacoes = produtos[produto_index]["importacoes"]
      			importacoes_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI","xs" => "http://www.portalfiscal.inf.br/nfe")

      			importacoes_xml_tags&.each_with_index do |importacao_xml_tag,importacao_index|
      				tipo_intermedio_xml_tag = Nokogiri::XML("<tpIntermedio>").elements.first
      				tipo_intermedio_xml_tag&.content = importacoes[importacao_index]["tipo_intermedio"]
      				importacao_xml_tag&.add_child(tipo_intermedio_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI//xs:CNPJ" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,produto_index|
      			importacoes = produtos[produto_index]["importacoes"]
      			importacoes_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI","xs" => "http://www.portalfiscal.inf.br/nfe")

      			importacoes_xml_tags&.each_with_index do |importacao_xml_tag,importacao_index|
      				cnpj_xml_tag = Nokogiri::XML("<CNPJ>").elements.first
      				cnpj_xml_tag&.content = importacoes[importacao_index]["cnpj"]
      				importacao_xml_tag&.add_child(cnpj_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI//xs:UFTerceiro" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,produto_index|
      			importacoes = produtos[produto_index]["importacoes"]
      			importacoes_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI","xs" => "http://www.portalfiscal.inf.br/nfe")

      			importacoes_xml_tags&.each_with_index do |importacao_xml_tag,importacao_index|
      				uf_terceiro_xml_tag = Nokogiri::XML("<UFTerceiro>").elements.first
      				uf_terceiro_xml_tag&.content = importacoes[importacao_index]["uf_terceiro"]
      				importacao_xml_tag&.add_child(uf_terceiro_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI//xs:cExportador" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,produto_index|
      			importacoes = produtos[produto_index]["importacoes"]
      			importacoes_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI","xs" => "http://www.portalfiscal.inf.br/nfe")

      			importacoes_xml_tags&.each_with_index do |importacao_xml_tag,importacao_index|
      				codigo_exportador_xml_tag = Nokogiri::XML("<cExportador>").elements.first
      				codigo_exportador_xml_tag&.content = importacoes[importacao_index]["codigo_exportador"]
      				importacao_xml_tag&.add_child(codigo_exportador_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI//xs:adi" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,produto_index|
      			importacoes = produtos[produto_index]
      			importacoes_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI","xs" => "http://www.portalfiscal.inf.br/nfe")

      			importacoes_xml_tags&.each do |importacao_xml_tag,importacao_index|
      				adicoes = importacoes[importacao_index]["adicoes"]
      				adicoes&.each do |adicao|
      					adicao_xml_tag = Nokogiri::XML("<adi>").elements.first
      					importacao_xml_tag&.add_child(adicao_xml_tag)
      				end
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI//xs:adi//xs:nAdicao" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,produto_index|
      			importacoes = produtos[produto_index]["importacoes"]
      			importacoes_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI","xs" => "http://www.portalfiscal.inf.br/nfe")

      			importacoes_xml_tags&.each_with_index do |importacao_xml_tag,importacao_index|
      				adicoes = importacoes[importacao_index]["adicoes"]
      				adicoes_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI//xs:adi","xs" => "http://www.portalfiscal.inf.br/nfe")

      				adicoes_xml_tags&.each do |adicao_xml_tag,adicao_index|
      					numero_adicao_xml_tag = Nokogiri::XML("<nAdicao>").elements.first
      					numero_adicao_xml_tag&.content = adicoes[adicao_index]["numero_adicao"]
      					adicao_xml_tag&.add_child(numero_adicao_xml_tag)			
      				end
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI//xs:adi//xs:nSeqAdic" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,produto_index|
      			importacoes = produtos[produto_index]["importacoes"]
      			importacoes_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI","xs" => "http://www.portalfiscal.inf.br/nfe")

      			importacoes_xml_tags&.each_with_index do |importacao_xml_tag,importacao_index|
      				adicoes = importacoes[importacao_index]["adicoes"]
      				adicoes_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI//xs:adi","xs" => "http://www.portalfiscal.inf.br/nfe")

      				adicoes_xml_tags&.each do |adicao_xml_tag,adicao_index|
      					numero_sequencial_adicao_xml_tag = Nokogiri::XML("<nSeqAdic>").elements.first
      					numero_sequencial_adicao_xml_tag&.content = adicoes[adicao_index]["numero_sequencial_adicao"]
      					adicao_xml_tag&.add_child(numero_sequencial_adicao_xml_tag)			
      				end
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI//xs:adi//xs:cFabricante" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,produto_index|
      			importacoes = produtos[produto_index]["importacoes"]
      			importacoes_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI","xs" => "http://www.portalfiscal.inf.br/nfe")

      			importacoes_xml_tags&.each_with_index do |importacao_xml_tag,importacao_index|
      				adicoes = importacoes[importacao_index]["adicoes"]
      				adicoes_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI//xs:adi","xs" => "http://www.portalfiscal.inf.br/nfe")

      				adicoes_xml_tags&.each do |adicao_xml_tag,adicao_index|
      					codigo_fabricante_xml_tag = Nokogiri::XML("<cFabricante>").elements.first
      					codigo_fabricante_xml_tag&.content = adicoes[adicao_index]["codigo_fabricante"]
      					adicao_xml_tag&.add_child(codigo_fabricante_xml_tag)			
      				end
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI//xs:adi//xs:vDescDI" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,produto_index|
      			importacoes = produtos[produto_index]["importacoes"]
      			importacoes_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI","xs" => "http://www.portalfiscal.inf.br/nfe")

      			importacoes_xml_tags&.each_with_index do |importacao_xml_tag,importacao_index|
      				adicoes = importacoes[importacao_index]["adicoes"]
      				adicoes_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI//xs:adi","xs" => "http://www.portalfiscal.inf.br/nfe")

      				adicoes_xml_tags&.each do |adicao_xml_tag,adicao_index|
      					valor_desconto_xml_tag = Nokogiri::XML("<vDescDI>").elements.first
      					valor_desconto_xml_tag&.content = adicoes[adicao_index]["valor_desconto"]
      					adicao_xml_tag&.add_child(valor_desconto_xml_tag)			
      				end
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI//xs:adi//xs:nDraw" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,produto_index|
      			importacoes = produtos[produto_index]["importacoes"]
      			importacoes_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI","xs" => "http://www.portalfiscal.inf.br/nfe")

      			importacoes_xml_tags&.each_with_index do |importacao_xml_tag,importacao_index|
      				adicoes = importacoes[importacao_index]["adicoes"]
      				adicoes_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:DI//xs:adi","xs" => "http://www.portalfiscal.inf.br/nfe")

      				adicoes_xml_tags&.each do |adicao_xml_tag,adicao_index|
      					numero_drawback_xml_tag = Nokogiri::XML("<nDraw>").elements.first
      					numero_drawback_xml_tag&.content = adicoes[adicao_index]["numero_drawback"]
      					adicao_xml_tag&.add_child(numero_drawback_xml_tag)			
      				end
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:detExport" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,produto_index|
      			exportacoes = produtos[produto_index]["exportacoes"]

      			exportacoes&.each do |exportacao|
      				exportacao_xml_tag = Nokogiri::XML("<detExport>").elements.first
      				produto_xml_tag&.add_child(exportacao_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:detExport//xs:nDraw" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,produto_index|
      			exportacoes = produtos[produto_index]["exportacoes"]
      			exportacoes_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:detExport","xs" => "http://www.portalfiscal.inf.br/nfe")

      			exportacoes_xml_tags&.each_with_index do |exportacao_xml_tag,exportacao_index|
      				numero_drawback_xml_tag = Nokogiri::XML("<nDraw>").elements.first
      				numero_drawback_xml_tag&.content = exportacoes[exportacao_index]["numero_drawback"]
      				exportacao_xml_tag&.add_child(numero_drawback_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:detExport//xs:exportInd" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,produto_index|
      			exportacoes = produtos[produto_index]["exportacoes"]
      			exportacoes_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:detExport","xs" => "http://www.portalfiscal.inf.br/nfe")

      			exportacoes_xml_tags&.each_with_index do |exportacao_xml_tag,exportacao_index|
      				export_ind_xml_tag = Nokogiri::XML("<exportInd>").elements.first
      				exportacao_xml_tag&.add_child(export_ind_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:detExport//xs:exportInd//xs:nRE" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,produto_index|
      			exportacoes = produtos[produto_index]["exportacoes"]
      			exportacoes_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:detExport","xs" => "http://www.portalfiscal.inf.br/nfe")

      			exportacoes_xml_tags&.each_with_index do |exportacao_xml_tag,exportacao_index|
      				export_ind_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:detExport//xs:exportInd","xs" => "http://www.portalfiscal.inf.br/nfe")[exportacao_index]
      				numero_registro_exportacao_xml_tag = Nokogiri::XML("<nRE>").elements.first
      				numero_registro_exportacao_xml_tag&.content = exportacoes[exportacao_index]["numero_registro_exportacao"]
      				export_ind_xml_tag&.add_child(numero_registro_exportacao_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:detExport//xs:exportInd//xs:chNFe" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,produto_index|
      			exportacoes = produtos[produto_index]["exportacoes"]
      			exportacoes_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:detExport","xs" => "http://www.portalfiscal.inf.br/nfe")

      			exportacoes_xml_tags&.each_with_index do |exportacao_xml_tag,exportacao_index|
      				export_ind_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:detExport//xs:exportInd","xs" => "http://www.portalfiscal.inf.br/nfe")[exportacao_index]
      				chave_nota_xml_tag = Nokogiri::XML("<chNFe>").elements.first
      				chave_nota_xml_tag&.content = exportacoes[exportacao_index]["chave_nota"]
      				export_ind_xml_tag&.add_child(chave_nota_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:detExport//xs:exportInd//xs:qExport" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,produto_index|
      			exportacoes = produtos[produto_index]["exportacoes"]
      			exportacoes_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:detExport","xs" => "http://www.portalfiscal.inf.br/nfe")

      			exportacoes_xml_tags&.each_with_index do |exportacao_xml_tag,exportacao_index|
      				export_ind_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:detExport//xs:exportInd","xs" => "http://www.portalfiscal.inf.br/nfe")[exportacao_index]
      				quantidade_xml_tag = Nokogiri::XML("<qExport>").elements.first
      				quantidade_xml_tag&.content = exportacoes[exportacao_index]["quantidade"]
      				export_ind_xml_tag&.add_child(quantidade_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:xPed" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			numero_pedido_xml_tag = Nokogiri::XML("<xPed>").elements.first
      			numero_pedido_xml_tag&.content = produtos[index]["numero_pedido"]
      			produto_xml_tag&.add_child(numero_pedido_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:nItemPed" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			numero_item_pedido_xml_tag = Nokogiri::XML("<nItemPed>").elements.first
      			numero_item_pedido_xml_tag&.content = produtos[index]["numero_item_pedido"]
      			produto_xml_tag&.add_child(numero_item_pedido_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:nFCI" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			numero_fci_xml_tag = Nokogiri::XML("<nFCI>").elements.first
      			numero_fci_xml_tag&.content = produtos[index]["numero_fci"]
      			produto_xml_tag&.add_child(numero_fci_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:rastro" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,produto_index|
      			rastros = produtos[produto_index]["rastreamento"]

      			rastros&.each do |rastro|
      				rastro_xml_tag = Nokogiri::XML("<rastro>").elements.first
      				produto_xml_tag&.add_child(rastro_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:rastro//xs:nLote" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,produto_index|
      			rastros = produtos[produto_index]["rastreamento"]
      			rastros_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:rastro","xs" => "http://www.portalfiscal.inf.br/nfe")

      			rastros_xml_tags&.each_with_index do |rastro_xml_tag,rastro_index|
      				lote_xml_tag = Nokogiri::XML("<nLote>").elements.first
      				lote_xml_tag&.content = rastros[rastro_index]["lote"]
      				rastro_xml_tag&.add_child(lote_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:rastro//xs:qLote" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,produto_index|
      			rastros = produtos[produto_index]["rastreamento"]
      			rastros_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:rastro","xs" => "http://www.portalfiscal.inf.br/nfe")

      			rastros_xml_tags&.each_with_index do |rastro_xml_tag,rastro_index|
      				quantidade_xml_tag = Nokogiri::XML("<qLote>").elements.first
      				quantidade_xml_tag&.content = rastros[rastro_index]["quantidade"]
      				rastro_xml_tag&.add_child(quantidade_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:rastro//xs:dFab" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,produto_index|
      			rastros = produtos[produto_index]["rastreamento"]
      			rastros_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:rastro","xs" => "http://www.portalfiscal.inf.br/nfe")

      			rastros_xml_tags&.each_with_index do |rastro_xml_tag,rastro_index|
      				fabricacao_xml_tag = Nokogiri::XML("<dFab>").elements.first
      				fabricacao_xml_tag&.content = rastros[rastro_index]["fabricacao"]
      				rastro_xml_tag&.add_child(fabricacao_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:rastro//xs:dVal" => lambda{|msg,xml|
        	produtos = msg["produtos"]
        	produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

        	produto_xml_tags&.each_with_index do |produto_xml_tag,produto_index|
        			rastros = produtos[produto_index]["rastreamento"]
        			rastros_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:rastro","xs" => "http://www.portalfiscal.inf.br/nfe")

        			rastros_xml_tags&.each_with_index do |rastro_xml_tag,rastro_index|
        				validade_xml_tag = Nokogiri::XML("<dVal>").elements.first
        				validade_xml_tag&.content = rastros[rastro_index]["validade"]
        				rastro_xml_tag&.add_child(validade_xml_tag)
        			end
        	end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	  produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	  produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      		  veiculos_xml_tag = Nokogiri::XML("<veicProd>").elements.first
      			produto_xml_tag&.add_child(veiculos_xml_tag) if !produtos[index]["veiculos"].nil?
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd//xs:tpOp" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			veiculo_xml_tag = produto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			if !veiculo_xml_tag.nil?
      				tipo_operacao_xml_tag = Nokogiri::XML("<tpOp>").elements.first
      				tipo_operacao_xml_tag&.content = produtos[index].dig("veiculos","tipo_operacao")
      				veiculo_xml_tag&.add_child(tipo_operacao_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd//xs:chassi" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			veiculo_xml_tag = produto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			if !veiculo_xml_tag.nil?
      				chassi_xml_tag = Nokogiri::XML("<chassi>").elements.first
      				chassi_xml_tag&.content = produtos[index].dig("veiculos","chassi")
      				veiculo_xml_tag&.add_child(chassi_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd//xs:cCor" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			veiculo_xml_tag = produto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			if !veiculo_xml_tag.nil?
      				codigo_cor_xml_tag = Nokogiri::XML("<cCor>").elements.first
      				codigo_cor_xml_tag&.content = produtos[index].dig("veiculos","codigo_cor")
      				veiculo_xml_tag&.add_child(codigo_cor_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd//xs:xCor" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			veiculo_xml_tag = produto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			if !veiculo_xml_tag.nil?
      				descricao_cor_xml_tag = Nokogiri::XML("<xCor>").elements.first
      				descricao_cor_xml_tag&.content = produtos[index].dig("veiculos","descricao_cor")
      				veiculo_xml_tag&.add_child(descricao_cor_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd//xs:pot" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			veiculo_xml_tag = produto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			if !veiculo_xml_tag.nil?
      				potencia_xml_tag = Nokogiri::XML("<pot>").elements.first
      				potencia_xml_tag&.content = produtos[index].dig("veiculos","potencia")
      				veiculo_xml_tag&.add_child(potencia_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd//xs:cilin" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			veiculo_xml_tag = produto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			if !veiculo_xml_tag.nil?
      				cilindradas_xml_tag = Nokogiri::XML("<cilin>").elements.first
      				cilindradas_xml_tag&.content = produtos[index].dig("veiculos","cilindradas")
      				veiculo_xml_tag&.add_child(cilindradas_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd//xs:pesoL" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			veiculo_xml_tag = produto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			if !veiculo_xml_tag.nil?
      				peso_liquido_xml_tag = Nokogiri::XML("<pesoL>").elements.first
      				peso_liquido_xml_tag&.content = produtos[index].dig("veiculos","peso_liquido")
      				veiculo_xml_tag&.add_child(peso_liquido_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd//xs:pesoB" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			veiculo_xml_tag = produto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			if !veiculo_xml_tag.nil?
      				peso_bruto_xml_tag = Nokogiri::XML("<pesoB>").elements.first
      				peso_bruto_xml_tag&.content = produtos[index].dig("veiculos","peso_bruto")
      				veiculo_xml_tag&.add_child(peso_bruto_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd//xs:nSerie" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			veiculo_xml_tag = produto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			if !veiculo_xml_tag.nil?
      				serie_xml_tag = Nokogiri::XML("<nSerie>").elements.first
      				serie_xml_tag&.content = produtos[index].dig("veiculos","serie")
      				veiculo_xml_tag&.add_child(serie_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd//xs:tpComb" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			veiculo_xml_tag = produto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			if !veiculo_xml_tag.nil?
      				tipo_combustivel_xml_tag = Nokogiri::XML("<tpComb>").elements.first
      				tipo_combustivel_xml_tag&.content = produtos[index].dig("veiculos","tipo_combustivel")
      				veiculo_xml_tag&.add_child(tipo_combustivel_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd//xs:nMotor" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			veiculo_xml_tag = produto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			if !veiculo_xml_tag.nil?
      				numero_motor_xml_tag = Nokogiri::XML("<nMotor>").elements.first
      				numero_motor_xml_tag&.content = produtos[index].dig("veiculos","numero_motor")
      				veiculo_xml_tag&.add_child(numero_motor_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd//xs:CMT" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			veiculo_xml_tag = produto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			if !veiculo_xml_tag.nil?
      				capacidade_maxima_tracao_xml_tag = Nokogiri::XML("<CMT>").elements.first
      				capacidade_maxima_tracao_xml_tag&.content = produtos[index].dig("veiculos","capacidade_maxima_tracao")
      				veiculo_xml_tag&.add_child(capacidade_maxima_tracao_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd//xs:dist" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			veiculo_xml_tag = produto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			if !veiculo_xml_tag.nil?
      				distancia_eixos_xml_tag = Nokogiri::XML("<dist>").elements.first
      				distancia_eixos_xml_tag&.content = produtos[index].dig("veiculos","distancia_eixos")
      				veiculo_xml_tag&.add_child(distancia_eixos_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd//xs:anoMod" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			veiculo_xml_tag = produto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			if !veiculo_xml_tag.nil?
      				ano_modelo_xml_tag = Nokogiri::XML("<anoMod>").elements.first
      				ano_modelo_xml_tag&.content = produtos[index].dig("veiculos","ano_modelo")
      				veiculo_xml_tag&.add_child(ano_modelo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd//xs:anoFab" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			veiculo_xml_tag = produto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			if !veiculo_xml_tag.nil?
      				ano_fabricacao_xml_tag = Nokogiri::XML("<anoFab>").elements.first
      				ano_fabricacao_xml_tag&.content = produtos[index].dig("veiculos","ano_fabricacao")
      				veiculo_xml_tag&.add_child(ano_fabricacao_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd//xs:tpPint" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			veiculo_xml_tag = produto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			if !veiculo_xml_tag.nil?
      				tipo_pintura_xml_tag = Nokogiri::XML("<tpPint>").elements.first
      				tipo_pintura_xml_tag&.content = produtos[index].dig("veiculos","tipo_pintura")
      				veiculo_xml_tag&.add_child(tipo_pintura_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd//xs:tpVeic" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			veiculo_xml_tag = produto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			if !veiculo_xml_tag.nil?
      				tipo_veiculo_xml_tag = Nokogiri::XML("<tpVeic>").elements.first
      				tipo_veiculo_xml_tag&.content = produtos[index].dig("veiculos","tipo_veiculo")
      				veiculo_xml_tag&.add_child(tipo_veiculo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd//xs:espVeic" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			veiculo_xml_tag = produto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			if !veiculo_xml_tag.nil?
      				especie_veiculo_xml_tag = Nokogiri::XML("<espVeic>").elements.first
      				especie_veiculo_xml_tag&.content = produtos[index].dig("veiculos","especie_veiculo")
      				veiculo_xml_tag&.add_child(especie_veiculo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd//xs:VIN" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			veiculo_xml_tag = produto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			if !veiculo_xml_tag.nil?
      				condicao_vin_xml_tag = Nokogiri::XML("<VIN>").elements.first
      				condicao_vin_xml_tag&.content = produtos[index].dig("veiculos","condicao_vin")
      				veiculo_xml_tag&.add_child(condicao_vin_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd//xs:condVeic" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			veiculo_xml_tag = produto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			if !veiculo_xml_tag.nil?
      				condicao_veiculo_xml_tag = Nokogiri::XML("<condVeic>").elements.first
      				condicao_veiculo_xml_tag&.content = produtos[index].dig("veiculos","condicao_veiculo")
      				veiculo_xml_tag&.add_child(condicao_veiculo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd//xs:cMod" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			veiculo_xml_tag = produto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			if !veiculo_xml_tag.nil?
      				codigo_marca_modelo_xml_tag = Nokogiri::XML("<cMod>").elements.first
      				codigo_marca_modelo_xml_tag&.content = produtos[index].dig("veiculos","codigo_marca_modelo")
      				veiculo_xml_tag&.add_child(codigo_marca_modelo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd//xs:cCorDENATRAN" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			veiculo_xml_tag = produto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			if !veiculo_xml_tag.nil?
      				codigo_cor_denatran_xml_tag = Nokogiri::XML("<cCorDENATRAN>").elements.first
      				codigo_cor_denatran_xml_tag&.content = produtos[index].dig("veiculos","codigo_cor_denatran")
      				veiculo_xml_tag&.add_child(codigo_cor_denatran_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd//xs:lota" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			veiculo_xml_tag = produto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			if !veiculo_xml_tag.nil?
      				lotacao_xml_tag = Nokogiri::XML("<lota>").elements.first
      				lotacao_xml_tag&.content = produtos[index].dig("veiculos","lotacao")
      				veiculo_xml_tag&.add_child(lotacao_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd//xs:tpRest" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			veiculo_xml_tag = produto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:veicProd","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			if !veiculo_xml_tag.nil?
      				restricao_xml_tag = Nokogiri::XML("<tpRest>").elements.first
      				restricao_xml_tag&.content = produtos[index].dig("veiculos","restricao")
      				veiculo_xml_tag&.add_child(restricao_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:med" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			medicamentos_xml_tag = Nokogiri::XML("<med>").elements.first
      			produto_xml_tag&.add_child(medicamentos_xml_tag) if !produtos[index]["medicamentos"].nil?
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:med//xs:cProdANVISA" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			medicamento_xml_tag = produto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:med","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			if !medicamento_xml_tag.nil?
      				codigo_produto_anvisa_xml_tag = Nokogiri::XML("<cProdANVISA>").elements.first
      				codigo_produto_anvisa_xml_tag&.content = produtos[index].dig("medicamentos","codigo_produto_anvisa")
      				medicamento_xml_tag&.add_child(codigo_produto_anvisa_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:med//xs:vPMC" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			medicamento_xml_tag = produto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:med","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			if !medicamento_xml_tag.nil?
      				preco_maximo_consumidor_xml_tag = Nokogiri::XML("<vPMC>").elements.first
      				preco_maximo_consumidor_xml_tag&.content = produtos[index].dig("medicamentos","preco_maximo_consumidor")
      				medicamento_xml_tag&.add_child(preco_maximo_consumidor_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:arma" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			armas_xml_tag = Nokogiri::XML("<arma>").elements.first
      			produto_xml_tag&.add_child(armas_xml_tag) if !produtos[index]["armas"].nil?
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:arma//xs:tpArma" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			arma_xml_tag = produto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:arma","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			if !arma_xml_tag.nil?
      				tipo_arma_xml_tag = Nokogiri::XML("<tpArma>").elements.first
      				tipo_arma_xml_tag&.content = produtos[index].dig("armas","tipo_arma")
      				arma_xml_tag&.add_child(tipo_arma_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:arma//xs:nSerie" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			arma_xml_tag = produto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:arma","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			if !arma_xml_tag.nil?
      				numero_serie_xml_tag = Nokogiri::XML("<nSerie>").elements.first
      				numero_serie_xml_tag&.content = produtos[index].dig("armas","numero_serie")
      				arma_xml_tag&.add_child(numero_serie_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:arma//xs:nCano" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			arma_xml_tag = produto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:arma","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			if !arma_xml_tag.nil?
      				numero_cano_xml_tag = Nokogiri::XML("<nCano>").elements.first
      				numero_cano_xml_tag&.content = produtos[index].dig("armas","numero_cano")
      				arma_xml_tag&.add_child(numero_cano_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:arma//xs:descr" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			arma_xml_tag = produto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:arma","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			if !arma_xml_tag.nil?
      				descricao_xml_tag = Nokogiri::XML("<descr>").elements.first
      				descricao_xml_tag&.content = produtos[index].dig("armas","descricao")
      				arma_xml_tag&.add_child(descricao_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			combustiveis_xml_tag = Nokogiri::XML("<comb>").elements.first
      			produto_xml_tag&.add_child(combustiveis_xml_tag) if !produtos[index]["combustiveis"].nil?
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb//xs:cProdANP" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			combustivel_xml_tag = produto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			if !combustivel_xml_tag.nil?
      				codigo_produto_anp_xml_tag = Nokogiri::XML("<cProdANP>").elements.first
      				codigo_produto_anp_xml_tag&.content = produtos[index].dig("combustiveis","codigo_produto_anp")
      				combustivel_xml_tag&.add_child(codigo_produto_anp_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb//xs:descANP" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			combustivel_xml_tag = produto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			if !combustivel_xml_tag.nil?
      				descricao_anp_xml_tag = Nokogiri::XML("<descANP>").elements.first
      				descricao_anp_xml_tag&.content = produtos[index].dig("combustiveis","descricao_anp")
      				combustivel_xml_tag&.add_child(descricao_anp_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb//xs:pGLP" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			combustivel_xml_tag = produto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			if !combustivel_xml_tag.nil?
      				percentual_glp_xml_tag = Nokogiri::XML("<pGLP>").elements.first
      				percentual_glp_xml_tag&.content = produtos[index].dig("combustiveis","percentual_glp")
      				combustivel_xml_tag&.add_child(percentual_glp_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb//xs:pGNn" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			combustivel_xml_tag = produto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			if !combustivel_xml_tag.nil?
      				percentual_gnn_xml_tag = Nokogiri::XML("<pGNn>").elements.first
      				percentual_gnn_xml_tag&.content = produtos[index].dig("combustiveis","percentual_gnn")
      				combustivel_xml_tag&.add_child(percentual_gnn_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb//xs:pGNi" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			combustivel_xml_tag = produto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			if !combustivel_xml_tag.nil?
      				percentual_gni_xml_tag = Nokogiri::XML("<pGNi>").elements.first
      				percentual_gni_xml_tag&.content = produtos[index].dig("combustiveis","percentual_gni")
      				combustivel_xml_tag&.add_child(percentual_gni_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb//xs:vPart" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			combustivel_xml_tag = produto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			if !combustivel_xml_tag.nil?
      				valor_partida_xml_tag = Nokogiri::XML("<vPart>").elements.first
      				valor_partida_xml_tag&.content = produtos[index].dig("combustiveis","valor_partida")
      				combustivel_xml_tag&.add_child(valor_partida_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb//xs:CODIF" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			combustivel_xml_tag = produto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			if !combustivel_xml_tag.nil?
      				codif_xml_tag = Nokogiri::XML("<CODIF>").elements.first
      				codif_xml_tag&.content = produtos[index].dig("combustiveis","codif")
      				combustivel_xml_tag&.add_child(codif_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb//xs:qTemp" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			combustivel_xml_tag = produto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			if !combustivel_xml_tag.nil?
      				quantidade_temperatura_ambiente_xml_tag = Nokogiri::XML("<qTemp>").elements.first
      				quantidade_temperatura_ambiente_xml_tag&.content = produtos[index].dig("combustiveis","quantidade_temperatura_ambiente")
      				combustivel_xml_tag&.add_child(quantidade_temperatura_ambiente_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb//xs:UFCons" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			combustivel_xml_tag = produto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			if !combustivel_xml_tag.nil?
      				uf_consumo_xml_tag = Nokogiri::XML("<UFCons>").elements.first
      				uf_consumo_xml_tag&.content = produtos[index].dig("combustiveis","uf_consumo")
      				combustivel_xml_tag&.add_child(uf_consumo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb//xs:CIDE" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			combustivel_xml_tag = produto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			if !combustivel_xml_tag.nil?
      				cide_xml_tag = Nokogiri::XML("<CIDE>").elements.first
      				combustivel_xml_tag&.add_child(cide_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb//xs:CIDE//xs:qBCProd" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			cide_xml_tag = produto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb/xs:CIDE","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			quantidade_cide_xml_tag = Nokogiri::XML("<qBCProd>").elements.first
      			quantidade_cide_xml_tag&.content = produtos[index].dig("combustiveis","quantidade_cide")
      			cide_xml_tag&.add_child(quantidade_cide_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb//xs:CIDE//xs:vAliqProd" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			cide_xml_tag = produto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb/xs:CIDE","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			aliquota_cide_xml_tag = Nokogiri::XML("<vAliqProd>").elements.first
      			aliquota_cide_xml_tag&.content = produtos[index].dig("combustiveis","aliquota_cide")
      			cide_xml_tag&.add_child(aliquota_cide_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb//xs:CIDE//xs:vCIDE" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			cide_xml_tag = produto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb/xs:CIDE","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			valor_cide_xml_tag = Nokogiri::XML("<vCIDE>").elements.first
      			valor_cide_xml_tag&.content = (produtos[index].dig("combustiveis","aliquota_cide").to_d * produtos[index].dig("combustiveis","quantidade_cide").to_d).truncate(2).to_digits
      			cide_xml_tag&.add_child(valor_cide_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb//xs:encerrante" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			combustivel_xml_tag = produto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			if !combustivel_xml_tag.nil?
      				encerrante_xml_tag = Nokogiri::XML("<encerrante>").elements.first
      				combustivel_xml_tag&.add_child(encerrante_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb//xs:encerrante//xs:nBico" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			encerrante_xml_tag = produto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb/xs:encerrante","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			numero_bico_xml_tag = Nokogiri::XML("<nBico>").elements.first
      			numero_bico_xml_tag&.content = produtos[index].dig("combustiveis","numero_bico")
      			encerrante_xml_tag&.add_child(numero_bico_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb//xs:encerrante//xs:nBomba" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			encerrante_xml_tag = produto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb/xs:encerrante","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			numero_bomba_xml_tag = Nokogiri::XML("<nBomba>").elements.first
      			numero_bomba_xml_tag&.content = produtos[index].dig("combustiveis","numero_bomba")
      			encerrante_xml_tag&.add_child(numero_bomba_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb//xs:encerrante//xs:nTanque" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			encerrante_xml_tag = produto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb/xs:encerrante","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			numero_tanque_xml_tag = Nokogiri::XML("<nTanque>").elements.first
      			numero_tanque_xml_tag&.content = produtos[index].dig("combustiveis","numero_tanque")
      			encerrante_xml_tag&.add_child(numero_tanque_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb//xs:encerrante//xs:vEncIni" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			encerrante_xml_tag = produto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb/xs:encerrante","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			valor_encerrante_inicio_xml_tag = Nokogiri::XML("<vEncIni>").elements.first
      			valor_encerrante_inicio_xml_tag&.content = produtos[index].dig("combustiveis","valor_encerrante_inicio")
      			encerrante_xml_tag&.add_child(valor_encerrante_inicio_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb//xs:encerrante//xs:vEncFin" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			encerrante_xml_tag = produto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb/xs:encerrante","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			valor_encerrante_fim_xml_tag = Nokogiri::XML("<vEncFin>").elements.first
      			valor_encerrante_fim_xml_tag&.content = produtos[index].dig("combustiveis","valor_encerrante_fim")
      			encerrante_xml_tag&.add_child(valor_encerrante_fim_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:nRECOPI" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      	 produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

      	 produto_xml_tags&.each_with_index do |produto_xml_tag,index|
      			combustivel_xml_tag = produto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:comb","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			if !combustivel_xml_tag.nil?
      				papel_xml_tag = Nokogiri::XML("<nRECOPI>").elements.first
      				papel_xml_tag&.content = produtos[index]["papel"]
      				combustivel_xml_tag&.add_child(papel_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		det_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det","xs" => "http://www.portalfiscal.inf.br/nfe")

      		det_xml_tags&.each_with_index do |det_xml_tag,index|
      			imposto_xml_tag = Nokogiri::XML("<imposto>").elements.first
      			det_xml_tag&.add_child(imposto_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS" => lambda{|msg,xml|
      		produtos = msg["produtos"]

      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")

      			if !icms.nil?
      				icms_xml_tag = Nokogiri::XML("<ICMS>").elements.first
              imposto_xml_tag&.add_child(icms_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS00" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			
      			if !icms_xml_tag.nil?
      				if icms["codigo"] == "00"
      				  icms00_xml_tag = Nokogiri::XML("<ICMS00>").elements.first
      					icms_xml_tag&.add_child(icms00_xml_tag)
      				end
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS00//xs:orig" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms00_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS00","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms00_xml_tag.nil?
      				origem_xml_tag = Nokogiri::XML("<orig>").elements.first
      				origem_xml_tag&.content = icms["origem"]
              icms00_xml_tag&.add_child(origem_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS00//xs:CST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms00_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS00","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms00_xml_tag.nil?
      				codigo_xml_tag = Nokogiri::XML("<CST>").elements.first
      				codigo_xml_tag&.content = icms["codigo"]
              icms00_xml_tag&.add_child(codigo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS00//xs:modBC" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms00_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS00","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms00_xml_tag.nil?
      				modalidade_xml_tag = Nokogiri::XML("<modBC>").elements.first
      				modalidade_xml_tag&.content = icms["modalidade"]
              icms00_xml_tag&.add_child(modalidade_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS00//xs:vBC" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms00_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS00","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms00_xml_tag.nil?
      				valor_base_calculo_xml_tag = Nokogiri::XML("<vBC>").elements.first
      				valor_base_calculo_xml_tag&.content = "%.2f" % (produtos[index]["preco"].to_d * produtos[index]["quantidade"].to_d).truncate(2)
              icms00_xml_tag&.add_child(valor_base_calculo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS00//xs:pICMS" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms00_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS00","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms00_xml_tag.nil?
      				aliquota_xml_tag = Nokogiri::XML("<pICMS>").elements.first
      				aliquota_xml_tag&.content = "%.2f" % icms["aliquota_icms"].to_d.truncate(2)
              icms00_xml_tag&.add_child(aliquota_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS00//xs:vICMS" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms00_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS00","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms00_xml_tag.nil?
      				valor_base_calculo_xml_tag  = icms00_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS00//xs:vBC","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				aliquota_xml_tag  = icms00_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS00//xs:pICMS","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				valor_icms_xml_tag = Nokogiri::XML("<vICMS>").elements.first
      				valor_icms_xml_tag&.content = "%.2f" % ((base_calculo_xml_tag.content.to_d * aliquota_xml_tag.content.to_d)/100.to_d).truncate(2)
              icms00_xml_tag&.add_child(valor_icms_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS00//xs:pFCP" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms00_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS00","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms00_xml_tag.nil?
      				aliquota_fcp_xml_tag = Nokogiri::XML("<pFCP>").elements.first
      				if !icms["percentual_fcp"].nil?
      					aliquota_fcp_xml_tag&.content = "%.2f" % icms["percentual_fcp"].to_d.truncate(2)
      				else
      					aliquota_fcp_xml_tag&.content = "%.2f" % 2
      				end
              icms00_xml_tag&.add_child(aliquota_fcp_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS00//xs:vFCP" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms00_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS00","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms00_xml_tag.nil?
      				valor_base_calculo_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS00//xs:vBC","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				aliquota_fcp_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS00//xs:pFCP","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				valor_fcp_xml_tag = Nokogiri::XML("<vFCP>").elements.first
              valor_fcp_xml_tag&.content = "%.2f" % ((base_calculo_xml_tag.content.to_d * aliquota_fcp_xml_tag.content.to_d)/100.to_d).truncate(2)
              icms00_xml_tag&.add_child(valor_fcp_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms_xml_tag.nil?

      				if icms["codigo"] == "10"
      				  icms10_xml_tag = Nokogiri::XML("<ICMS10>").elements.first
      					icms_xml_tag&.add_child(icms10_xml_tag)
      				end
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10//xs:orig" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms10_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms10_xml_tag.nil?
      				origem_xml_tag = Nokogiri::XML("<orig>").elements.first
      				origem_xml_tag&.content = icms["origem"]
              icms10_xml_tag&.add_child(origem_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10//xs:CST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms10_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms10_xml_tag.nil?
      				codigo_xml_tag = Nokogiri::XML("<CST>").elements.first
      				codigo_xml_tag&.content = icms["codigo"]
              icms10_xml_tag&.add_child(codigo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10//xs:modBC" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms10_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms10_xml_tag.nil?
      				modalidade_xml_tag = Nokogiri::XML("<modBC>").elements.first
      				modalidade_xml_tag&.content = icms["modalidade"]
              icms10_xml_tag&.add_child(modalidade_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10//xs:vBC" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms10_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms10_xml_tag.nil?
      				valor_base_calculo_xml_tag = Nokogiri::XML("<vBC>").elements.first
      				valor_base_calculo_xml_tag&.content = "%.2f" % (produtos[index]["preco"].to_d * produtos[index]["quantidade"].to_d).truncate(2)
              icms10_xml_tag&.add_child(valor_base_calculo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10//xs:pICMS" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms10_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms10_xml_tag.nil?
      				aliquota_xml_tag = Nokogiri::XML("<pICMS>").elements.first
      				aliquota_xml_tag&.content = "%.2f" % icms["aliquota_icms"].to_d.truncate(2)
              icms10_xml_tag&.add_child(aliquota_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10//xs:vICMS" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms10_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms10_xml_tag.nil?
      				valor_base_calculo_xml_tag = icms10_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10//xs:vBC","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				aliquota_xml_tag = icms10_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10//xs:pICMS","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				valor_icms_xml_tag = Nokogiri::XML("<vICMS>").elements.first
      				valor_icms_xml_tag&.content = "%.2f" % ((base_calculo_xml_tag.content.to_d * aliquota_xml_tag.content.to_d)/100.to_d).truncate(2)
              icms10_xml_tag&.add_child(valor_icms_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10//xs:vBCFCP" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms10_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms10_xml_tag.nil?
      				valor_base_calculo_fcp_xml_tag = Nokogiri::XML("<vBCFCP>").elements.first
      				valor_base_calculo_fcp_xml_tag&.content = "%.2f" % (produtos[index]["preco"].to_d * produtos[index]["quantidade"].to_d).truncate(2)
              icms10_xml_tag&.add_child(valor_base_calculo_fcp_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10//xs:pFCP" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms10_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms10_xml_tag.nil?
      				percentual_fcp_xml_tag = Nokogiri::XML("<pFCP>").elements.first
      				if !icms["percentual_fcp"].nil?
      					percentual_fcp_xml_tag&.content = "%.2f" % icms["percentual_fcp"].to_d.truncate(2)
      				else
      					percentual_fcp_xml_tag&.content = "%.2f" % 2
      				end
              icms10_xml_tag&.add_child(percentual_fcp_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10//xs:vFCP" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms10_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms10_xml_tag.nil?
      				valor_base_calculo_fcp_xml_tag = icms10_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10//xs:vBCFCP","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				percentual_fcp_xml_tag = icms10_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10//xs:pFCP","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				valor_fcp_xml_tag = Nokogiri::XML("<vFCP>").elements.first
      				valor_fcp_xml_tag&.content = ((percentual_fcp_xml_tag.content.to_d * base_calculo_fcp_xml_tag.content.to_d)/100.to_d).truncate(2).to_digits
              icms10_xml_tag&.add_child(valor_fcp_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10//xs:modBCST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms10_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms10_xml_tag.nil?
      				modalidade_st_xml_tag = Nokogiri::XML("<modBCST>").elements.first
      				modalidade_st_xml_tag&.content = icms["modalidade_st"]
              icms10_xml_tag&.add_child(modalidade_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10//xs:pMVAST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms10_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms10_xml_tag.nil?
      				percentual_mva_st_xml_tag = Nokogiri::XML("<pMVAST>").elements.first
      				percentual_mva_st_xml_tag&.content = icms["percentual_mva_st"]
              icms10_xml_tag&.add_child(percentual_mva_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10//xs:pRedBCST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms10_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms10_xml_tag.nil?
      				percentual_reducao_st_xml_tag = Nokogiri::XML("<pRedBCST>").elements.first
      				percentual_reducao_st_xml_tag&.content = icms["percentual_reducao_st"]
              icms10_xml_tag&.add_child(percentual_reducao_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10//xs:vBCST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms10_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms10_xml_tag.nil?
      				valor_base_calculo_st_xml_tag = Nokogiri::XML("<vBCST>").elements.first
      				valor_base_calculo_st_xml_tag&.content = "%.2f" % (produtos[index]["preco"].to_d * produtos[index]["quantidade"].to_d).truncate(2)
              icms10_xml_tag&.add_child(valor_base_calculo_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10//xs:pICMSST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms10_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms10_xml_tag.nil?
      				aliquota_icmsst_xml_tag = Nokogiri::XML("<pICMSST>").elements.first
      				aliquota_icmsst_xml_tag&.content = "%.2f" % icms["aliquota_icms_st"].to_d.truncate(2)
              icms10_xml_tag&.add_child(aliquota_icmsst_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10//xs:vICMSST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms10_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms10_xml_tag.nil?
      				valor_base_calculo_st_xml_tag = icms10_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10//xs:vBCST","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				aliquota_st_xml_tag = icms10_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10//xs:pICMSST","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				valor_icms_st_xml_tag = Nokogiri::XML("<vICMSST>").elements.first
      				valor_icms_st_xml_tag&.content = "%.2f" % ((base_calculo_st_xml_tag.content.to_d * aliquota_st_xml_tag.content.to_d)/100.to_d).truncate(2)
              icms10_xml_tag&.add_child(valor_icms_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10//xs:vBCFCPST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms10_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms10_xml_tag.nil?
      				valor_base_calculo_fcp_st_xml_tag = Nokogiri::XML("<vBCFCPST>").elements.first
      				valor_base_calculo_fcp_st_xml_tag&.content = "%.2f" % (produtos[index]["preco"].to_d * produtos[index]["quantidade"].to_d).truncate(2)
              icms10_xml_tag&.add_child(valor_base_calculo_fcp_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10//xs:pFCPST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms10_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms10_xml_tag.nil?
      				percentual_fcp_st_xml_tag = Nokogiri::XML("<pFCPST>").elements.first
      				if !icms["percentual_fcp_st"].nil?
      					percentual_fcp_st_xml_tag&.content = "%.2f" % icms["percentual_fcp_st"].to_d.truncate(2)
      				else
      					percentual_fcp_st_xml_tag&.content = "%.2f" % 2
      				end
              icms10_xml_tag&.add_child(percentual_fcp_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10//xs:vFCPST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms10_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms10_xml_tag.nil?
      				valor_base_calculo_fcp_st_xml_tag = icms10_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10//xs:vBCFCPST","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				aliquota_fcp_st_xml_tag = icms10_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10//xs:pFCPST","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				valor_fcp_st_xml_tag = Nokogiri::XML("<vFCPST>").elements.first
      				valor_fcp_st_xml_tag&.content = "%.2f" % ((base_calculo_fcp_st_xml_tag.content.to_d * aliquota_fcp_st_xml_tag.content.to_d)/100.to_d).truncate(2)
              icms10_xml_tag&.add_child(valor_fcp_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10//xs:vICMSSTDeson" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms10_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms10_xml_tag.nil?
      				valor_icms_st_desonerado_xml_tag = Nokogiri::XML("<vICMSSTDeson>").elements.first
      				valor_icms_st_desonerado_xml_tag&.content = "%.2f" % icms.dig("icms_st_desonerado","valor_icms_st_desonerado_st").to_d.truncate(2)
              icms10_xml_tag&.add_child(valor_icms_st_desonerado_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10//xs:motDesICMSST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms10_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS10","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms10_xml_tag.nil?
      				motivo_desoneracao_st_xml_tag = Nokogiri::XML("<motDesICMSST>").elements.first
      				motivo_desoneracao_st_xml_tag&.content = icms.dig("icms_st_desonerado","motivo_desoneracao_st")
              icms10_xml_tag&.add_child(motivo_desoneracao_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS20" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms_xml_tag.nil?

      				if icms["codigo"] == "20"
      			    icms20_xml_tag = Nokogiri::XML("<ICMS20>").elements.first
      					icms_xml_tag&.add_child(icms20_xml_tag)
      				end
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS20//xs:orig" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms20_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS20","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms20_xml_tag.nil?
      				origem_xml_tag = Nokogiri::XML("<orig>").elements.first
      				origem_xml_tag&.content = icms["origem"]
              icms20_xml_tag&.add_child(origem_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS20//xs:CST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms20_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS20","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms20_xml_tag.nil?
      				codigo_xml_tag = Nokogiri::XML("<CST>").elements.first
      				codigo_xml_tag&.content = icms["codigo"]
              icms20_xml_tag&.add_child(codigo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS20//xs:modBC" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms20_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS20","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms20_xml_tag.nil?
      				modalidade_xml_tag = Nokogiri::XML("<modBC>").elements.first
      				modalidade_xml_tag&.content = icms["modalidade"]
              icms20_xml_tag&.add_child(modalidade_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS20//xs:pRedBC" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms20_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS20","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms20_xml_tag.nil?
      				percentual_reducao_xml_tag = Nokogiri::XML("<pRedBC>").elements.first
      				percentual_reducao_xml_tag&.content = icms["percentual_reducao"]
              icms20_xml_tag&.add_child(percentual_reducao_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS20//xs:vBC" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms20_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS20","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms20_xml_tag.nil?
      				valor_base_calculo_xml_tag = Nokogiri::XML("<vBC>").elements.first
      				valor_base_calculo_xml_tag&.content = "%.2f" % (produtos[index]["preco"].to_d * produtos[index]["quantidade"].to_d).truncate(2)
              icms20_xml_tag&.add_child(valor_base_calculo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS20//xs:pICMS" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms20_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS20","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms20_xml_tag.nil?
      				aliquota_xml_tag = Nokogiri::XML("<pICMS>").elements.first
      				aliquota_xml_tag&.content = "%.2f" % icms["aliquota_icms"].to_d.truncate(2)
              icms20_xml_tag&.add_child(aliquota_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS20//xs:vICMS" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms20_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS20","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms20_xml_tag.nil?
      				valor_base_calculo_xml_tag = icms20_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS20//xs:vBC","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				aliquota_xml_tag = icms20_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS20//xs:pICMS","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				valor_icms_xml_tag = Nokogiri::XML("<vICMS>").elements.first
      				valor_icms_xml_tag&.content = "%.2f" % ((base_calculo_xml_tag.content.to_d * aliquota_xml_tag.content.to_d)/100.to_d).truncate(2)
              icms20_xml_tag&.add_child(valor_icms_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS20//xs:vBCFCP" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms20_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS20","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms20_xml_tag.nil?
      				valor_base_calculo_fcp_xml_tag = Nokogiri::XML("<vBCFCP>").elements.first
      				valor_base_calculo_fcp_xml_tag&.content = "%.2f" % (produtos[index]["preco"].to_d * produtos[index]["quantidade"].to_d).truncate(2)
              icms20_xml_tag&.add_child(valor_base_calculo_fcp_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS20//xs:pFCP" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms20_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS20","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms20_xml_tag.nil?
      				percentual_fcp_xml_tag = Nokogiri::XML("<pFCP>").elements.first
      				if !icms["percentual_fcp"].nil?
      					percentual_fcp_xml_tag&.content = "%.2f" % icms["percentual_fcp"].to_d.truncate(2)
      				else
      					percentual_fcp_xml_tag&.content = "%.2f" % 2
      				end
              icms20_xml_tag&.add_child(percentual_fcp_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS20//xs:vFCP" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms20_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS20","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms20_xml_tag.nil?
      				valor_base_calculo_fcp_xml_tag = icms20_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS20//xs:vBCFCP","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				percentual_fcp_xml_tag = icms20_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS20//xs:pFCP","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				valor_fcp_xml_tag = Nokogiri::XML("<vFCP>").elements.first
      				valor_fcp_xml_tag&.content = ((percentual_fcp_xml_tag.content.to_d * base_calculo_fcp_xml_tag.content.to_d)/100.to_d).truncate(2).to_digits
              icms20_xml_tag&.add_child(valor_fcp_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS20//xs:vICMSDeson" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms20_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS20","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms20_xml_tag.nil?
      				valor_icms_desonerado_xml_tag = Nokogiri::XML("<vICMSDeson>").elements.first
      				valor_icms_desonerado_xml_tag&.content = "%.2f" % icms.dig("icms_desonerado","valor_icms_desonerado").to_d.truncate(2)
              icms20_xml_tag&.add_child(valor_icms_desonerado_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS20//xs:motDesICMS" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms20_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS20","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms20_xml_tag.nil?
      				motivo_desoneracao_xml_tag = Nokogiri::XML("<motDesICMS>").elements.first
      				motivo_desoneracao_xml_tag&.content = icms.dig("icms_desonerado","motivo_desoneracao")
              icms20_xml_tag&.add_child(motivo_desoneracao_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS30" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			
      			if !icms_xml_tag.nil?
      				if icms["codigo"] == "30"
        				icms30_xml_tag = Nokogiri::XML("<ICMS30>").elements.first
      					icms_xml_tag&.add_child(icms30_xml_tag)
      				end
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS30//xs:orig" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms30_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS30","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms30_xml_tag.nil?
      				origem_xml_tag = Nokogiri::XML("<orig>").elements.first
      				origem_xml_tag&.content = icms["origem"]
              icms30_xml_tag&.add_child(origem_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS30//xs:CST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms30_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS30","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms30_xml_tag.nil?
      				codigo_xml_tag = Nokogiri::XML("<CST>").elements.first
      				codigo_xml_tag&.content = icms["codigo"]
              icms30_xml_tag&.add_child(codigo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS30//xs:modBCST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms30_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS30","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms30_xml_tag.nil?
      				modalidade_st_xml_tag = Nokogiri::XML("<modBCST>").elements.first
      				modalidade_st_xml_tag&.content = icms["modalidade_st"]
              icms30_xml_tag&.add_child(modalidade_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS30//xs:pMVAST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms30_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS30","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms30_xml_tag.nil?
      				percentual_mva_st_xml_tag = Nokogiri::XML("<pMVAST>").elements.first
      				percentual_mva_st_xml_tag&.content = icms["percentual_mva_st"]
              icms30_xml_tag&.add_child(percentual_mva_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS30//xs:pRedBCST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms30_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS30","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms30_xml_tag.nil?
      				percentual_reducao_st_xml_tag = Nokogiri::XML("<pRedBCST>").elements.first
      				percentual_reducao_st_xml_tag&.content = icms["percentual_reducao_st"]
              icms30_xml_tag&.add_child(percentual_reducao_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS30//xs:vBCST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms30_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS30","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms30_xml_tag.nil?
      				valor_base_calculo_st_xml_tag = Nokogiri::XML("<vBCST>").elements.first
      				valor_base_calculo_st_xml_tag&.content = "%.2f" % (produtos[index]["preco"].to_d * produtos[index]["quantidade"].to_d).truncate(2)
              icms30_xml_tag&.add_child(valor_base_calculo_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS30//xs:pICMSST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms30_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS30","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms30_xml_tag.nil?
      				aliquota_icmsst_xml_tag = Nokogiri::XML("<pICMSST>").elements.first
      				aliquota_icmsst_xml_tag&.content = "%.2f" % icms["aliquota_icms_st"].to_d.truncate(2)
              icms30_xml_tag&.add_child(aliquota_icmsst_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS30//xs:vICMSST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms30_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS30","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms30_xml_tag.nil?
      				valor_base_calculo_st_xml_tag = icms30_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS30//xs:vBCST","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				aliquota_st_xml_tag = icms30_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS30//xs:pICMSST","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				valor_icms_st_xml_tag = Nokogiri::XML("<vICMSST>").elements.first
      				valor_icms_st_xml_tag&.content = "%.2f" % ((base_calculo_st_xml_tag.content.to_d * aliquota_st_xml_tag.content.to_d)/100.to_d).truncate(2)
              icms30_xml_tag&.add_child(valor_icms_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS30//xs:vBCFCPST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms30_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS30","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms30_xml_tag.nil?
      				valor_base_calculo_fcp_st_xml_tag = Nokogiri::XML("<vBCFCPST>").elements.first
      				valor_base_calculo_fcp_st_xml_tag&.content = "%.2f" % (produtos[index]["preco"].to_d * produtos[index]["quantidade"].to_d).truncate(2)
              icms30_xml_tag&.add_child(valor_base_calculo_fcp_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS30//xs:pFCPST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms30_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS30","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms30_xml_tag.nil?
      				percentual_fcp_st_xml_tag = Nokogiri::XML("<pFCPST>").elements.first
      				if !icms["percentual_fcp_st"].nil?
      					percentual_fcp_st_xml_tag&.content = "%.2f" % icms["percentual_fcp_st"].to_d.truncate(2)
      				else
      					percentual_fcp_st_xml_tag&.content = "%.2f" % 2
      				end
              icms30_xml_tag&.add_child(percentual_fcp_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS30//xs:vFCPST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms30_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS30","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms30_xml_tag.nil?
      				valor_base_calculo_fcp_st_xml_tag = icms30_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS30//xs:vBCFCPST","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				aliquota_fcp_st_xml_tag = icms30_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS30//xs:pFCPST","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				valor_fcp_st_xml_tag = Nokogiri::XML("<vFCPST>").elements.first
      				valor_fcp_st_xml_tag&.content = "%.2f" % ((base_calculo_fcp_st_xml_tag.content.to_d * aliquota_fcp_st_xml_tag.content.to_d)/100.to_d).truncate(2)
              icms30_xml_tag&.add_child(valor_fcp_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS30//xs:vICMSDeson" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms30_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS30","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms30_xml_tag.nil?
      				valor_icms_desonerado_xml_tag = Nokogiri::XML("<vICMSDeson>").elements.first
      				valor_icms_desonerado_xml_tag&.content = "%.2f" % icms.dig("icms_desonerado","valor_icms_desonerado").to_d.truncate(2)
              icms30_xml_tag&.add_child(valor_icms_desonerado_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS30//xs:motDesICMS" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms30_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS30","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms30_xml_tag.nil?
      				motivo_desoneracao_st_xml_tag = Nokogiri::XML("<motDesICMS>").elements.first
      				motivo_desoneracao_st_xml_tag&.content = icms.dig("icms_desonerado","motivo_desoneracao")
              icms30_xml_tag&.add_child(motivo_desoneracao_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS40" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			
      			if !icms_xml_tag.nil?
      				if ['40','41','50'].include?(icms["codigo"])
      					icms40_xml_tag = Nokogiri::XML("<ICMS40>").elements.first
      					icms_xml_tag&.add_child(icms40_xml_tag)
      				end
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS40//xs:orig" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms40_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS40","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms40_xml_tag.nil?
      				origem_xml_tag = Nokogiri::XML("<orig>").elements.first
      				origem_xml_tag&.content = icms["origem"]
              icms40_xml_tag&.add_child(origem_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS40//xs:CST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms40_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS40","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms40_xml_tag.nil?
      				codigo_xml_tag = Nokogiri::XML("<CST>").elements.first
      				codigo_xml_tag&.content = icms["codigo"]
              icms40_xml_tag&.add_child(codigo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS40//xs:vICMSDeson" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms40_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS40","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms40_xml_tag.nil?
      				valor_icms_desonerado_xml_tag = Nokogiri::XML("<vICMSDeson>").elements.first
      				valor_icms_desonerado_xml_tag&.content = "%.2f" % icms.dig("icms_desonerado","valor_icms_desonerado").to_d.truncate(2)
              icms40_xml_tag&.add_child(valor_icms_desonerado_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS40//xs:motDesICMS" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms40_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS40","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms40_xml_tag.nil?
      				motivo_desoneracao_st_xml_tag = Nokogiri::XML("<motDesICMS>").elements.first
      				motivo_desoneracao_st_xml_tag&.content = icms.dig("icms_desonerado","motivo_desoneracao")
              icms40_xml_tag&.add_child(motivo_desoneracao_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS51" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms_xml_tag.nil?
      				if icms["codigo"] == "51"
      					icms51_xml_tag = Nokogiri::XML("<ICMS51>").elements.first
      					icms_xml_tag&.add_child(icms51_xml_tag)
      				end
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS51//xs:orig" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms51_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS51","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms51_xml_tag.nil?
      				origem_xml_tag = Nokogiri::XML("<orig>").elements.first
      				origem_xml_tag&.content = icms["origem"]
              icms51_xml_tag&.add_child(origem_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS51//xs:CST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms51_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS51","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms51_xml_tag.nil?
      				codigo_xml_tag = Nokogiri::XML("<CST>").elements.first
      				codigo_xml_tag&.content = icms["codigo"]
              icms51_xml_tag&.add_child(codigo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS51//xs:modBC" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms51_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS51","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms51_xml_tag.nil?
      				modalidade_xml_tag = Nokogiri::XML("<modBC>").elements.first
      				modalidade_xml_tag&.content = icms["modalidade"]
              icms51_xml_tag&.add_child(modalidade_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS51//xs:pRedBC" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms51_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS51","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms51_xml_tag.nil?
      				percentual_reducao_xml_tag = Nokogiri::XML("<pRedBC>").elements.first
      				percentual_reducao_xml_tag&.content = icms["percentual_reducao"]
              icms51_xml_tag&.add_child(percentual_reducao_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS51//xs:vBC" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms51_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS51","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms51_xml_tag.nil?
      				valor_base_calculo_xml_tag = Nokogiri::XML("<vBC>").elements.first
      				valor_base_calculo_xml_tag&.content = "%.2f" % (produtos[index]["preco"].to_d * produtos[index]["quantidade"].to_d).truncate(2)
              icms51_xml_tag&.add_child(valor_base_calculo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS51//xs:pICMS" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms51_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS51","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms51_xml_tag.nil?
      				aliquota_xml_tag = Nokogiri::XML("<pICMS>").elements.first
      				aliquota_xml_tag&.content = "%.2f" % icms["aliquota_icms"].to_d.truncate(2)
              icms51_xml_tag&.add_child(aliquota_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS51//xs:vICMSOp" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms51_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS51","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms51_xml_tag.nil?
      				valor_base_calculo_xml_tag = icms51_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS51//xs:vBC","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				aliquota_xml_tag = icms51_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS51//xs:pICMS","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				valor_icms_operacao_xml_tag = Nokogiri::XML("<vICMSOp>").elements.first
      				valor_icms_operacao_xml_tag&.content = "%.2f" % ((base_calculo_xml_tag.content.to_d * aliquota_xml_tag.content.to_d)/100.to_d).truncate(2)
              icms51_xml_tag&.add_child(valor_icms_operacao_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS51//xs:pDif" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms51_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS51","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms51_xml_tag.nil?
      				percentual_diferimento_xml_tag = Nokogiri::XML("<pDif>").elements.first
      				percentual_diferimento_xml_tag&.content = "%.2f" % icms["percentual_diferimento"].to_d.truncate(2)
              icms51_xml_tag&.add_child(percentual_diferimento_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS51//xs:vICMSDif" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms51_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS51","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms51_xml_tag.nil?
      				percentual_diferimento_xml_tag = icms51_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS51//xs:pDif","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				valor_icms_operacao_xml_tag = icms51_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS51//xs:vICMSOp","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				valor_icms_diferido_xml_tag = Nokogiri::XML("<vICMSDif>").elements.first
      				valor_icms_diferido_xml_tag&.content = "%.2f" % ((icms["percentual_diferimento"].to_d * valor_icms_operacao_xml_tag.content.to_d)/100.to_d).truncate(2)
              icms51_xml_tag&.add_child(valor_icms_diferido_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS51//xs:vICMS" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms51_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS51","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms51_xml_tag.nil?
      				valor_base_calculo_xml_tag = icms51_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS51//xs:vBC","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				aliquota_xml_tag = icms51_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS51//xs:pICMS","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				valor_icms_xml_tag = Nokogiri::XML("<vICMS>").elements.first
      				valor_icms_xml_tag&.content = "%.2f" % ((base_calculo_xml_tag.content.to_d * aliquota_xml_tag.content.to_d)/100.to_d).truncate(2)
              icms51_xml_tag&.add_child(valor_icms_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS51//xs:vBCFCP" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms51_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS51","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms51_xml_tag.nil?
      				valor_base_calculo_fcp_xml_tag = Nokogiri::XML("<vBCFCP>").elements.first
      				valor_base_calculo_fcp_xml_tag&.content = "%.2f" % (produtos[index]["preco"].to_d * produtos[index]["quantidade"].to_d).truncate(2)
              icms51_xml_tag&.add_child(valor_base_calculo_fcp_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS51//xs:pFCP" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms51_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS51","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms51_xml_tag.nil?
      				percentual_fcp_xml_tag = Nokogiri::XML("<pFCP>").elements.first
      				if !icms["percentual_fcp"].nil?
      					percentual_fcp_xml_tag&.content = "%.2f" % icms["percentual_fcp"].to_d.truncate(2)
      				else
      					percentual_fcp_xml_tag&.content = "%.2f" % 2
      				end
              icms51_xml_tag&.add_child(percentual_fcp_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS51//xs:vFCP" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms51_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS51","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms51_xml_tag.nil?
      				valor_base_calculo_fcp_xml_tag = icms51_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS51//xs:vBCFCP","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				percentual_fcp_xml_tag = icms51_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS51//xs:pFCP","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				valor_fcp_xml_tag = Nokogiri::XML("<vFCP>").elements.first
      				valor_fcp_xml_tag&.content = ((percentual_fcp_xml_tag.content.to_d * base_calculo_fcp_xml_tag.content.to_d)/100.to_d).truncate(2).to_digits
              icms51_xml_tag&.add_child(valor_fcp_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS60" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms_xml_tag.nil?
      				if icms["codigo"] == "60"
      					icms60_xml_tag = Nokogiri::XML("<ICMS60>").elements.first
      					icms_xml_tag&.add_child(icms60_xml_tag)
      				end
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS60//xs:orig" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms60_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS60","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms60_xml_tag.nil?
      				origem_xml_tag = Nokogiri::XML("<orig>").elements.first
      				origem_xml_tag&.content = icms["origem"]
              icms60_xml_tag&.add_child(origem_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS60//xs:CST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms60_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS60","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms60_xml_tag.nil?
      				codigo_xml_tag = Nokogiri::XML("<CST>").elements.first
      				codigo_xml_tag&.content = icms["codigo"]
              icms60_xml_tag&.add_child(codigo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS60//xs:vBCSTRet" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms60_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS60","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms60_xml_tag.nil?
      				valor_base_calculo_st_retido_xml_tag = Nokogiri::XML("<vBCSTRet>").elements.first
      				valor_base_calculo_st_retido_xml_tag&.content = icms["valor_base_calculo_st_retido"]
              icms60_xml_tag&.add_child(valor_base_calculo_st_retido_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS60//xs:pST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms60_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS60","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms60_xml_tag.nil?
      				percentual_consumidor_final_xml_tag = Nokogiri::XML("<pST>").elements.first
      				percentual_consumidor_final_xml_tag&.content = icms["percentual_consumidor_final"]
              icms60_xml_tag&.add_child(percentual_consumidor_final_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS60//xs:vICMSSubstituto" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms60_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS60","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms60_xml_tag.nil?
      				valor_icms_subtituto_xml_tag = Nokogiri::XML("<vICMSSubstituto>").elements.first
      				valor_icms_subtituto_xml_tag&.content = "%.2f" % icms["valor_icms_subtituto"].to_d.truncate(2)
              icms60_xml_tag&.add_child(valor_icms_substituto_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS60//xs:vICMSSTRet" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms60_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS60","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms60_xml_tag.nil?
      				valor_icms_st_retido_xml_tag = Nokogiri::XML("<vICMSSTRet>").elements.first
      				valor_icms_st_retido_xml_tag&.content = "%.2f" % icms["valor_icms_st_retido"].to_d.truncate(2)
              icms60_xml_tag&.add_child(valor_icms_st_retido_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS60//xs:vBCFCPSTRet" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms60_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS60","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms60_xml_tag.nil?
      				valor_base_calculo_fcp_st_retido_xml_tag = Nokogiri::XML("<vBCFCPSTRet>").elements.first
      				valor_base_calculo_fcp_st_retido_xml_tag&.content = "%.2f" % icms["valor_base_calculo_fcp_st_retido"].to_d.truncate(2)
              icms60_xml_tag&.add_child(valor_base_calculo_fcp_st_retido_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS60//xs:pFCPSTRet" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms60_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS60","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms60_xml_tag.nil?
      				percentual_fcp_st_retido_xml_tag = Nokogiri::XML("<pFCPSTRet>").elements.first
      				percentual_fcp_st_retido_xml_tag&.content = "%.2f" % icms["percentual_fcp_st_retido"].to_d.truncate(2)
              icms60_xml_tag&.add_child(percentual_fcp_st_retido_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS60//xs:vFCPSTRet" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms60_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS60","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms60_xml_tag.nil?
      				valor_fcp_st_retido_xml_tag = Nokogiri::XML("<vFCPSTRet>").elements.first
      				valor_fcp_st_retido_xml_tag&.content = "%.2f" % icms["valor_fcp_st_retido"].to_d.truncate(2)
              icms60_xml_tag&.add_child(valor_fcp_st_retido_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS60//xs:pRedBCEfet" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms60_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS60","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms60_xml_tag.nil?
      				percentual_reducao_efetiva_xml_tag = Nokogiri::XML("<pRedBCEfet>").elements.first
      				percentual_reducao_efetiva_xml_tag&.content = "%.2f" % icms.dig("icms_efetivo","percentual_reducao_efetiva").to_d.truncate(2)
              icms60_xml_tag&.add_child(percentual_reducao_efetiva_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS60//xs:vBCEfet" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms60_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS60","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms60_xml_tag.nil?
      				valor_base_calculo_efetiva_xml_tag = Nokogiri::XML("<vBCEfet>").elements.first
      				valor_base_calculo_efetiva_xml_tag&.content = "%.2f" % (produtos[index]["preco"].to_d * produtos[index]["quantidade"].to_d * (1.to_d - icms["percentual_reducao_efetiva"].to_d/100.to_d)).truncate(2)
              icms60_xml_tag&.add_child(valor_base_calculo_efetiva_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS60//xs:pICMSEfet" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms60_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS60","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms60_xml_tag.nil?
      				percentual_icms_efetivo_xml_tag = Nokogiri::XML("<pICMSEfet>").elements.first
      				percentual_icms_efetivo_xml_tag&.content = "%.2f" % icms["aliquota_icms"].to_d.truncate(2)
              icms60_xml_tag&.add_child(percentual_icms_efetivo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS60//xs:vICMSEfet" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms60_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS60","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms60_xml_tag.nil?
      				valor_base_calculo_efetiva_xml_tag = icms60_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS60//xs:vBCEfet","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				aliquota_efetiva_xml_tag = icms60_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS60//xs:pICMSEfet","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				valor_icms_efetivo_xml_tag = Nokogiri::XML("<vICMSEfet>").elements.first
      				valor_icms_efetivo_xml_tag&.content = "%.2f" % ((base_calculo_efetiva_xml_tag.content.to_d * aliquota_efetiva_xml_tag.content.to_d)/100.to_d).truncate(2)
              icms60_xml_tag&.add_child(valor_icms_efetivo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms_xml_tag.nil?
      				if icms["codigo"] == "70"
      					icms70_xml_tag = Nokogiri::XML("<ICMS70>").elements.first
      					icms_xml_tag&.add_child(icms70_xml_tag)
      				end
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70//xs:orig" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms70_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms70_xml_tag.nil?
      				origem_xml_tag = Nokogiri::XML("<orig>").elements.first
      				origem_xml_tag&.content = icms["origem"]
              icms70_xml_tag&.add_child(origem_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70//xs:CST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms70_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms70_xml_tag.nil?
      				codigo_xml_tag = Nokogiri::XML("<CST>").elements.first
      				codigo_xml_tag&.content = icms["codigo"]
              icms70_xml_tag&.add_child(codigo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70//xs:modBC" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms70_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms70_xml_tag.nil?
      				modalidade_xml_tag = Nokogiri::XML("<modBC>").elements.first
      				modalidade_xml_tag&.content = icms["modalidade"]
              icms70_xml_tag&.add_child(modalidade_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70//xs:pRedBC" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms70_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms70_xml_tag.nil?
      				percentual_reducao_xml_tag = Nokogiri::XML("<pRedBC>").elements.first
      				percentual_reducao_xml_tag&.content = icms["percentual_reducao"]
              icms70_xml_tag&.add_child(percentual_reducao_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70//xs:vBC" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms70_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms70_xml_tag.nil?
      				valor_base_calculo_xml_tag = Nokogiri::XML("<vBC>").elements.first
      				valor_base_calculo_xml_tag&.content = "%.2f" % (produtos[index]["preco"].to_d * produtos[index]["quantidade"].to_d).truncate(2)
              icms70_xml_tag&.add_child(valor_base_calculo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70//xs:pICMS" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms70_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms70_xml_tag.nil?
      				aliquota_xml_tag = Nokogiri::XML("<pICMS>").elements.first
      				aliquota_xml_tag&.content = "%.2f" % icms["aliquota_icms"].to_d.truncate(2)
              icms70_xml_tag&.add_child(aliquota_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70//xs:vICMS" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms70_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms70_xml_tag.nil?
      				valor_base_calculo_xml_tag = icms70_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70//xs:vBC","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				aliquota_xml_tag = icms70_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70//xs:pICMS","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				valor_icms_xml_tag = Nokogiri::XML("<vICMS>").elements.first
      				valor_icms_xml_tag&.content = "%.2f" % ((base_calculo_xml_tag.content.to_d * aliquota_xml_tag.content.to_d)/100.to_d).truncate(2)
              icms70_xml_tag&.add_child(valor_icms_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70//xs:modBCST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms70_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms70_xml_tag.nil?
      				modalidade_st_xml_tag = Nokogiri::XML("<modBCST>").elements.first
      				modalidade_st_xml_tag&.content = icms["modalidade_st"]
              icms70_xml_tag&.add_child(modalidade_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70//xs:pMVAST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms70_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms70_xml_tag.nil?
      				percentual_mva_st_xml_tag = Nokogiri::XML("<pMVAST>").elements.first
      				percentual_mva_st_xml_tag&.content = icms["percentual_mva_st"]
              icms70_xml_tag&.add_child(percentual_mva_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70//xs:pRedBCST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms70_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms70_xml_tag.nil?
      				percentual_reducao_st_xml_tag = Nokogiri::XML("<pRedBCST>").elements.first
      				percentual_reducao_st_xml_tag&.content = icms["percentual_reducao_st"]
              icms70_xml_tag&.add_child(percentual_reducao_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70//xs:vBCST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms70_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms70_xml_tag.nil?
      				valor_base_calculo_st_xml_tag = Nokogiri::XML("<vBCST>").elements.first
      				valor_base_calculo_st_xml_tag&.content = "%.2f" % (produtos[index]["preco"].to_d * produtos[index]["quantidade"].to_d).truncate(2)
              icms70_xml_tag&.add_child(valor_base_calculo_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70//xs:pICMSST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms70_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms70_xml_tag.nil?
      				aliquota_icmsst_xml_tag = Nokogiri::XML("<pICMSST>").elements.first
      				aliquota_icmsst_xml_tag&.content = "%.2f" % icms["aliquota_icms_st"].to_d.truncate(2)
              icms70_xml_tag&.add_child(aliquota_icmsst_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70//xs:vICMSST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms70_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms70_xml_tag.nil?
      				valor_base_calculo_st_xml_tag = icms70_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70//xs:vBCST","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				aliquota_st_xml_tag = icms70_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70//xs:pICMSST","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				valor_icms_st_xml_tag = Nokogiri::XML("<vICMSST>").elements.first
      				valor_icms_st_xml_tag&.content = "%.2f" % ((base_calculo_st_xml_tag.content.to_d * aliquota_st_xml_tag.content.to_d)/100.to_d).truncate(2)
              icms70_xml_tag&.add_child(valor_icms_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70//xs:vBCFCP" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms70_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms70_xml_tag.nil?
      				valor_base_calculo_fcp_xml_tag = Nokogiri::XML("<vBCFCP>").elements.first
      				valor_base_calculo_fcp_xml_tag&.content = "%.2f" % (produtos[index]["preco"].to_d * produtos[index]["quantidade"].to_d).truncate(2)
              icms70_xml_tag&.add_child(valor_base_calculo_fcp_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70//xs:pFCP" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms70_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms70_xml_tag.nil?
      				percentual_fcp_xml_tag = Nokogiri::XML("<pFCP>").elements.first
      				if !icms["percentual_fcp"].nil?
      					percentual_fcp_xml_tag&.content = "%.2f" % icms["percentual_fcp"].to_d.truncate(2)
      				else
      					percentual_fcp_xml_tag&.content = "%.2f" % 2
      				end
              icms70_xml_tag&.add_child(percentual_fcp_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70//xs:vFCP" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms70_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms70_xml_tag.nil?
      				valor_base_calculo_fcp_xml_tag = icms70_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70//xs:vBCFCP","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				percentual_fcp_xml_tag = icms70_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70//xs:pFCP","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				valor_fcp_xml_tag = Nokogiri::XML("<vFCP>").elements.first
      				valor_fcp_xml_tag&.content = ((percentual_fcp_xml_tag.content.to_d * base_calculo_fcp_xml_tag.content.to_d)/100.to_d).truncate(2).to_digits
              icms70_xml_tag&.add_child(valor_fcp_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70//xs:vBCFCPST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms70_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms70_xml_tag.nil?
      				valor_base_calculo_fcp_st_xml_tag = Nokogiri::XML("<vBCFCPST>").elements.first
      				valor_base_calculo_fcp_st_xml_tag&.content = "%.2f" % (produtos[index]["preco"].to_d * produtos[index]["quantidade"].to_d).truncate(2)
              icms70_xml_tag&.add_child(valor_base_calculo_fcp_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70//xs:pFCPST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms70_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms70_xml_tag.nil?
      				percentual_fcp_st_xml_tag = Nokogiri::XML("<pFCPST>").elements.first
      				if !icms["percentual_fcp_st"].nil?
      					percentual_fcp_st_xml_tag&.content = "%.2f" % icms["percentual_fcp_st"].to_d.truncate(2)
      				else
      					percentual_fcp_st_xml_tag&.content = "%.2f" % 2
      				end
              icms70_xml_tag&.add_child(percentual_fcp_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70//xs:vFCPST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms70_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms70_xml_tag.nil?
      				valor_base_calculo_fcp_st_xml_tag = icms70_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70//xs:vBCFCPST","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				aliquota_fcp_st_xml_tag = icms70_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70//xs:pFCPST","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				valor_fcp_st_xml_tag = Nokogiri::XML("<vFCPST>").elements.first
      				valor_fcp_st_xml_tag&.content = "%.2f" % ((base_calculo_fcp_st_xml_tag.content.to_d * aliquota_fcp_st_xml_tag.content.to_d)/100.to_d).truncate(2)
              icms70_xml_tag&.add_child(valor_fcp_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70//xs:vICMSDeson" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms70_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms70_xml_tag.nil?
      				valor_icms_desonerado_xml_tag = Nokogiri::XML("<vICMSDeson>").elements.first
      				valor_icms_desonerado_xml_tag&.content = "%.2f" % icms.dig("icms_desonerado","valor_icms_desonerado").to_d.truncate(2)
              icms70_xml_tag&.add_child(valor_icms_desonerado_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70//xs:motDesICMS" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms70_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS70","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms70_xml_tag.nil?
      				motivo_desoneracao_st_xml_tag = Nokogiri::XML("<motDesICMS>").elements.first
      				motivo_desoneracao_st_xml_tag&.content = icms.dig("icms_desonerado","motivo_desoneracao")
              icms70_xml_tag&.add_child(motivo_desoneracao_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms_xml_tag.nil?
      				if icms["codigo"] == "90"
      					icms90_xml_tag = Nokogiri::XML("<ICMS90>").elements.first
      					icms_xml_tag&.add_child(icms90_xml_tag)
      				end
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90//xs:orig" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms90_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms90_xml_tag.nil?
      				origem_xml_tag = Nokogiri::XML("<orig>").elements.first
      				origem_xml_tag&.content = icms["origem"]
              icms90_xml_tag&.add_child(origem_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90//xs:CST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms90_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms90_xml_tag.nil?
      				codigo_xml_tag = Nokogiri::XML("<CST>").elements.first
      				codigo_xml_tag&.content = icms["codigo"]
              icms90_xml_tag&.add_child(codigo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90//xs:modBC" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms90_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms90_xml_tag.nil?
      				modalidade_xml_tag = Nokogiri::XML("<modBC>").elements.first
      				modalidade_xml_tag&.content = icms["modalidade"]
              icms90_xml_tag&.add_child(modalidade_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90//xs:vBC" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms90_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms90_xml_tag.nil?
      				valor_base_calculo_xml_tag = Nokogiri::XML("<vBC>").elements.first
      				valor_base_calculo_xml_tag&.content = "%.2f" % (produtos[index]["preco"].to_d * produtos[index]["quantidade"].to_d).truncate(2)
              icms90_xml_tag&.add_child(valor_base_calculo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90//xs:pRedBC" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms90_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms90_xml_tag.nil?
      				percentual_reducao_xml_tag = Nokogiri::XML("<pRedBC>").elements.first
      				percentual_reducao_xml_tag&.content = icms["percentual_reducao"].to_d.truncate(2)
              icms90_xml_tag&.add_child(percentual_reducao_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90//xs:pICMS" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms90_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms90_xml_tag.nil?
      				aliquota_xml_tag = Nokogiri::XML("<pICMS>").elements.first
      				aliquota_xml_tag&.content = "%.2f" % icms["aliquota_icms"].to_d.truncate(2)
              icms90_xml_tag&.add_child(aliquota_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90//xs:vICMS" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms90_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms90_xml_tag.nil?
      				valor_base_calculo_xml_tag = icms90_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90//xs:vBC","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				aliquota_xml_tag = icms90_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90//xs:pICMS","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				valor_icms_xml_tag = Nokogiri::XML("<vICMS>").elements.first
      				valor_icms_xml_tag&.content = "%.2f" % ((base_calculo_xml_tag.content.to_d * aliquota_xml_tag.content.to_d)/100.to_d).truncate(2)
              icms90_xml_tag&.add_child(valor_icms_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90//xs:vBCFCP" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms90_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms90_xml_tag.nil?
      				valor_base_calculo_fcp_xml_tag = Nokogiri::XML("<vBCFCP>").elements.first
      				valor_base_calculo_fcp_xml_tag&.content = "%.2f" % (produtos[index]["preco"].to_d * produtos[index]["quantidade"].to_d).truncate(2)
              icms90_xml_tag&.add_child(valor_base_calculo_fcp_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90//xs:pFCP" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms90_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms90_xml_tag.nil?
      				percentual_fcp_xml_tag = Nokogiri::XML("<pFCP>").elements.first
      				if !icms["percentual_fcp"].nil?
      					percentual_fcp_xml_tag&.content = "%.2f" % icms["percentual_fcp"].to_d.truncate(2)
      				else
      					percentual_fcp_xml_tag&.content = "%.2f" % 2
      				end
              icms90_xml_tag&.add_child(percentual_fcp_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90//xs:vFCP" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms90_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms90_xml_tag.nil?
      				valor_base_calculo_fcp_xml_tag = icms90_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90//xs:vBCFCP","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				percentual_fcp_xml_tag = icms90_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90//xs:pFCP","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				valor_fcp_xml_tag = Nokogiri::XML("<vFCP>").elements.first
      				valor_fcp_xml_tag&.content = ((percentual_fcp_xml_tag.content.to_d * base_calculo_fcp_xml_tag.content.to_d)/100.to_d).truncate(2).to_digits
              icms90_xml_tag&.add_child(valor_fcp_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90//xs:modBCST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms90_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms90_xml_tag.nil?
      				modalidade_st_xml_tag = Nokogiri::XML("<modBCST>").elements.first
      				modalidade_st_xml_tag&.content = icms["modalidade_st"]
              icms90_xml_tag&.add_child(modalidade_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90//xs:pMVAST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms90_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms90_xml_tag.nil?
      				percentual_mva_st_xml_tag = Nokogiri::XML("<pMVAST>").elements.first
      				percentual_mva_st_xml_tag&.content = icms["percentual_mva_st"]
              icms90_xml_tag&.add_child(percentual_mva_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90//xs:pRedBCST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms90_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms90_xml_tag.nil?
      				percentual_reducao_st_xml_tag = Nokogiri::XML("<pRedBCST>").elements.first
      				percentual_reducao_st_xml_tag&.content = icms["percentual_reducao_st"]
              icms90_xml_tag&.add_child(percentual_reducao_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90//xs:vBCST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms90_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms90_xml_tag.nil?
      				valor_base_calculo_st_xml_tag = Nokogiri::XML("<vBCST>").elements.first
      				valor_base_calculo_st_xml_tag&.content = "%.2f" % (produtos[index]["preco"].to_d * produtos[index]["quantidade"].to_d).truncate(2)
              icms90_xml_tag&.add_child(valor_base_calculo_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90//xs:pICMSST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms90_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms90_xml_tag.nil?
      				aliquota_icmsst_xml_tag = Nokogiri::XML("<pICMSST>").elements.first
      				aliquota_icmsst_xml_tag&.content = "%.2f" % icms["aliquota_icms_st"].to_d.truncate(2)
              icms90_xml_tag&.add_child(aliquota_icmsst_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90//xs:vICMSST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms90_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms90_xml_tag.nil?
      				valor_base_calculo_st_xml_tag = icms90_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90//xs:vBCST","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				aliquota_st_xml_tag = icms90_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90//xs:pICMSST","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				valor_icms_st_xml_tag = Nokogiri::XML("<vICMSST>").elements.first
      				valor_icms_st_xml_tag&.content = "%.2f" % ((base_calculo_st_xml_tag.content.to_d * aliquota_st_xml_tag.content.to_d)/100.to_d).truncate(2)
              icms90_xml_tag&.add_child(valor_icms_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90//xs:vBCFCPST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms90_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms90_xml_tag.nil?
      				valor_base_calculo_fcp_st_xml_tag = Nokogiri::XML("<vBCFCPST>").elements.first
      				valor_base_calculo_fcp_st_xml_tag&.content = "%.2f" % (produtos[index]["preco"].to_d * produtos[index]["quantidade"].to_d).truncate(2)
              icms90_xml_tag&.add_child(valor_base_calculo_fcp_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90//xs:pFCPST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms90_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms90_xml_tag.nil?
      				percentual_fcp_st_xml_tag = Nokogiri::XML("<pFCPST>").elements.first
      				if !icms["percentual_fcp_st"].nil?
      					percentual_fcp_st_xml_tag&.content = "%.2f" % icms["percentual_fcp_st"].to_d.truncate(2)
      				else
      					percentual_fcp_st_xml_tag&.content = "%.2f" % 2
      				end
              icms90_xml_tag&.add_child(percentual_fcp_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90//xs:vFCPST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms90_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms90_xml_tag.nil?
      				valor_base_calculo_fcp_st_xml_tag = icms90_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90//xs:vBCFCPST","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				aliquota_fcp_st_xml_tag = icms90_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90//xs:pFCPST","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				valor_fcp_st_xml_tag = Nokogiri::XML("<vFCPST>").elements.first
      				valor_fcp_st_xml_tag&.content = "%.2f" % ((base_calculo_fcp_st_xml_tag.content.to_d * aliquota_fcp_st_xml_tag.content.to_d)/100.to_d).truncate(2)
              icms90_xml_tag&.add_child(valor_fcp_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90//xs:vICMSDeson" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms90_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms90_xml_tag.nil?
      				valor_icms_desonerado_xml_tag = Nokogiri::XML("<vICMSDeson>").elements.first
      				valor_icms_desonerado_xml_tag&.content = "%.2f" % icms.dig("icms_desonerado","valor_icms_desonerado").to_d.truncate(2)
              icms90_xml_tag&.add_child(valor_icms_desonerado_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90//xs:motDesICMS" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms90_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMS90","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms90_xml_tag.nil?
      				motivo_desoneracao_st_xml_tag = Nokogiri::XML("<motDesICMS>").elements.first
      				motivo_desoneracao_st_xml_tag&.content = icms.dig("icms_desonerado","motivo_desoneracao")
              icms90_xml_tag&.add_child(motivo_desoneracao_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms_xml_tag.nil?
      				if ["10","90"].include?(icms["codigo"])
      					icms_part_xml_tag = Nokogiri::XML("<ICMSPart>").elements.first
      					icms_xml_tag&.add_child(icms_part_xml_tag)
      				end
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart//xs:orig" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms_part_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms_part_xml_tag.nil?
      				origem_xml_tag = Nokogiri::XML("<orig>").elements.first
      				origem_xml_tag&.content = icms["origem"]
              icms_part_xml_tag&.add_child(origem_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart//xs:CST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms_part_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms_part_xml_tag.nil?
      				codigo_xml_tag = Nokogiri::XML("<CST>").elements.first
      				codigo_xml_tag&.content = icms["codigo"]
              icms_part_xml_tag&.add_child(codigo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart//xs:modBC" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms_part_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms_part_xml_tag.nil?
      				modalidade_xml_tag = Nokogiri::XML("<modBC>").elements.first
      				modalidade_xml_tag&.content = icms["modalidade"]
              icms_part_xml_tag&.add_child(modalidade_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart//xs:vBC" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms_part_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms_part_xml_tag.nil?
      				valor_base_calculo_xml_tag = Nokogiri::XML("<vBC>").elements.first
      				valor_base_calculo_xml_tag&.content = "%.2f" % (produtos[index]["preco"].to_d * produtos[index]["quantidade"].to_d).truncate(2)
              icms_part_xml_tag&.add_child(valor_base_calculo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart//xs:pRedBC" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms_part_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms_part_xml_tag.nil?
      				percentual_reducao_xml_tag = Nokogiri::XML("<pRedBC>").elements.first
      				percentual_reducao_xml_tag&.content = "%.2f" % icms["percentual_reducao"].to_d.truncate(2)
              icms_part_xml_tag&.add_child(percentual_reducao_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart//xs:pICMS" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms_part_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms_part_xml_tag.nil?
      				aliquota_xml_tag = Nokogiri::XML("<pICMS>").elements.first
      				aliquota_xml_tag&.content = "%.2f" % icms["aliquota_icms"].to_d.truncate(2)
              icms_part_xml_tag&.add_child(aliquota_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart//xs:vICMS" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms_part_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms_part_xml_tag.nil?
      				valor_base_calculo_xml_tag = icms_part_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart//xs:vBC","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				aliquota_xml_tag = icms_part_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart//xs:pICMS","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				valor_icms_xml_tag = Nokogiri::XML("<vICMS>").elements.first
      				valor_icms_xml_tag&.content = "%.2f" % ((base_calculo_xml_tag.content.to_d * aliquota_xml_tag.content.to_d)/100.to_d).truncate(2)
              icms_part_xml_tag&.add_child(valor_icms_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart//xs:modBCST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms_part_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms_part_xml_tag.nil?
      				modalidade_st_xml_tag = Nokogiri::XML("<modBCST>").elements.first
      				modalidade_st_xml_tag&.content = icms["modalidade_st"]
              icms_part_xml_tag&.add_child(modalidade_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart//xs:pMVAST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms_part_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms_part_xml_tag.nil?
      				percentual_mva_st_xml_tag = Nokogiri::XML("<pMVAST>").elements.first
      				percentual_mva_st_xml_tag&.content = icms["percentual_mva_st"]
              icms_part_xml_tag&.add_child(percentual_mva_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart//xs:pRedBCST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms_part_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms_part_xml_tag.nil?
      				percentual_reducao_st_xml_tag = Nokogiri::XML("<pRedBCST>").elements.first
      				percentual_reducao_st_xml_tag&.content = icms["percentual_reducao_st"]
              icms_part_xml_tag&.add_child(percentual_reducao_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart//xs:vBCST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms_part_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms_part_xml_tag.nil?
      				valor_base_calculo_st_xml_tag = Nokogiri::XML("<vBCST>").elements.first
      				valor_base_calculo_st_xml_tag&.content = "%.2f" % (produtos[index]["preco"].to_d * produtos[index]["quantidade"].to_d).truncate(2)
              icms_part_xml_tag&.add_child(valor_base_calculo_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart//xs:pICMSST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms_part_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms_part_xml_tag.nil?
      				aliquota_icmsst_xml_tag = Nokogiri::XML("<pICMSST>").elements.first
      				aliquota_icmsst_xml_tag&.content = "%.2f" % icms["aliquota_icms_st"].to_d.truncate(2)
              icms_part_xml_tag&.add_child(aliquota_icmsst_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart//xs:vICMSST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms_part_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms_part_xml_tag.nil?
      				valor_base_calculo_st_xml_tag = icms_part_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart//xs:vBCST","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				aliquota_st_xml_tag = icms_part_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart//xs:pICMSST","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				valor_icms_st_xml_tag = Nokogiri::XML("<vICMSST>").elements.first
      				valor_icms_st_xml_tag&.content = "%.2f" % ((base_calculo_st_xml_tag.content.to_d * aliquota_st_xml_tag.content.to_d)/100.to_d).truncate(2)
              icms_part_xml_tag&.add_child(valor_icms_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart//xs:vBCFCPST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms_part_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms_part_xml_tag.nil?
      				valor_base_calculo_fcp_st_xml_tag = Nokogiri::XML("<vBCFCPST>").elements.first
      				valor_base_calculo_fcp_st_xml_tag&.content = "%.2f" % (produtos[index]["preco"].to_d * produtos[index]["quantidade"].to_d).truncate(2)
              icms_part_xml_tag&.add_child(valor_base_calculo_fcp_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart//xs:pFCPST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms_part_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms_part_xml_tag.nil?
      				percentual_fcp_st_xml_tag = Nokogiri::XML("<pFCPST>").elements.first
      				if !icms["percentual_fcp_st"].nil?
      					percentual_fcp_st_xml_tag&.content = "%.2f" % icms["percentual_fcp_st"].to_d.truncate(2)
      				else
      					percentual_fcp_st_xml_tag&.content = "%.2f" % 2
      				end
              icms_part_xml_tag&.add_child(percentual_fcp_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart//xs:vFCPST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms_part_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms_part_xml_tag.nil?
      				valor_base_calculo_fcp_st_xml_tag = icms_part_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart//xs:vBCFCPST","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				aliquota_fcp_st_xml_tag = icms_part_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart//xs:pFCPST","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				valor_fcp_st_xml_tag = Nokogiri::XML("<vFCPST>").elements.first
      				valor_fcp_st_xml_tag&.content = "%.2f" % ((base_calculo_fcp_st_xml_tag.content.to_d * aliquota_fcp_st_xml_tag.content.to_d)/100.to_d).truncate(2)
              icms_part_xml_tag&.add_child(valor_fcp_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart//xs:pBCOp" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms_part_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms_part_xml_tag.nil?
      				percentual_operacao_propria_xml_tag = Nokogiri::XML("<pBCOp>").elements.first
      				percentual_operacao_propria_xml_tag&.content = icms["percentual_operacao_propria"]
              icms_part_xml_tag&.add_child(percentual_operacao_propria_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart//xs:UFST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms_part_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSPart","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms_part_xml_tag.nil?
      				ufst_xml_tag = Nokogiri::XML("<UFST>").elements.first
      				ufst_xml_tag&.content = msg.dig("destinatario","uf")
              icms_part_xml_tag&.add_child(ufst_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms_xml_tag.nil?
      				if ["41","60"].include?(icms["codigo"])
                icmsst_xml_tag = Nokogiri::XML("<ICMSST>").elements.first
      					icms_xml_tag&.add_child(icmsst_xml_tag)
      				end
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSST//xs:orig" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmsst_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSST","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmsst_xml_tag.nil?
      				origem_xml_tag = Nokogiri::XML("<orig>").elements.first
      				origem_xml_tag&.content = icms["origem"]
              icmsst_xml_tag&.add_child(origem_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSST//xs:CST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmsst_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSST","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmsst_xml_tag.nil?
      				codigo_xml_tag = Nokogiri::XML("<CST>").elements.first
      				codigo_xml_tag&.content = icms["codigo"]
              icmsst_xml_tag&.add_child(codigo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSST//xs:vBCSTRet" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmsst_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSST","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmsst_xml_tag.nil?
      				valor_base_calculo_st_retido_xml_tag = Nokogiri::XML("<vBCSTRet>").elements.first
      				valor_base_calculo_st_retido_xml_tag&.content = icms["valor_base_calculo_st_retido"]
              icmsst_xml_tag&.add_child(valor_base_calculo_st_retido_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSST//xs:pST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmsst_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSST","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmsst_xml_tag.nil?
      				percentual_consumidor_final_xml_tag = Nokogiri::XML("<pST>").elements.first
      				percentual_consumidor_final_xml_tag&.content = icms["percentual_consumidor_final"]
              icmsst_xml_tag&.add_child(percentual_consumidor_final_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSST//xs:vICMSSubstituto" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmsst_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSST","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmsst_xml_tag.nil?
      				valor_icms_subtituto_xml_tag = Nokogiri::XML("<vICMSSubstituto>").elements.first
      				valor_icms_subtituto_xml_tag&.content = "%.2f" % icms["valor_icms_subtituto"].to_d.truncate(2)
              icmsst_xml_tag&.add_child(valor_icms_substituto_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSST//xs:vICMSSTRet" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmsst_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSST","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmsst_xml_tag.nil?
      				valor_icms_st_retido_xml_tag = Nokogiri::XML("<vICMSSTRet>").elements.first
      				valor_icms_st_retido_xml_tag&.content = "%.2f" % icms["valor_icms_st_retido"].to_d.truncate(2)
              icmsst_xml_tag&.add_child(valor_icms_st_retido_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSST//xs:vBCFCPSTRet" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmsst_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSST","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmsst_xml_tag.nil?
      				valor_base_calculo_fcp_st_retido_xml_tag = Nokogiri::XML("<vBCFCPSTRet>").elements.first
      				valor_base_calculo_fcp_st_retido_xml_tag&.content = icms["valor_base_calculo_fcp_st_retido"]
              icmsst_xml_tag&.add_child(valor_base_calculo_fcp_st_retido_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSST//xs:pFCPSTRet" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmsst_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSST","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmsst_xml_tag.nil?
      				percentual_fcp_st_retido_xml_tag = Nokogiri::XML("<pFCPSTRet>").elements.first
      				percentual_fcp_st_retido_xml_tag&.content = icms["percentual_fcp_st_retido"]
              ĩcmsst_xml_tag&.add_child(percentual_fcp_st_retido_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSST//xs:vFCPSTRet" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmsst_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSST","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmsst_xml_tag.nil?
      				valor_fcp_st_retido_xml_tag = Nokogiri::XML("<vFCPSTRet>").elements.first
      				valor_fcp_st_retido_xml_tag&.content = icms["valor_fcp_st_retido"]
              icmsst_xml_tag&.add_child(valor_fcp_st_retido_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSST//xs:vBCSTDest" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmsst_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSST","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmsst_xml_tag.nil?
      				valor_base_calculo_st_destino_xml_tag = Nokogiri::XML("<vBCSTDest>").elements.first
      				valor_base_calculo_st_destino_xml_tag&.content = icms["valor_base_calculo_st_destino"]
              icmsst_xml_tag&.add_child(valor_base_calculo_st_destino_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSST//xs:vICMSSTDest" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmsst_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSST","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmsst_xml_tag.nil?
      				valor_icms_st_destino_xml_tag = Nokogiri::XML("<vICMSSTDest>").elements.first
      				valor_icms_st_destino_xml_tag&.content = icms["valor_icms_st_destino"]
              icmsst_xml_tag&.add_child(valor_icms_st_destino_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSST//xs:pRedBCEfet" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmsst_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSST","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmsst_xml_tag.nil?
      				percentual_reducao_efetiva_xml_tag = Nokogiri::XML("<pRedBCEfet>").elements.first
      				percentual_reducao_efetiva_xml_tag&.content = icms["percentual_reducao"]
              icmsst_xml_tag&.add_child(percentual_reducao_efetiva_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSST//xs:vBCEfet" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmsst_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSST","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmsst_xml_tag.nil?
      				valor_base_calculo_efetiva_xml_tag = Nokogiri::XML("<vBCEfet>").elements.first
      				valor_base_calculo_efetiva_xml_tag&.content = "%.2f" % (produtos[index]["preco"].to_d * produtos[index]["quantidade"].to_d).truncate(2)
              icmsst_xml_tag&.add_child(valor_base_calculo_efetiva_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSST//xs:pICMSEfet" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmsst_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSST","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmsst_xml_tag.nil?
      				aliquota_efetiva_xml_tag = Nokogiri::XML("<pICMSEfet>").elements.first
      				aliquota_efetiva_xml_tag&.content = "%.2f" % icms["aliquota_icms"].to_d.truncate(2)
              icmsst_xml_tag&.add_child(aliquota_efetiva_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSST//xs:vICMSEfet" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmsst_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSST","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmsst_xml_tag.nil?
      				valor_base_calculo_efetiva_xml_tag = icmsst_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSST//xs:vBCEfet","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				aliquota_efetiva_xml_tag = icmsst_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSST//xs:pICMSEfet","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				valor_icms_efetivo_xml_tag = Nokogiri::XML("<vICMSEfet>").elements.first
      				valor_icms_xml_tag&.content = "%.2f" % ((base_calculo_efetiva_xml_tag.content.to_d * aliquota_efetiva_xml_tag.content.to_d)/100.to_d).truncate(2)
              icmsst_xml_tag&.add_child(valor_icms_efetivo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN101" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms_xml_tag.nil?
      				if icms["codigo"] == "101"
      					icmssn101_xml_tag = Nokogiri::XML("<ICMSSN101>").elements.first
      					icms_xml_tag&.add_child(icmssn101_xml_tag)
      				end
      			end

      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN101//xs:orig" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn101_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN101","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn101_xml_tag.nil?
      				origem_xml_tag = Nokogiri::XML("<orig>").elements.first
      				origem_xml_tag&.content = icms["origem"]
              icmssn101_xml_tag&.add_child(origem_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN101//xs:CSOSN" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn101_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN101","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn101_xml_tag.nil?
      				codigo_xml_tag = Nokogiri::XML("<CSOSN>").elements.first
      				codigo_xml_tag&.content = icms["codigo"]
              icmssn101_xml_tag&.add_child(codigo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN101//xs:pCredSN" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn101_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN101","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn101_xml_tag.nil?
      				percentual_operacao_propria_credito_xml_tag = Nokogiri::XML("<pCredSN>").elements.first
      				percentual_operacao_propria_credito_xml_tag&.content = icms["percentual_credito"]
              icmssn101_xml_tag&.add_child(percentual_operacao_propria_credito_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN101//xs:vCredICMSSN" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn101_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN101","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn101_xml_tag.nil?
      				percentual_credito_xml_tag = icmssn101_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN101//xs:pCredSN","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				valor_credito_icms_xml_tag = Nokogiri::XML("<vCredICMSSN>").elements.first
      				valor_credito_icms_xml_tag&.content = "%.2f" % ((produtos[index]["preco"].to_d * produtos[index]["quantidade"].to_d) * (icms["percentual_credito"].to_d/100.to_d)).truncate(2)
              icmssn101_xml_tag&.add_child(valor_credito_icms_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN102" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms_xml_tag.nil?
      				if ["102","103","300","400"].include?(icms["codigo"])
      					icmssn102_xml_tag = Nokogiri::XML("<ICMSSN102>").elements.first 
      					icms_xml_tag&.add_child(icmssn102_xml_tag)
      				end
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN102//xs:orig" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn102_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN102","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn102_xml_tag.nil?
      				origem_xml_tag = Nokogiri::XML("<orig>").elements.first
      				origem_xml_tag&.content = icms["origem"]
              icmssn102_xml_tag&.add_child(origem_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN102//xs:CSOSN" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn102_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN102","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn102_xml_tag.nil?
      				codigo_xml_tag = Nokogiri::XML("<CSOSN>").elements.first
      				codigo_xml_tag&.content = icms["codigo"]
              icmssn102_xml_tag&.add_child(codigo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN201" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms_xml_tag.nil?
      				if icms["codigo"] == "201"
      					icmssn201_xml_tag = Nokogiri::XML("<ICMSSN201>").elements.first
      					icms_xml_tag&.add_child(icmssn201_xml_tag)
      				end
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN201//xs:orig" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn201_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN201","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn201_xml_tag.nil?
      				origem_xml_tag = Nokogiri::XML("<orig>").elements.first
      				origem_xml_tag&.content = icms["origem"]
              icmssn201_xml_tag&.add_child(origem_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN201//xs:CSOSN" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn201_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN201","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn201_xml_tag.nil?
      				codigo_xml_tag = Nokogiri::XML("<CSOSN>").elements.first
      				codigo_xml_tag&.content = icms["codigo"]
              icmssn201_xml_tag&.add_child(codigo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN201//xs:modBCST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn201_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN201","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn201_xml_tag.nil?
      				modalidade_st_xml_tag = Nokogiri::XML("<ICMSSN201>").elements.first
      				modalidade_st_xml_tag&.content = icms["modalidade_st"]
              icmssn201_xml_tag&.add_child(modalidade_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN201//xs:pMVAST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn201_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN201","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn201_xml_tag.nil?
      				percentual_mva_st_xml_tag = Nokogiri::XML("<pMVAST>").elements.first
      				percentual_mva_st_xml_tag&.content = icms["percentual_mva_st"]
              icmssn201_xml_tag&.add_child(percentual_mva_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN201//xs:pRedBCST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn201_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN201","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn201_xml_tag.nil?
      				percentual_reducao_st_xml_tag = Nokogiri::XML("<pRedBCST>").elements.first
      				percentual_reducao_st_xml_tag&.content = icms["percentual_reducao_st"]
              icmssn201_xml_tag&.add_child(percentual_reducao_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN201//xs:vBCST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn201_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN201","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn201_xml_tag.nil?
      				valor_base_calculo_st_xml_tag = Nokogiri::XML("<vBCST>").elements.first
      				valor_base_calculo_st_xml_tag&.content = "%.2f" % (produtos[index]["preco"].to_d * produtos[index]["quantidade"].to_d).truncate(2)
              icmssn201_xml_tag&.add_child(valor_base_calculo_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN201//xs:pICMSST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn201_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN201","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn201_xml_tag.nil?
      				aliquota_icmsst_xml_tag = Nokogiri::XML("<pICMSST>").elements.first
      				aliquota_icmsst_xml_tag&.content = "%.2f" % icms["aliquota_icms_st"].to_d.truncate(2)
              icmssn201_xml_tag&.add_child(aliquota_icmsst_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN201//xs:vICMSST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn201_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN201","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn201_xml_tag.nil?
      				valor_base_calculo_st_xml_tag = icmssn201_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN201//xs:vBCST","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				aliquota_st_xml_tag = icmssn201_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN201//xs:pICMSST","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				valor_icms_st_xml_tag = Nokogiri::XML("<vICMSST>").elements.first
      				valor_icms_st_xml_tag&.content = "%.2f" % ((base_calculo_st_xml_tag.content.to_d * aliquota_st_xml_tag.content.to_d)/100.to_d).truncate(2)
              icmssn201_xml_tag&.add_child(valor_icms_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN201//xs:vBCFCPST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn201_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN201","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn201_xml_tag.nil?
      				valor_base_calculo_fcp_st_xml_tag = Nokogiri::XML("<vBCFCPST>").elements.first
      				valor_base_calculo_fcp_st_xml_tag&.content = "%.2f" % (produtos[index]["preco"].to_d * produtos[index]["quantidade"].to_d).truncate(2)
              icmssn201_xml_tag&.add_child(valor_base_calculo_fcp_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN201//xs:pFCPST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn201_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN201","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn201_xml_tag.nil?
      				percentual_fcp_st_xml_tag = Nokogiri::XML("<pFCPST>").elements.first
      				if !icms["percentual_fcp_st"].nil?
      					percentual_fcp_st_xml_tag&.content = "%.2f" % icms["percentual_fcp_st"].to_d.truncate(2)
      				else
      					percentual_fcp_st_xml_tag&.content = "%.2f" % 2
      				end
              icmssn201_xml_tag&.add_child(percentual_fcp_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN201//xs:vFCPST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn201_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN201","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn201_xml_tag.nil?
      				valor_base_calculo_fcp_st_xml_tag = icmssn201_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN201//xs:vBCFCPST","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				aliquota_fcp_st_xml_tag = icmssn201_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN201//xs:pFCPST","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				valor_fcp_st_xml_tag = Nokogiri::XML("<vFCPST>").elements.first
      				valor_fcp_st_xml_tag&.content = "%.2f" % ((base_calculo_fcp_st_xml_tag.content.to_d * aliquota_fcp_st_xml_tag.content.to_d)/100.to_d).truncate(2)
              icmssn201_xml_tag&.add_child(valor_fcp_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN201//xs:pCredSN" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn201_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN201","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn201_xml_tag.nil?
      				percentual_credito_xml_tag = Nokogiri::XML("<pCredSN>").elements.first
      				percentual_credito_xml_tag&.content = icms["percentual_credito"]
              icmssn201_xml_tag&.add_child(percentual_credito_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN201//xs:vCredICMSSN" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn201_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN201","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn201_xml_tag.nil?
      				percentual_credito_xml_tag = icmssn201_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN201//xs:pCredSN","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				valor_credito_icms_xml_tag = Nokogiri::XML("<vCredICMSSN>").elements.first
      				valor_credito_icms_xml_tag&.content = "%.2f" % ((produtos[index]["preco"].to_d * produtos[index]["quantidade"].to_d) * (icms["percentual_credito"].to_d/100.to_d)).truncate(2)
              icmssn201_xml_tag&.add_child(valor_credito_icms_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN202" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms_xml_tag.nil?
      				if ["202","203"].include?(icms["codigo"])
      					icmssn202_xml_tag = Nokogiri::XML("<ICMSSN202>").elements.first
      					icms_xml_tag&.add_child(icmssn202_xml_tag)
      				end
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN202//xs:orig" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn202_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN202","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn202_xml_tag.nil?
      				origem_xml_tag = Nokogiri::XML("<orig>").elements.first
      				origem_xml_tag&.content = icms["origem"]
              icmssn202_xml_tag&.add_child(origem_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN202//xs:CSOSN" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn202_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN202","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn202_xml_tag.nil?
      				codigo_xml_tag = Nokogiri::XML("<CSOSN>").elements.first
      				codigo_xml_tag&.content = icms["codigo"]
              icmssn202_xml_tag&.add_child(codigo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN202//xs:modBCST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn202_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN202","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn202_xml_tag.nil?
      				modalidade_st_xml_tag = Nokogiri::XML("<modBCST>").elements.first
      				modalidade_st_xml_tag&.content = icms["modalidade_st"]
              icmssn202_xml_tag&.add_child(modalidade_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN202//xs:pMVAST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn202_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN202","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn202_xml_tag.nil?
      				percentual_mva_st_xml_tag = Nokogiri::XML("<pMVAST>").elements.first
      				percentual_mva_st_xml_tag&.content = icms["percentual_mva_st"]
              icmssn202_xml_tag&.add_child(percentual_mva_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN202//xs:pRedBCST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn202_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN202","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn202_xml_tag.nil?
      				percentual_reducao_st_xml_tag = Nokogiri::XML("<pRedBCST>").elements.first
      				percentual_reducao_st_xml_tag&.content = icms["percentual_reducao_st"]
              icmssn202_xml_tag&.add_child(percentual_reducao_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN202//xs:vBCST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn202_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN202","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn202_xml_tag.nil?
      				valor_base_calculo_st_xml_tag = Nokogiri::XML("<vBCST>").elements.first
      				valor_base_calculo_st_xml_tag&.content = "%.2f" % (produtos[index]["preco"].to_d * produtos[index]["quantidade"].to_d).truncate(2)
              icmssn202_xml_tag&.add_child(valor_base_calculo_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN202//xs:pICMSST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn202_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN202","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn202_xml_tag.nil?
      				aliquota_icmsst_xml_tag = Nokogiri::XML("<pICMSST>").elements.first
      				aliquota_icmsst_xml_tag&.content = "%.2f" % icms["aliquota_icms_st"].to_d.truncate(2)
              icmssn202_xml_tag&.add_child(aliquota_icmsst_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN202//xs:vICMSST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn202_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN202","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn202_xml_tag.nil?
      				valor_base_calculo_st_xml_tag = icmssn202_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN202//xs:vBCST","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				aliquota_st_xml_tag = icmssn202_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN202//xs:pICMSST","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				valor_icms_st_xml_tag = Nokogiri::XML("<vICMSST>").elements.first
      				valor_icms_st_xml_tag&.content = "%.2f" % ((base_calculo_st_xml_tag.content.to_d * aliquota_st_xml_tag.content.to_d)/100.to_d).truncate(2)
              icmssn202_xml_tag&.add_child(valor_icms_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN202//xs:vBCFCPST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn202_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN202","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn202_xml_tag.nil?
      				valor_base_calculo_fcp_st_xml_tag = Nokogiri::XML("<vBCFCPST>").elements.first
      				valor_base_calculo_fcp_st_xml_tag&.content = "%.2f" % (produtos[index]["preco"].to_d * produtos[index]["quantidade"].to_d).truncate(2)
              icmssn202_xml_tag&.add_child(valor_base_calculo_fcp_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN202//xs:pFCPST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn202_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN202","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn202_xml_tag.nil?
      				percentual_fcp_st_xml_tag = Nokogiri::XML("<pFCPST>").elements.first
      				if !icms["percentual_fcp_st"].nil?
      					percentual_fcp_st_xml_tag&.content = "%.2f" % icms["percentual_fcp_st"].to_d.truncate(2)
      				else
      					percentual_fcp_st_xml_tag&.content = "%.2f" % 2
      				end
              icmssn202_xml_tag&.add_child(percentual_fcp_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN202//xs:vFCPST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn202_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN202","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn202_xml_tag.nil?
      				valor_base_calculo_fcp_st_xml_tag = icmssn202_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN202//xs:vBCFCPST","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				aliquota_fcp_st_xml_tag = icmssn202_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN202//xs:pFCPST","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				valor_fcp_st_xml_tag = Nokogiri::XML("<vFCPST>").elements.first
      				valor_fcp_st_xml_tag&.content = "%.2f" % ((base_calculo_fcp_st_xml_tag.content.to_d * aliquota_fcp_st_xml_tag.content.to_d)/100.to_d).truncate(2)
              icmssn202_xml_tag&.add_child(valor_fcp_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN500" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms_xml_tag.nil?
      				if icms["codigo"] == "500"
      					icmssn500_xml_tag = Nokogiri::XML("<ICMSSN500>").elements.first
      					icms_xml_tag&.add_child(icmssn500_xml_tag)
      				end
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN500//xs:orig" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn500_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN500","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn500_xml_tag.nil?
      				origem_xml_tag = Nokogiri::XML("<orig>").elements.first
      				origem_xml_tag&.content = icms["origem"]
              icmssn500_xml_tag&.add_child(origem_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN500//xs:CSOSN" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn500_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN500","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn500_xml_tag.nil?
      				codigo_xml_tag = Nokogiri::XML("<CSOSN>").elements.first
      				codigo_xml_tag&.content = icms["codigo"]
              icmssn500_xml_tag&.add_child(codigo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN500//xs:vBCSTRet" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn500_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN500","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn500_xml_tag.nil?
      				valor_base_calculo_st_retido_xml_tag = Nokogiri::XML("<vBCSTRet>").elements.first
      				valor_base_calculo_st_retido_xml_tag&.content = icms["valor_base_calculo_st_retido"]
              icmssn500_xml_tag&.add_child(valor_base_calculo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN500//xs:pST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn500_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN500","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn500_xml_tag.nil?
      				percentual_consumidor_final_xml_tag = Nokogiri::XML("<pST>").elements.first
      				percentual_consumidor_final_xml_tag&.content = icms["percentual_consumidor_final"]
              icmssn500_xml_tag&.add_child(percentual_consumidor_final_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN500//xs:vICMSSubstituto" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn500_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN500","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn500_xml_tag.nil?
      				valor_icms_subtituto_xml_tag = Nokogiri::XML("<vICMSSubstituto>").elements.first
      				valor_icms_subtituto_xml_tag&.content = "%.2f" % icms["valor_icms_subtituto"].to_d.truncate(2)
              icmssn500_xml_tag&.add_child(valor_icms_substituto_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN500//xs:vICMSSTRet" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn500_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN500","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn500_xml_tag.nil?
      				valor_icms_st_retido_xml_tag = Nokogiri::XML("<vICMSSTRet>").elements.first
      				valor_icms_st_retido_xml_tag&.content = "%.2f" % icms["valor_icms_st_retido"].to_d.truncate(2)
              icmssn500_xml_tag&.add_child(valor_icms_st_retido_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN500//xs:vBCFCPSTRet" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn500_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN500","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn500_xml_tag.nil?
      				valor_base_calculo_fcp_st_retido_xml_tag = Nokogiri::XML("<vBCFCPSTRet>").elements.first
      				valor_base_calculo_fcp_st_retido_xml_tag&.content = icms["valor_base_calculo_fcp_st_retido"]
              icmssn500_xml_tag&.add_child(valor_base_calculo_fcp_st_retido_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN500//xs:pFCPSTRet" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn500_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN500","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn500_xml_tag.nil?
      				percentual_fcp_st_retido_xml_tag = Nokogiri::XML("<pFCPSTRet>").elements.first
      				percentual_fcp_st_retido_xml_tag&.content = icms["percentual_fcp_st_retido"]
              icmssn500_xml_tag&.add_child(percentual_fcp_st_retido_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN500//xs:vFCPSTRet" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn500_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN500","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn500_xml_tag.nil?
      				valor_fcp_st_retido_xml_tag = Nokogiri::XML("<vFCPSTRet>").elements.first
      				valor_fcp_st_retido_xml_tag&.content = icms["valor_fcp_st_retido"]
              icmssn500_xml_tag&.add_child(valor_fcp_st_retido_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN500//xs:pRedBCEfet" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn500_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN500","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn500_xml_tag.nil?
      				percentual_reducao_efetiva_xml_tag = Nokogiri::XML("<pRedBCEfet>").elements.first
      				percentual_reducao_efetiva_xml_tag&.content = icms["percentual_reducao"]
              icmssn500_xml_tag&.add_child(percentual_reducao_efetiva_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN500//xs:vBCEfet" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn500_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSST","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn500_xml_tag.nil?
      				valor_base_calculo_efetiva_xml_tag = Nokogiri::XML("<vBCEfet>").elements.first
      				valor_base_calculo_efetiva_xml_tag&.content = "%.2f" % (produtos[index]["preco"].to_d * produtos[index]["quantidade"].to_d).truncate(2)
              icmssn500_xml_tag&.add_child(valor_base_calculo_efetiva_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN500//xs:pICMSEfet" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn500_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN500","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn500_xml_tag.nil?
      				aliquota_efetiva_xml_tag = Nokogiri::XML("<pICMSEfet>").elements.first
      				aliquota_efetiva_xml_tag&.content = "%.2f" % icms["aliquota_icms"].to_d.truncate(2)
              icmssn500_xml_tag&.add_child(aliquota_efetiva_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN500//xs:vICMSEfet" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn500_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN500","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn500_xml_tag.nil?
      				valor_base_calculo_efetiva_xml_tag = icmssn500_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN500//xs:vBCEfet","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				aliquota_efetiva_xml_tag = icmssn500_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN500//xs:pICMSEfet","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				valor_icms_efetivo_xml_tag = Nokogiri::XML("<vICMSEfet>").elements.first
      				valor_icms_xml_tag&.content = "%.2f" % ((base_calculo_efetiva_xml_tag.content.to_d * aliquota_efetiva_xml_tag.content.to_d)/100.to_d).truncate(2)
              icmssn500_xml_tag&.add_child(valor_icms_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icms_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icms_xml_tag.nil?
      				if icms["codigo"] == "900"
      					icmssn900_xml_tag = Nokogiri::XML("<ICMSSN900>").elements.first
      					icms_xml_tag&.add_child(icmssn900_xml_tag)
      				end
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900//xs:orig" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn900_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn900_xml_tag.nil?
      				origem_xml_tag = Nokogiri::XML("<orig>").elements.first
      				origem_xml_tag&.content = icms["origem"]
              icmssn900_xml_tag&.add_child(origem_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900//xs:CSOSN" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn900_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn900_xml_tag.nil?
      				codigo_xml_tag = Nokogiri::XML("<CSOSN>").elements.first
      				codigo_xml_tag&.content = icms["codigo"]
              icmssn900_xml_tag&.add_child(codigo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900//xs:modBC" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn900_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn900_xml_tag.nil?
      				modalidade_xml_tag = Nokogiri::XML("<modBC>").elements.first
      				modalidade_xml_tag&.content = icms["modalidade"]
              icmssn900_xml_tag&.add_child(modalidade_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900//xs:vBC" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn900_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn900_xml_tag.nil?
      				valor_base_calculo_xml_tag = Nokogiri::XML("<vBC>").elements.first
      				valor_base_calculo_xml_tag&.content = "%.2f" % (produtos[index]["preco"].to_d * produtos[index]["quantidade"].to_d).truncate(2)
              icmssn900_xml_tag&.add_child(valor_base_calculo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900//xs:pRedBC" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn900_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn900_xml_tag.nil?
      				percentual_reducao_xml_tag = Nokogiri::XML("<pRedBC>").elements.first
      				percentual_reducao_xml_tag&.content = "%.2f" % icms["percentual_reducao"].to_d.truncate(2)
              icmssn900_xml_tag&.add_child(percentual_reducao_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900//xs:pICMS" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn900_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn900_xml_tag.nil?
      				aliquota_xml_tag = Nokogiri::XML("<pICMS>").elements.first
      				aliquota_xml_tag&.content = "%.2f" % icms["aliquota_icms"].to_d.truncate(2)
              icmssn900_xml_tag&.add_child(aliquota_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900//xs:vICMS" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn900_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn900_xml_tag.nil?
      				valor_base_calculo_xml_tag = icmssn900_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900//xs:vBC","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				aliquota_xml_tag = icmssn900_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900//xs:pICMS","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				valor_icms_xml_tag = Nokogiri::XML("<vICMS>").elements.first
      				valor_icms_xml_tag&.content = "%.2f" % ((base_calculo_xml_tag.content.to_d * aliquota_xml_tag.content.to_d)/100.to_d).truncate(2)
              icmssn900_xml_tag&.add_child(valor_icms_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900//xs:modBCST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn900_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn900_xml_tag.nil?
      				modalidade_st_xml_tag = Nokogiri::XML("<modBCST>").elements.first
      				modalidade_st_xml_tag&.content = icms["modalidade_st"]
              icmssn900_xml_tag&.add_child(modalidade_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900//xs:pMVAST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn900_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn900_xml_tag.nil?
      				percentual_mva_st_xml_tag = Nokogiri::XML("<pMVAST>").elements.first
      				percentual_mva_st_xml_tag&.content = icms["percentual_mva_st"]
              icmssn900_xml_tag&.add_child(percentual_mva_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900//xs:pRedBCST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn900_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn900_xml_tag.nil?
      				percentual_reducao_st_xml_tag = Nokogiri::XML("<pRedBCST>").elements.first
      				percentual_reducao_st_xml_tag&.content = icms["percentual_reducao_st"]
              icmssn900_xml_tag&.add_child(percentual_reducao_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900//xs:vBCST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn900_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn900_xml_tag.nil?
      				valor_base_calculo_st_xml_tag = Nokogiri::XML("<vBCST>").elements.first
      				valor_base_calculo_st_xml_tag&.content = "%.2f" % (produtos[index]["preco"].to_d * produtos[index]["quantidade"].to_d).truncate(2)
              icmssn900_xml_tag&.add_child(valor_base_calculo_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900//xs:pICMSST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn900_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn900_xml_tag.nil?
      				aliquota_icmsst_xml_tag = Nokogiri::XML("<pICMSST>").elements.first
      				aliquota_icmsst_xml_tag&.content = "%.2f" % icms["aliquota_icms_st"].to_d.truncate(2)
              icmssn900_xml_tag&.add_child(aliquota_icmsst_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900//xs:vICMSST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn900_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn900_xml_tag.nil?
      				valor_base_calculo_st_xml_tag = icmssn900_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900//xs:vBCST","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				aliquota_st_xml_tag = icmssn900_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900//xs:pICMSST","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				valor_icms_st_xml_tag = Nokogiri::XML("<vICMSST>").elements.first
      				valor_icms_st_xml_tag&.content = "%.2f" % ((base_calculo_st_xml_tag.content.to_d * aliquota_st_xml_tag.content.to_d)/100.to_d).truncate(2)
              icmssn900_xml_tag&.add_child(valor_icms_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900//xs:vBCFCPST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn900_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn900_xml_tag.nil?
      				valor_base_calculo_fcp_st_xml_tag = Nokogiri::XML("<vBCFCPST>").elements.first
      				valor_base_calculo_fcp_st_xml_tag&.content = "%.2f" % (produtos[index]["preco"].to_d * produtos[index]["quantidade"].to_d).truncate(2)
              icmssn900_xml_tag&.add_child(valor_base_calculo_fcp_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900//xs:pFCPST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn900_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn900_xml_tag.nil?
      				percentual_fcp_st_xml_tag = Nokogiri::XML("<pFCPST>").elements.first
      				if !icms["percentual_fcp_st"].nil?
      					percentual_fcp_st_xml_tag&.content = "%.2f" % icms["percentual_fcp_st"].to_d.truncate(2)
      				else
      					percentual_fcp_st_xml_tag&.content = "%.2f" % 2
      				end
              icmssn900_xml_tag&.add_child(percentual_fcp_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900//xs:vFCPST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn900_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn900_xml_tag.nil?
      				valor_base_calculo_fcp_st_xml_tag = icmssn900_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900//xs:vBCFCPST","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				aliquota_fcp_st_xml_tag = icmssn900_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900//xs:pFCPST","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				valor_fcp_st_xml_tag = Nokogiri::XML("<vFCPST>").elements.first
      				valor_fcp_st_xml_tag&.content = "%.2f" % ((base_calculo_fcp_st_xml_tag.content.to_d * aliquota_fcp_st_xml_tag.content.to_d)/100.to_d).truncate(2)
              icmssn900_xml_tag&.add_child(valor_fcp_st_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900//xs:pCredSN" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn900_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn900_xml_tag.nil?
      				percentual_credito_xml_tag = Nokogiri::XML("<pCredSN>").elements.first
      				percentual_credito_xml_tag&.content = icms["percentual_credito"]
              icmssn900_xml_tag&.add_child(percentual_credito_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900//xs:vCredICMSSN" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icms = produtos[index].dig("imposto","icms")
      			icmssn900_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmssn900_xml_tag.nil?
      				percentual_credito_xml_tag = icmssn900_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMS//xs:ICMSSN900//xs:pCredSN","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				valor_credito_icms_xml_tag = Nokogiri::XML("<vCredICMSSN>").elements.first
      				valor_credito_icms_xml_tag&.content = "%.2f" % ((produtos[index]["preco"].to_d * produtos[index]["quantidade"].to_d) * (icms["percentual_credito"].to_d/100.to_d)).truncate(2)
              icmssn900_xml_tag&.add_child(valor_credito_icms_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI" => lambda{|msg,xml|
      		produtos = msg["produtos"]

      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			ipi = produtos[index].dig("imposto","ipi")

      			if !ipi.nil?
      				ipi_xml_tag = Nokogiri::XML("<IPI>").elements.first
      				imposto_xml_tag&.add_child(ipi_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:CNPJProd" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			ipi = produtos[index].dig("imposto","ipi")
      			ipi_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !ipi_xml_tag.nil?
      				cnpj_produtor_xml_tag = Nokogiri::XML("<CNPJProd>").elements.first
      				cnpj_produtor_xml_tag&.content = ipi["cnpj_produtor"]
              ipi_xml_tag&.add_child(cnpj_produtor_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:cSelo" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			ipi = produtos[index].dig("imposto","ipi")
      			ipi_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !ipi_xml_tag.nil?
      				selo_xml_tag = Nokogiri::XML("<cSelo>").elements.first
      				selo_xml_tag&.content = ipi["selo"]
              ipi_xml_tag&.add_child(selo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:qSelo" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			ipi = produtos[index].dig("imposto","ipi")
      			ipi_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !ipi_xml_tag.nil?
      				quantidade_selo_xml_tag = Nokogiri::XML("<qSelo>").elements.first
      				quantidade_selo_xml_tag&.content = ipi["quantidade_selo"]
              ipi_xml_tag&.add_child(quantidade_selo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:cEnq" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			ipi = produtos[index].dig("imposto","ipi")
      			ipi_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !ipi_xml_tag.nil?
      				codigo_enquadramento_xml_tag = Nokogiri::XML("<cEnq>").elements.first
      				codigo_enquadramento_xml_tag&.content = ipi["codigo_enquadramento"]
              ipi_xml_tag&.add_child(codigo_enquadramento_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:IPITrib" => lambda{|msg,xml|
      		produtos = msg["produtos"]

      		produtos&.each_with_index do |produto,index|
      			ipi = produto.dig("imposto","ipi")
      			ipi_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:imposto//xs:IPI","xs"=>"http://www.portalfiscal.inf.br/nfe").first

      			if !ipi_xml_tag.nil?
      				if ["00","49","50","99"].include?(ipi["codigo"])
      					ipi_trib_xml_tag = Nokogiri::XML("<IPITrib>").elements.first
      					ipi_xml_tag&.add_child(ipi_trib_xml_tag)
      				end
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:IPITrib//xs:CST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			ipi = produtos[index].dig("imposto","ipi")
      			ipi_trib_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:IPITrib","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !ipi_trib_xml_tag.nil?
      				codigo_xml_tag = Nokogiri::XML("<CST>").elements.first
      				codigo_xml_tag&.content = ipi["codigo"]
              ipi_trib_xml_tag&.add_child(codigo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:IPITrib//xs:vBC" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			ipi = produtos[index].dig("imposto","ipi")
      			ipi_trib_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:IPITrib","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !ipi_trib_xml_tag.nil?
      				valor_base_calculo_xml_tag = Nokogiri::XML("<vBC>").elements.first
      				valor_base_calculo_xml_tag&.content = "%.2f" % (produtos[index]["preco"].to_d * produtos[index]["quantidade"].to_d).truncate(2)
              ipi_trib_xml_tag&.add_child(valor_base_calculo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:IPITrib//xs:pIPI" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			ipi = produtos[index].dig("imposto","ipi")
      			ipi_trib_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:IPITrib","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !ipi_trib_xml_tag.nil?
      				aliquota_percentual_xml_tag = Nokogiri::XML("<pIPI>").elements.first
      				aliquota_percentual_xml_tag&.content = "%.2f" % ipi["aliquota_percentual"].to_d.truncate(2)
              ipi_trib_xml_tag&.add_child(aliquota_percentual_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:IPITrib//xs:qUnid" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			ipi = produtos[index].dig("imposto","ipi")
      			ipi_trib_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:IPITrib","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !ipi_trib_xml_tag.nil?
      				quantidade_xml_tag = Nokogiri::XML("<qUnid>").elements.first
      				quantidade_xml_tag&.content = produtos[index]["quantidade"]
              ipi_trib_xml_tag&.add_child(quantidade_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:IPITrib//xs:vUnid" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			ipi = produtos[index].dig("imposto","ipi")
      			ipi_trib_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:IPITrib","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !ipi_trib_xml_tag.nil?
      				aliquota_valor_xml_tag = Nokogiri::XML("<vUnid>").elements.first
      				aliquota_valor_xml_tag&.content = "%.2f" % ipi["aliquota_valor"].to_d.truncate(2)
              ipi_trib_xml_tag&.add_child(aliquota_valor_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:IPITrib//xs:vIPI" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			ipi = produtos[index].dig("imposto","ipi")
      			ipi_trib_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:IPITrib","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !ipi_trib_xml_tag.nil?
      				valor_base_calculo_xml_tag = ipi_trib_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:IPITrib//xs:vBC","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				aliquota_percentual_xml_tag = ipi_trib_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:IPITrib//xs:CST","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				quantidade_xml_tag = ipi_trib_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:IPITrib//xs:CST","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				aliquota_valor_xml_tag = Nokogiri::XML("<vIPI>").elements.first
      				if !ipi["aliquota_valor"].nil?
      					aliquota_valor_xml_tag&.content = "%.2f" % (quantidade_xml_tag.content.to_d * aliquota_valor_xml_tag.content.to_d).truncate(2)
      				elsif !ipi["aliquota_percentual"].nil?
      					aliquota_valor_xml_tag&.content = "%.2f" % ((quantidade_xml_tag.content.to_d * aliquota_valor_xml_tag.content.to_d)/100.to_d).truncate(2)
      				end
              ipi_trib_xml_tag&.add_child(ipi_trib_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:IPINT" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			ipi = produtos[index].dig("imposto","ipi")
      			ipi_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			
      			if !ipi_xml_tag.nil?
      				if ["01","02","03","04","05","51","52","53","54","55"].include?(ipi["codigo"])
      					ipint_xml_tag = Nokogiri::XML("<IPINT>").elements.first
      					ipi_xml_tag&.add_child(ipint_xml_tag)
      				end
      			end

      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:IPINT//xs:CST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			ipi = produtos[index].dig("imposto","ipi")
      			ipint_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:IPINT","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !ipint_xml_tag.nil?
      				codigo_xml_tag = Nokogiri::XML("<CST>").elements.first
      				codigo_xml_tag&.content = ipi["codigo"]
      				ipint_xml_tag&.add_child(codigo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:II" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			ii = produtos[index].dig("imposto","ii")
      			
      			if !ii.nil?
      				ii_xml_tag = Nokogiri::XML("<II>").elements.first
      				imposto_xml_tag&.add_child(ii_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:II//xs:vBC" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			ii = produtos[index].dig("imposto","ii")
      			ii_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:II","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !ii_xml_tag.nil?
      				valor_base_calculo_xml_tag = Nokogiri::XML("<vBC>").elements.first
      				valor_base_calculo_xml_tag&.content = "%.2f" % (produtos[index]["preco"].to_d * produtos[index]["quantidade"].to_d).truncate(2)
              ii_xml_tag&.add_child(valor_base_calculo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:II//xs:vDespAdu" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			ii = produtos[index].dig("imposto","ii")
      			ii_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:II","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !ii_xml_tag.nil?
      				valor_despesas_aduaneiras_xml_tag = Nokogiri::XML("<vDespAdu>").elements.first
      				valor_despesas_aduaneiras_xml_tag&.content = "%.2f" % ii["valor_despesas_aduaneiras"].to_d.truncate(2)
              ii_xml_tag&.add_child(valor_despesas_aduaneiras_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:II//xs:vII" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			ii = produtos[index].dig("imposto","ii")
      			ii_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:II","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !ii_xml_tag.nil?
      				valor_ii_xml_tag = Nokogiri::XML("<vII>").elements.first
      				valor_ii_xml_tag&.content = "%.2f" % ii["valor_ii"].to_d.truncate(2)
              ii_xml_tag&.add_child(valor_ii_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:II//xs:vIOF" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			ii = produtos[index].dig("imposto","ii")
      			ii_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:II","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !ii_xml_tag.nil?
      				valor_iof_xml_tag = Nokogiri::XML("<vIOF>").elements.first
      				valor_iof_xml_tag&.content = "%.2f" % ii["valor_iof"].to_d.truncate(2)
              ii_xml_tag&.add_child(valor_iof_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			issqn = produtos[index].dig("imposto","issqn")
      			
      			if !issqn.nil?
      				issqn_xml_tag = Nokogiri::XML("<ISSQN>").elements.first
      				imposto_xml_tag&.add_child(issqn_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN//xs:vBC" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			issqn = produtos[index].dig("imposto","issqn")
      			issqn_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !issqn_xml_tag.nil?
      				valor_base_calculo_xml_tag = Nokogiri::XML("<vBC>").elements.first
      				valor_base_calculo_xml_tag&.content = "%.2f" % (produtos[index]["preco"].to_d * produtos[index]["quantidade"].to_d).truncate(2)
              issqn_xml_tag&.add_child(valor_base_calculo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN//xs:vAliq" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			issqn = produtos[index].dig("imposto","issqn")
      			issqn_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !issqn_xml_tag.nil?
      				aliquota_xml_tag = Nokogiri::XML("<vAliq>").elements.first
      				aliquota_xml_tag&.content = "%.2f" % issqn["aliquota"].to_d.truncate(2)
              issqn_xml_tag&.add_child(aliquota_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN//xs:vISSQN" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			issqn = produtos[index].dig("imposto","issqn")
      			issqn_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !issqn_xml_tag.nil?
      				valor_base_calculo_xml_tag = issqn_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN//xs:vBC","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				aliquota_xml_tag = issqn_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN//xs:vAliq","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				valor_issqn_xml_tag = Nokogiri::XML("<vISSQN>").elements.first
      				valor_issqn_xml_tag&.content = "%.2f" % (aliquota_xml_tag.content.to_d * valor_issqn_xml_tag.content.to_d)
              issqn_xml_tag&.add_child(valor_issqn_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN//xs:cMunFG" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			issqn = produtos[index].dig("imposto","issqn")
      			issqn_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !issqn_xml_tag.nil?
      				codigo_municipio_fato_gerador_xml_tag = Nokogiri::XML("<cMunFG>").elements.first
      				codigo_municipio_fato_gerador_xml_tag&.content = issqn["codigo_municipio_fato_gerador"]
              issqn_xml_tag&.add_child(codigo_municipio_fato_gerador_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN//xs:cListServ" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			issqn = produtos[index].dig("imposto","issqn")
      			issqn_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !issqn_xml_tag.nil?
      				codigo_lista_servicos_xml_tag = Nokogiri::XML("<cListServ>").elements.first
      				codigo_lista_servicos_xml_tag&.content = issqn["codigo_lista_servicos"]
              issqn_xml_tag&.add_child(codigo_lista_servicos_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN//xs:vDeducao" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			issqn = produtos[index].dig("imposto","issqn")
      			issqn_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !issqn_xml_tag.nil?
      				valor_deducao_xml_tag = Nokogiri::XML("<vDeducao>").elements.first
      				valor_deducao_xml_tag&.content = "%.2f" % issqn["valor_deducao"].to_d.truncate(2)
              issqn_xml_tag&.add_child(valor_deducao_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN//xs:vOutro" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			issqn = produtos[index].dig("imposto","issqn")
      			issqn_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !issqn_xml_tag.nil?
      				valor_outro_xml_tag = Nokogiri::XML("<vOutro>").elements.first
      				valor_outro_xml_tag&.content = "%.2f" % issqn["valor_outro"].to_d.truncate(2)
              issqn_xml_tag&.add_child(valor_outro_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN//xs:vDescIncond" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			issqn = produtos[index].dig("imposto","issqn")
      			issqn_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !issqn_xml_tag.nil?
      				valor_desconto_incondicionado_xml_tag = Nokogiri::XML("<vDescIncond>").elements.first
      				valor_desconto_incondicionado_xml_tag&.content = "%.2f" % issqn["valor_desconto_incondicionado"].to_d.truncate(2)
              issqn_xml_tag&.add_child(valor_desconto_incondicionado_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN//xs:vDescCond" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			issqn = produtos[index].dig("imposto","issqn")
      			issqn_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !issqn_xml_tag.nil?
      				valor_desconto_condicionado_xml_tag = Nokogiri::XML("<vDescCond>").elements.first
      				valor_desconto_condicionado_xml_tag&.content = "%.2f" % issqn["valor_desconto_condicionado"].to_d.truncate(2)
              issqn_xml_tag&.add_child(valor_desconto_condicionado_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN//xs:vISSRet" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			issqn = produtos[index].dig("imposto","issqn")
      			issqn_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !issqn_xml_tag.nil?
      				valor_iss_retido_xml_tag = Nokogiri::XML("<vISSRet>").elements.first
      				valor_iss_retido_xml_tag&.content = "%.2f" % issqn["valor_iss_retido"].to_d.truncate(2)
              issqn_xml_tag&.add_child(valor_iss_retido_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN//xs:indISS" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			issqn = produtos[index].dig("imposto","issqn")
      			issqn_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !issqn_xml_tag.nil?
      				indicador_iss_xml_tag = Nokogiri::XML("<indISS>").elements.first
      				indicador_iss_xml_tag&.content = issqn["indicador_iss"]
              issqn_xml_tag&.add_child(indicador_iss_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN//xs:cServico" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			issqn = produtos[index].dig("imposto","issqn")
      			issqn_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !issqn_xml_tag.nil?
      				codigo_servico_xml_tag = Nokogiri::XML("<cServico>").elements.first
      				codigo_servico_xml_tag&.content = issqn["codigo_servico"]
              issqn_xml_tag&.add_child(codigo_servico_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN//xs:cMun" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			issqn = produtos[index].dig("imposto","issqn")
      			issqn_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !issqn_xml_tag.nil?
      				codigo_municipio_incidencia_xml_tag = Nokogiri::XML("<cMun>").elements.first
      				codigo_municipio_incidencia_xml_tag&.content = issqn["codigo_municipio_incidencia"]
              issqn_xml_tag&.add_child(codigo_municipio_incidencia_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN//xs:cPais" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			issqn = produtos[index].dig("imposto","issqn")
      			issqn_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !issqn_xml_tag.nil?
      				codigo_pais_xml_tag = Nokogiri::XML("<cPais>").elements.first
      				codigo_pais_xml_tag&.content = issqn["codigo_pais"]
              issqn_xml_tag&.add_child(codigo_pais_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN//xs:nProcesso" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			issqn = produtos[index].dig("imposto","issqn")
      			issqn_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !issqn_xml_tag.nil?
      				numero_processo_xml_tag = Nokogiri::XML("<nProcesso>").elements.first
      				numero_processo_xml_tag&.content = issqn["numero_processo"]
              issqn_xml_tag&.add_child(numero_processo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN//xs:indIncentivo" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			issqn = produtos[index].dig("imposto","issqn")
      			issqn_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !issqn_xml_tag.nil?
      				indicador_incentivo_xml_tag = Nokogiri::XML("<indIncentivo>").elements.first
      				indicador_incentivo_xml_tag&.content = issqn["indicador_incentivo"]
              issqn_xml_tag&.add_child(indicador_incentivo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS" => lambda{|msg,xml|
      		produtos = msg["produtos"]

      		produtos&.each_with_index do |produto,index|
      			pis = produto.dig("imposto","pis")
      			imposto_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:imposto","xs"=>"http://www.portalfiscal.inf.br/nfe").first

      			if !pis.nil?
              pis_xml_tag = Nokogiri::XML("<PIS>").elements.first
      				imposto_xml_tag&.add_child(pis_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISAliq" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			pis_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			pis = produtos[index].dig("imposto","pis")

      			if !pis_xml_tag.nil?
      				if ['01','02'].include?("%02d" % pis["codigo"])
      					pisaliq_xml_tag = Nokogiri::XML("<PISAliq>").elements.first 
      					pis_xml_tag&.add_child(pisaliq_xml_tag)
      				end
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISAliq//xs:CST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			pis = produtos[index].dig("imposto","pis")
      			pis_aliq_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISAliq","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !pis_aliq_xml_tag.nil?
      				codigo_xml_tag = Nokogiri::XML("<CST>").elements.first
      				codigo_xml_tag&.content = pis_aliq["codigo"]
              pis_aliq_xml_tag&.add_child(codigo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISAliq//xs:vBC" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			pis = produtos[index].dig("imposto","pis")
      			pis_aliq_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISAliq","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !pis_aliq_xml_tag.nil?
      				valor_base_calculo_xml_tag = Nokogiri::XML("<vBC>").elements.first
      				valor_base_calculo_xml_tag&.content = "%.2f" % (produtos[index]["preco"].to_d * produtos[index]["quantidade"].to_d).truncate(2)
              pis_aliq_xml_tag&.add_child(valor_base_calculo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISAliq//xs:pPIS" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			pis = produtos[index].dig("imposto","pis")
      			pis_aliq_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISAliq","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !pis_aliq_xml_tag.nil?
      				aliquota_percentual_xml_tag = Nokogiri::XML("<pPIS>").elements.first
      				aliquota_percentual_xml_tag&.content = "%.2f" % pis["aliquota_percentual"].to_d.truncate(2)
              pis_aliq_xml_tag&.add_child(aliquota_percentual_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISAliq//xs:vPIS" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			pis = produtos[index].dig("imposto","pis")
      			pis_aliq_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISAliq","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !pis_aliq_xml_tag.nil?
      				valor_base_calculo_xml_tag = Nokogiri::XML("<vPIS>").elements.first
      				valor_pis_xml_tag = pis_aliq_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISAliq//xs:vPIS","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				valor_pis_xml_tag&.content = "%.2f" % ((pis["aliquota_percentual"].to_d * valor_base_calculo_xml_tag.content.to_d)/100.to_d).truncate(2)
              pis_aliq_xml_tag&.add_child(valor_base_calculo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISQtde" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			pis_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			pis = produtos[index].dig("imposto","pis")

      			if !pis_xml_tag.nil?
      				if ("%02d" % pis["codigo"]) == "03"
      					pis_qtde_xml_tag = Nokogiri::XML("<PISQtde>").elements.first
      					pis_xml_tag&.add_child(pis_qtde_xml_tag)
      				end
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISQtde//xs:CST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			pis = produtos[index].dig("imposto","pis")
      			pis_qtde_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISQtde","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !pis_qtde_xml_tag.nil?
      				codigo_xml_tag = Nokogiri::XML("<CST>").elements.first
      				codigo_xml_tag&.content = "%.2f" % pis["codigo"]
              pis_qtde_xml_tag&.add_child(codigo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISQtde//xs:qBCProd" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			pis = produtos[index].dig("imposto","pis")
      			pis_qtde_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISQtde","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !pis_qtde_xml_tag.nil?
      				quantidade_xml_tag = Nokogiri::XML("<qBCProd>").elements.first
      				quantidade_xml_tag&.content = produtos[index]["quantidade"]
              pis_qtde_xml_tag&.add_child(quantidade_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISQtde//xs:vAliqProd" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			pis = produtos[index].dig("imposto","pis")
      			pis_qtde_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISQtde","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !pis_qtde_xml_tag.nil?
      				aliquota_valor_xml_tag = Nokogiri::XML("<vAliqProd>").elements.first
      				aliquota_valor_xml_tag&.content = "%.2f" % pis["aliquota_valor"].to_d.truncate(2)
              pis_qtde_xml_tag&.add_child(aliquota_valor_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISQtde//xs:vPIS" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			pis = produtos[index].dig("imposto","pis")
      			pis_qtde_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISQtde","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !pis_qtde_xml_tag.nil?
      				valor_pis_xml_tag = Nokogiri::XML("<vPIS>").elements.first
      				valor_pis_xml_tag&.content = "%.2f" % (pis["aliquota_valor"].to_d * produtos[index]["quantidade"].to_d).truncate(2)
              pis_qtde_xml_tag&.add_child(valor_pis_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISNT" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			pis_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			pis = produtos[index].dig("imposto","pis")

      			if !pis_xml_tag.nil?
      				if ["04","05","06","07","08","09"].include?("%02d" % pis["codigo"])
      					pisnt_xml_tag = Nokogiri::XML("<PISNT>").elements.first
      					pis_xml_tag&.add_child(pisnt_xml_tag)
      				end
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISNT//xs:CST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			pis = produtos[index].dig("imposto","pis")
      			pisnt_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISNT","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !pisnt_xml_tag.nil?
      				codigo_xml_tag = Nokogiri::XML("<CST>").elements.first
      				codigo_xml_tag&.content = pis["codigo"]
              pisnt_xml_tag&.add_child(codigo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISOutr" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			pis_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			pis = produtos[index].dig("imposto","pis")

      			if !pis_xml_tag.nil?
      				if ["49","50","51","52","53","54","55","56","60","61","62","63","64","65","66","67","70","71","72","73","74","75","98","99"].include?("%02d" % pis["codigo"])
      					pis_outr_xml_tag = Nokogiri::XML("<PISOutr>").elements.first
      					pis_xml_tag&.add_child(pis_outr_xml_tag)
      				end
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISOutr//xs:CST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			pis = produtos[index].dig("imposto","pis")
      			pis_outr_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISOutr","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !pis_outr_xml_tag.nil?
      				codigo_xml_tag = Nokogiri::XML("<CST>").elements.first
      				codigo_xml_tag&.content = pis["codigo"]
              pis_outr_xml_tag&.add_child(codigo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISOutr//xs:vBC" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			pis = produtos[index].dig("imposto","pis")
      			pis_outr_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISOutr","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !pis_outr_xml_tag.nil?
      				valor_base_calculo_xml_tag = Nokogiri::XML("<vBC>").elements.first
      				valor_base_calculo_xml_tag&.content = "%.2f" % (produtos[index]["preco"].to_d * produtos[index]["quantidade"].to_d).truncate(2)
              pis_outr_xml_tag&.add_child(valor_base_calculo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISOutr//xs:pPIS" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			pis = produtos[index].dig("imposto","pis")
      			pis_outr_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISOutr","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !pis_outr_xml_tag.nil?
      				aliquota_percentual_xml_tag = Nokogiri::XML("<pPIS>").elements.first
      				aliquota_percentual_xml_tag&.content = "%.2f" % pis["aliquota_percentual"].to_d.truncate(2)
              pis_outr_xml_tag&.add_child(aliquota_percentual_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISOutr//xs:qBCProd" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			pis = produtos[index].dig("imposto","pis")
      			pis_outr_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISOutr","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !pis_outr_xml_tag.nil?
      				quantidade_xml_tag = Nokogiri::XML("<qBCProd>").elements.first
      				quantidade_xml_tag&.content = produtos[index]["quantidade"]
              pis_outr_xml_tag&.add_child(quantidade_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISOutr//xs:vAliqProd" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			pis = produtos[index].dig("imposto","pis")
      			pis_outr_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISOutr","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !pis_outr_xml_tag.nil?
      				aliquota_valor_xml_tag = Nokogiri::XML("<vAliqProd>").elements.first
      				aliquota_valor_xml_tag&.content = pis["aliquota_valor"]
              pis_outr_xml_tag&.add_child(aliquota_valor_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISOutr//xs:vPIS" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			pis = produtos[index].dig("imposto","pis")
      			pis_outr_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISOutr","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !pis_outr_xml_tag.nil?
      				valor_base_calculo_xml_tag = pis_outr_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISOutr//xs:vBC","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				quantidade_xml_tag = pis_outr_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:PISOutr//xs:qBCProd","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				valor_pis_xml_tag = Nokogiri::XML("<vPIS>").elements.first
      				if !pis["aliquota_percentual"].nil?
      					valor_pis_xml_tag&.content = "%.2f" % (valor_base_calculo_xml_tag.content.to_d * pis["aliquota_percentual"].to_d).truncate(2)
      				elsif !pis["aliquota_valor"].nil?
      					valor_pis_xml_tag&.content = "%.2f" % (quantidade_xml_tag.content.to_d * pis["aliquota_valor"].to_d).truncate(2)
      				end
              pis_outr_xml_tag&.add_child(valor_pis_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PISST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
            pis = produtos[index].dig("imposto","pis")
            
            if !pis.nil?
              pisst_xml_tag = Nokogiri::XML("<PISST>").elements.first
      				imposto_xml_tag&.add_child(pisst_xml_tag) if msg["modelo"] != "65"
            end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PISST//xs:vBC" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			pis = produtos[index].dig("imposto","pis")
      			pisst_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PISST","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !pisst_xml_tag.nil?
      				valor_base_calculo_xml_tag = Nokogiri::XML("<vBC>").elements.first
      				valor_base_calculo_xml_tag&.content = "%.2f" % (produtos[index]["quantidade"].to_d * produtos[index]["preco"].to_d).truncate(2)
              pisst_xml_tag&.add_child(valor_base_calculo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PISST//xs:pPIS" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")


      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			pis = produtos[index].dig("imposto","pis")
      			pisst_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PISST","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !pisst_xml_tag.nil?
      				aliquota_percentual_xml_tag = Nokogiri::XML("<pPIS>").elements.first
      				aliquota_percentual_xml_tag&.content = "%.2f" % pis["aliquota_percentual"].to_d.truncate(2)
              pisst_xml_tag&.add_child(aliquota_percentual_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PISST//xs:qBCProd" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			pis = produtos[index].dig("imposto","pis")
      			pisst_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PISST","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !pisst_xml_tag.nil?
      				quantidade_xml_tag = Nokogiri::XML("<qBCProd>").elements.first
      				quantidade_xml_tag&.content = produtos[index]["quantidade"]
              pisst_xml_tag&.add_child(quantidade_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PISST//xs:vAliqProd" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			pis = produtos[index].dig("imposto","pis")
      			pisst_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PISST","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !pisst_xml_tag.nil?
      				aliquota_valor_xml_tag = Nokogiri::XML("<vAliqProd>").elements.first
      				aliquota_valor_xml_tag&.content = "%.2f" % pis["aliquota_valor"].to_d.truncate(2)
              pisst_xml_tag&.add_child(aliquota_valor_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PISST//xs:vPIS" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			pis = produtos[index].dig("imposto","pis")
      			pisst_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PISST","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !pisst_xml_tag.nil?
      				valor_base_calculo_xml_tag = pisst_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PISST//xs:vBC","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				valor_pis_xml_tag = Nokogiri::XML("<vPIS>").elements.first
      				if !pis["aliquota_percentual"].nil?
      					valor_pis_xml_tag&.content = "%.2f" % (pis["aliquota_percentual"].to_d * valor_base_calculo_xml_tag.content.to_d).truncate(2)
      				elsif !pis["aliquota_valor"].nil?
      					valor_pis_xml_tag&.content = "%.2f" % (pis["aliquota_valor"].to_d * produtos[index]["quantidade"].to_d).truncate(2)
      				end
              pisst_xml_tag&.add_child(valor_pis_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS" => lambda{|msg,xml|
      		produtos = msg["produtos"]

      		produtos&.each_with_index do |produto,index|
      			cofins = produto.dig("imposto","cofins")
      			imposto_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:imposto","xs"=>"http://www.portalfiscal.inf.br/nfe").first

      			if !cofins.nil?
              cofins_xml_tag = Nokogiri::XML("<COFINS>").elements.first
      				imposto_xml_tag&.add_child(cofins_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSAliq" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			cofins_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			cofins = produtos[index].dig("imposto","cofins")

      			if !cofins_xml_tag.nil?
      				if ["01","02"].include?("%02d" % cofins["codigo"])
      					cofinsaliq_xml_tag = Nokogiri::XML("<COFINSAliq>").elements.first
      					cofins_xml_tag&.add_child(cofinsaliq_xml_tag)
      				end
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSAliq//xs:CST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			cofins = produtos[index].dig("imposto","cofins")
      			cofins_aliq_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSAliq","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !cofins_aliq_xml_tag.nil?
      				codigo_xml_tag = Nokogiri::XML("<CST>").elements.first
      				codigo_xml_tag&.content = cofins["codigo"]
              cofins_aliq_xml_tag&.add_child(codigo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSAliq//xs:vBC" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			cofins = produtos[index].dig("imposto","cofins")
      			cofins_aliq_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSAliq","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !cofins_aliq_xml_tag.nil?
      				valor_base_calculo_xml_tag = Nokogiri::XML("<vBC>").elements.first
      				valor_base_calculo_xml_tag&.content = "%.2f" % (produtos[index]["quantidade"].to_d * produtos[index]["preco"].to_d).truncate(2)
              cofins_aliq_xml_tag&.add_child(valor_base_calculo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSAliq//xs:pCOFINS" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			cofins = produtos[index].dig("imposto","cofins")
      			cofins_aliq_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSAliq","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !cofins_aliq_xml_tag.nil?
      				aliquota_percentual_xml_tag = Nokogiri::XML("<pCOFINS>").elements.first
      				aliquota_percentual_xml_tag&.content = "%.2f" % cofins["aliquota_percentual"].to_d.truncate(2)
              cofins_aliq_xml_tag&.add_child(aliquota_percentual_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSAliq//xs:vCOFINS" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			cofins = produtos[index].dig("imposto","cofins")
      			cofins_aliq_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSAliq","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !cofins_aliq_xml_tag.nil?
      				valor_base_calculo_xml_tag = cofins_aliq_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSAliq//xs:vBC","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				valor_cofins_xml_tag = Nokogiri::XML("<vCOFINS>").elements.first
      				if !cofins["aliquota_percentual"].nil?
      					valor_cofins_xml_tag&.content = "%.2f" % (cofins["aliquota_percentual"] * valor_base_calculo_xml_tag.content.to_d).truncate(2)
      				elsif !cofins["aliquota_valor"].nil?
      					valor_cofins_xml_tag&.content = "%.2f" % (cofins["aliquota_valor"] * produtos[index]["quantidade"]).truncate(2)
      				end
              cofins_aliq_xml_tag&.add_child(valor_cofins_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSQtde" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			cofins_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			cofins = produtos[index].dig("imposto","cofins")

      			if !cofins_xml_tag.nil?
      				if cofins["codigo"] == "03"
      					cofinsqtde_xml_tag = Nokogiri::XML("<COFINSQtde>").elements.first
      					cofins_xml_tag&.add_child(cofinsqtde_xml_tag)
      				end
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSQtde//xs:CST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			cofins = produtos[index].dig("imposto","cofins")
      			cofins_qtde_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSQtde","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !cofins_qtde_xml_tag.nil?
      				codigo_xml_tag = Nokogiri::XML("<CST>").elements.first
      				codigo_xml_tag&.content = cofins["codigo"]
              cofins_qtde_xml_tag&.add_child(codigo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSQtde//xs:qBCProd" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			cofins = produtos[index].dig("imposto","cofins")
      			cofins_qtde_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSQtde","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !cofins_qtde_xml_tag.nil?
      				quantidade_xml_tag = Nokogiri::XML("<qBCProd>").elements.first
      				quantidade_xml_tag&.content = produtos[index]["quantidade"]
              cofins_xml_tag&.add_child(quantidade_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSQtde//xs:vAliqProd" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			cofins = produtos[index].dig("imposto","cofins")
      			cofins_qtde_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSQtde","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !cofins_qtde_xml_tag.nil?
      				aliquota_valor_xml_tag = Nokogiri::XML("<vAliqProd>").elements.first
      				aliquota_valor_xml_tag&.content = "%.2f" % cofins["aliquota_valor"].to_d.truncate(2)
              cofins_qtde_xml_tag&.add_child(aliquota_valor_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSQtde//xs:vCOFINS" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			cofins = produtos[index].dig("imposto","cofins")
      			cofins_qtde_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSQtde","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !cofins_qtde_xml_tag.nil?
      				valor_cofins_xml_tag = Nokogiri::XML("<vCOFINS>").elements.first
      				valor_cofins_xml_tag&.content = "%.2f" % (cofins["aliquota_valor"].to_d * produtos[index]["quantidade"].to_d).truncate(2)
              cofins_qtde_xml_tag&.add_child(valor_cofins_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSNT" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			cofins_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			cofins = produtos[index].dig("imposto","cofins")
      			
      			if !cofins_xml_tag.nil?
      				if ["04","05","06","07","08","09"].include?("%02d" % cofins["codigo"])
      					cofinsnt_xml_tag = Nokogiri::XML("<COFINSNT>").elements.first
      					cofins_xml_tag&.add_child(cofinsnt_xml_tag)
      				end
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSNT//xs:CST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			cofins = produtos[index].dig("imposto","cofins")
      			cofinsnt_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSNT","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !cofinsnt_xml_tag.nil?
      				codigo_xml_tag = Nokogiri::XML("<CST>").elements.first
      				codigo_xml_tag&.content = cofins["codigo"]
              cofinsnt_xml_tag&.add_child(codigo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSOutr" => lambda{|msg,xml|
      		produtos = msg["produtos"]

      		produtos&.each_with_index do |produto,index|
      			cofins = produto.dig("imposto","cofins")
      			cofins_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:imposto//xs:COFINS","xs"=>"http://www.portalfiscal.inf.br/nfe").first

      			if !cofins_xml_tag.nil?
      				if ["49","50","51","52","53","54","55","56","60","61","62","63","64","65","66","67","70","71","72","73","74","75","98","99"].include?("%02d" % cofins["codigo"])
      					cofins_outr_xml_tag = Nokogiri::XML("<COFINSOutr>").elements.first
      					cofins_xml_tag&.add_child(cofins_outr_xml_tag)
      				end
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSOutr//xs:CST" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			cofins = produtos[index].dig("imposto","cofins")
      			cofins_outr_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSOutr","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !cofins_outr_xml_tag.nil?
      				codigo_xml_tag = Nokogiri::XML("<CST>").elements.first
      				codigo_xml_tag&.content = cofins["codigo"]
              cofins_outr_xml_tag&.add_child(codigo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSOutr//xs:vBC" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			cofins = produtos[index].dig("imposto","cofins")
      			cofins_outr_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSOutr","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !cofins_outr_xml_tag.nil?
      				valor_base_calculo_xml_tag = Nokogiri::XML("<vBC>").elements.first
      				valor_base_calculo_xml_tag&.content = "%.2f" % (produtos[index]["preco"].to_d * produtos[index]["quantidade"].to_d).truncate(2)
              cofins_outr_xml_tag&.add_child(valor_base_calculo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSOutr//xs:pCOFINS" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			cofins = produtos[index].dig("imposto","cofins")
      			cofins_outr_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSOutr","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !cofins_outr_xml_tag.nil?
      				aliquota_percentual_xml_tag = Nokogiri::XML("<pCOFINS>").elements.first
      				aliquota_percentual_xml_tag&.content = "%.2f" % cofins["aliquota_percentual"].to_d.truncate(2)
              cofins_outr_xml_tag&.add_child(aliquota_percentual_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSOutr//xs:qBCProd" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			cofins = produtos[index].dig("imposto","cofins")
      			cofins_outr_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSOutr","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !cofins_outr_xml_tag.nil?
      				quantidade_xml_tag = Nokogiri::XML("<qBCProd>").elements.first
      				quantidade_xml_tag&.content = produtos[index]["quantidade"]
              cofins_outr_xml_tag&.add_child(quantidade_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSOutr//xs:vAliqProd" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			cofins = produtos[index].dig("imposto","cofins")
      			cofins_outr_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSOutr","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !cofins_outr_xml_tag.nil?
      				aliquota_valor_xml_tag = Nokogiri::XML("<vAliqProd>").elements.first
      				aliquota_valor_xml_tag&.content = "%.2f" % cofins["aliquota_valor"].to_d.truncate(2)
              cofins_outr_xml_tag&.add_child(aliquota_valor_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSOutr//xs:vCOFINS" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			cofins = produtos[index].dig("imposto","cofins")
      			cofins_outr_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSOutr","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !cofins_outr_xml_tag.nil?
      				valor_base_calculo_xml_tag = cofins_outr_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:COFINSOutr//xs:vBC","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				valor_cofins_xml_tag = Nokogiri::XML("<vCOFINS>").elements.first
      				if !cofins["aliquota_percentual"].nil?
      					valor_cofins_xml_tag&.content = "%.2f" % (valor_base_calculo_xml_tag.content.to_d * cofins["aliquota_percentual"].to_d).truncate(2)
      				elsif !cofins["aliquota_valor"].nil?
      					valor_cofins_xml_tag&.content = "%.2f" % (cofins["aliquota_valor"].to_d * produtos[index]["quantidade"].to_d).truncate(2)
      				end
              cofins_outr_xml_tag&.add_child(valor_cofins_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINSST" => lambda{|msg,xml|
      		produtos = msg["produtos"]

      		produtos&.each_with_index do |produto,index|

      			cofins = produto.dig("imposto","cofins")
      			imposto_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det[@nItem=#{index+1}]//xs:imposto","xs"=>"http://www.portalfiscal.inf.br/nfe").first

      			if !cofins.nil?
              cofinsst_xml_tag = Nokogiri::XML("<COFINSST>").elements.first
      				imposto_xml_tag&.add_child(cofinsst_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINSST//xs:vBC" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			cofins = produtos[index].dig("imposto","cofins")
      			cofinsst_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINSST","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !cofinsst_xml_tag.nil?
      				valor_base_calculo_xml_tag = Nokogiri::XML("<vBC>").elements.first
      				valor_base_calculo_xml_tag&.content = "%.2f" % (produtos[index]["quantidade"].to_d * produtos[index]["preco"].to_d).truncate(2)
              cofinsst_xml_tag&.add_child(valor_base_calculo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINSST//xs:pCOFINS" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			cofins = produtos[index].dig("imposto","cofins")
      			cofinsst_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINSST","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !cofinsst_xml_tag.nil?
      				aliquota_percentual_xml_tag = Nokogiri::XML("<pCOFINS>").elements.first
      				aliquota_percentual_xml_tag&.content = "%.2f" % cofins["aliquota_percentual"].to_d.truncate(2)
              cofinsst_xml_tag&.add_child(aliquota_percentual_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINSST//xs:qBCProd" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			cofins = produtos[index].dig("imposto","cofins")
      			cofinsst_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINSST","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !cofinsst_xml_tag.nil?
      				quantidade_xml_tag = Nokogiri::XML("<qBCProd>").elements.first
      				quantidade_xml_tag&.content = produtos[index]["quantidade"]
              cofinsst_xml_tag&.add_child(quantidade_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINSST//xs:vAliqProd" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			cofins = produtos[index].dig("imposto","cofins")
      			cofinsst_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINSST","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !cofinsst_xml_tag.nil?
      				aliquota_valor_xml_tag = Nokogiri::XML("<vAliqProd>").elements.first
      				aliquota_valor_xml_tag&.content = "%.2f" % cofins["aliquota_valor"].to_d.truncate(2)
              cofinsst_xml_tag&.add_child(aliquota_valor_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINSST//xs:vCOFINS" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			cofins = produtos[index].dig("imposto","cofins")
      			cofinsst_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINSST","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !cofinsst_xml_tag.nil?
      				valor_base_calculo_xml_tag = cofinsst_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINSST//xs:vBC","xs" => "http://www.portalfiscal.inf.br/nfe").first	
      				valor_cofins_xml_tag = Nokogiri::XML("<vCOFINS>").elements.first

      				if !cofins["aliquota_percentual"].nil?
      					valor_cofins_xml_tag&.content = "%.2f" % (cofins["aliquota_percentual"].to_d * valor_base_calculo_xml_tag.content.to_d).truncate(2)
      				elsif !cofins["aliquota_valor"].nil?
      					valor_cofins_xml_tag&.content = "%.2f" % (cofins["aliquota_valor"].to_d * produtos[index]["quantidade"].to_d).truncate(2)
      				end

              cofinsst_xml_tag&.add_child(valor_cofins_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMSUFDest" => lambda{|msg,xml|
      		produtos = msg["produtos"]

      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			if msg["produtos"][index]["cfop"].match(/^[6]\d{3}$/) and msg.dig("destinatario","contribuinte") == "9"
      				icmsufdest_xml_tag = Nokogiri::XML("<ICMSUFDest>").elements.first
      				imposto_xml_tag&.add_child(icmsufdest_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMSUFDest//xs:vBCUFDest" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icmsufdest_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMSUFDest","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmsufdest_xml_tag.nil?
      				valor_base_calculo_destino_xml_tag = Nokogiri::XML("<vBCUFDest>").elements.first
      				valor_base_calculo_destino_xml_tag&.content = "%.2f" % (produtos[index]["preco"].to_d * produtos[index]["quantidade"].to_d).truncate(2)
              icmsufdest_xml_tag&.add_child(valor_base_calculo_destino_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMSUFDest//xs:vBCFCPUFDest" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icmsufdest_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMSUFDest","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmsufdest_xml_tag.nil?
      				valor_base_calculo_fcp_destino_xml_tag = Nokogiri::XML("<vBCFCPUFDest>").elements.first
      				valor_base_calculo_fcp_destino_xml_tag&.content = "%.2f" % (produtos[index]["preco"].to_d * produtos[index]["quantidade"].to_d).truncate(2)
              icmsufdest_xml_tag&.add_child(valor_base_calculo_fcp_destino_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMSUFDest//xs:pFCPUFDest" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icmsufdest_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMSUFDest","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmsufdest_xml_tag.nil?
      				aliquota_fcp_destino_xml_tag = Nokogiri::XML("<pFCPUFDest>").elements.first
      				aliquota_fcp_destino_xml_tag&.content = "%.2f" % produtos[index].dig("imposto","icms")["percentual_fcp"].to_d.truncate(2)
              icmsufdest_xml_tag&.add_child(aliquota_fcp_destino_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMSUFDest//xs:pICMSUFDest" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icmsufdest_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMSUFDest","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmsufdest_xml_tag.nil?
      				aliquota_icms_destino_xml_tag = Nokogiri::XML("<ICMSUFDest>").elements.first
      				if msg["tipo_operacao"] == "1"
      					aliquota_icms_destino_xml_tag&.content = "%.2f" % ALIQUOTA_ICMS["#{msg.dig("emissor","uf")}#{msg.dig("destinatario","uf")}"].to_d.truncate(2)
      				elsif mgs["tipo_operacao"] == "0"
      					aliquota_icms_destino_xml_tag&.content = "%.2f" % ALIQUOTA_ICMS["#{msg.dig("destinatario","uf")}#{msg.dig("emissor","uf")}"].to_d.truncate(2)
      				end
              icmsufdest_xml_tag&.add_child(aliquota_icms_destino_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMSUFDest//xs:pICMSInter" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icmsufdest_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMSUFDest","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmsufdest_xml_tag.nil?
      				percentual_icms_interestadual_xml_tag = Nokogiri::XML("<pICMSInter>").elements.first
      				if msg["tipo_operacao"] == "1"
      					percentual_icms_interestadual_xml_tag&.content = "%.2f" % ALIQUOTA_ICMS_INTERESTADUAL["#{msg.dig("emissor","uf")}#{msg.dig("destinatario","uf")}"].to_d.truncate(2)
      				elsif mgs["tipo_operacao"] == "0"
      					percentual_icms_interestadual_xml_tag&.content = "%.2f" % ALIQUOTA_ICMS_INTERESTADUAL["#{msg.dig("destinatario","uf")}#{msg.dig("emissor","uf")}"].to_d.truncate(2)
      				end
              percentual_icms_interestadual_xml_tag&.add_child(percentual_icms_interestadual_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMSUFDest//xs:pICMSInterPart" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icmsufdest_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMSUFDest","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmsufdest_xml_tag.nil?
      				percentual_icms_partilha_xml_tag = Nokogiri::XML("<pICMSInterPartt>").elements.first
      				percentual_icms_partilha_xml_tag&.content = "100.00"
              icmsufdest_xml_tag&.add_child(percentual_icms_partilha_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMSUFDest//xs:vFCPUFDest" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icmsufdest_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMSUFDest","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmsufdest_xml_tag.nil?
      				valor_base_calculo_fcp_destino_xml_tag = icmsufdest_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMSUFDest//xs:vBCFCPUFDest","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				aliquota_fcp_destino_xml_tag = icmsufdest_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMSUFDest//xs:pFCPUFDest","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				valor_fcp_destino_xml_tag = Nokogiri::XML("<vFCPUFDest>").elements.first
      				valor_fcp_destino_xml_tag&.content = "%.2f" % (valor_base_calculo_fcp_destino_xml_tag.content.to_d * aliquota_fcp_destino_xml_tag.to_d).truncate(2)
              icmsufdest_xml_tag&.add_child(valor_fcp_destino_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMSUFDest//xs:vICMSUFDest" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icmsufdest_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMSUFDest","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmsufdest_xml_tag.nil?
      				valor_base_calculo_icms_destino_xml_tag = icmsufdest_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMSUFDest//xs:vBCUFDest","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				aliquota_icms_destino_xml_tag = icmsufdest_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMSUFDest//xs:pICMSUFDest","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				valor_icms_destino_xml_tag = Nokogiri::XML("<vICMSUFDest>").elements.first
      				valor_icms_destino_xml_tag&.content = "%.2f" % (valor_base_calculo_icms_destino_xml_tag.content.to_d * aliquota_icms_destino_xml_tag.to_d).truncate(2)
              icmsufdest_xml_tag&.add_child(valor_icms_destino_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMSUFDest//xs:vICMSUFRemet" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			icmsufdest_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ICMSUFDest","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !icmsufdest_xml_tag.nil?
      				valor_icms_rementente_xml_tag = Nokogiri::XML("<vICMSUFRemet>").elements.first
      				valor_icms_rementente_xml_tag&.content = "0.00"
              icmsufdest_xml_tag&.add_child(valor_icms_rementente_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:impostoDevol" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			imposto_devol_xml_tag = Nokogiri::XML("<impostoDevol>").elements.first
      			
      			percentual_mercadoria_devolvida_xml_tag = Nokogiri::XML("<pDevol>").elements.first
      			ipi_xml_tag = Nokogiri::XML("<IPI>").elements.first
      			
      			imposto_devol_xml_tag&.add_child(percentual_mercadoria_devolvida_xml_tag)
      			imposto_devol_xml_tag&.add_child(ipi_xml_tag)
      			imposto_xml_tag&.add_child(imposto_devol_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:impostoDevol//xs:pDevol" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		imposto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto","xs" => "http://www.portalfiscal.inf.br/nfe")

      		imposto_xml_tags&.each_with_index do |imposto_xml_tag,index|
      			imposto_devol_xml_tag = imposto_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:impostoDevol","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !produtos[index].dig("imposto","ipi").nil?
      				percentual_mercadoria_devolvida_xml_tag = imposto_devol_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:impostoDevol//xs:pDevol","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				percentual_mercadoria_devolvida_xml_tag&.content = produtos[index].dig("imposto","ipi")["percentual_mercadoria_devolvida"]
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:impostoDevol//xs:IPI" => lambda{|msg,xml|
      		produtos = msg["produtos"]
          det_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det","xs" => "http://www.portalfiscal.inf.br/nfe")

          det_xml_tags&.each_with_index do |det_xml_tag,index|
        		imposto_devol_xml_tag = det_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:impostoDevol","xs" => "http://www.portalfiscal.inf.br/nfe").first
            ipi_xml_tag = Nokogiri::XML("<IPI>").elements.first
            imposto_devol_xml_tag.add_child(ipi_xml_tag)
          end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:impostoDevol//xs:IPI//xs:vIPIDevol" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		det_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det","xs" => "http://www.portalfiscal.inf.br/nfe")

      		det_xml_tags&.each_with_index do |det_xml_tag,index|
      			imposto_devol_xml_tag = det_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:impostoDevol","xs" => "http://www.portalfiscal.inf.br/nfe").first

      			if !produtos[index].dig("imposto","ipi").nil?
      				valor_ipi_xml_tag = imposto_devol_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:IPI//xs:vIPI","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				valor_ipi_devolvido_xml_tag = Nokogiri::XML("<vIPIDevol>").elements.first
      				valor_ipi_devolvido_xml_tag&.content = "%.2f" % ((produtos[index].dig("imposto","ipi")["percentual_mercadoria_devolvida"].to_d * valor_ipi_xml_tag.content.to_d)/100.to_d).truncate(2)
      			  imposto_devol_xml_tag.add_child(valor_ipi_devolvido_xml_tag)
            end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:infAdProd" => lambda{|msg,xml|
      		produtos = msg["produtos"]
      		det_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det","xs" => "http://www.portalfiscal.inf.br/nfe")

      		det_xml_tags&.each_with_index do |det_xml_tag,index|
      			infadprod_xml_tag = Nokogiri::XML("<infAdProd>").elements.first
      			infadprod_xml_tag&.content = produtos[index]["informacoes_adicionais_produto"]
      			det_xml_tag&.add_child(infadprod_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vBC" => lambda{|msg,xml|
      		soma_base_calculo = 0.to_d
      		
      		total_valor_base_calculo_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vBC","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		valor_base_calculo_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:imposto//xs:ICMS//xs:vBC","xs" => "http://www.portalfiscal.inf.br/nfe")
      	
      		valor_base_calculo_xml_tags&.each do |tag|
      			soma_base_calculo += tag.content.to_d
      		end

      		total_valor_base_calculo_xml_tag&.content = "%.2f" % soma_base_calculo.truncate(2)
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vICMS" => lambda{|msg,xml|
      		soma_valor_icms = 0.to_d
      		
      		total_valor_icms_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vICMS","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		valor_icms_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:imposto//xs:ICMS//xs:vICMS","xs" => "http://www.portalfiscal.inf.br/nfe")
      	
      		valor_icms_xml_tags&.each do |tag|
      			soma_valor_icms += tag.content.to_d
      		end

      		total_valor_icms_xml_tag&.content = "%.2f" % soma_valor_icms.truncate(2)
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vICMSDeson" => lambda{|msg,xml|
      		soma_icms_desonerado = 0.to_d
      		
      		total_icms_desonerado_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vICMSDeson","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		icms_desonerado_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:imposto//xs:ICMS//xs:vICMSDeson","xs" => "http://www.portalfiscal.inf.br/nfe")
      	
      		icms_desonerado_xml_tags&.each do |tag|
      			soma_icms_desonerado += tag.content.to_d
      		end

      		total_icms_desonerado_xml_tag&.content = "%.2f" % soma_icms_desonerado.truncate(2)
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vFCPUFDest" => lambda{|msg,xml|
      		soma_fcp_destino = 0.to_d
      		
      		total_fcp_destino_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vFCPUFDest","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		valor_fcp_destino_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:imposto//xs:ICMSUFDest//xs:vFCPUFDest","xs" => "http://www.portalfiscal.inf.br/nfe")
      	
      		valor_fcp_destino_xml_tags&.each do |tag|
      			soma_fcp_destino += tag.content.to_d
      		end

      		total_fcp_destino_xml_tag&.content = "%.2f" % soma_fcp_destino.truncate(2)
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vICMSUFDest" => lambda{|msg,xml|
      		soma_icms_destino = 0.to_d
      		
      		total_icms_destino_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vICMSUFDest","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		valor_icms_destino_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:imposto//xs:ICMSUFDest//xs:vICMSUFDest","xs" => "http://www.portalfiscal.inf.br/nfe")
      	
      		valor_icms_destino_xml_tags&.each do |tag|
      			soma_icms_destino += tag.content.to_d
      		end

      		total_icms_destino_xml_tag&.content = "%.2f" % soma_icms_destino.truncate(2)
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vICMSUFRemet" => lambda{|msg,xml|
      		total_icms_destino_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vICMSUFDest","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		total_icms_destino_xml_tag&.content = "%.2f" % 0
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vFCP" => lambda{|msg,xml|
      		soma_fcp = 0.to_d
      		
      		total_fcp_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vFCP","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		valor_fcp_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:imposto//xs:ICMS//xs:vFCP","xs" => "http://www.portalfiscal.inf.br/nfe")
      	
      		valor_fcp_xml_tags&.each do |tag|
      			soma_fcp += tag.content.to_d
      		end

      		total_fcp_xml_tag&.content = "%.2f" % soma_fcp.truncate(2)
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vBCST" => lambda{|msg,xml|
      		soma_base_calculo_st = 0.to_d
      		
      		total_base_calculo_st_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vBCST","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		valor_base_calculo_st_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:imposto//xs:ICMS//xs:vBCST","xs" => "http://www.portalfiscal.inf.br/nfe")
      	
      		valor_base_calculo_st_xml_tags&.each do |tag|
      			soma_base_calculo_st += tag.content.to_d
      		end

      		total_base_calculo_st_xml_tag&.content = "%.2f" % soma_base_calculo_st.truncate(2)
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vST" => lambda{|msg,xml|
      		soma_icms_st = 0.to_d
      		
      		total_icms_st_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vST","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		valor_icms_st_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:imposto//xs:ICMS//xs:vICMSST","xs" => "http://www.portalfiscal.inf.br/nfe")
      	
      		valor_icms_st_xml_tags&.each do |tag|
      			soma_icms_st += tag.content.to_d
      		end

      		total_icms_st_xml_tag&.content = "%.2f" % soma_icms_st.truncate(2)
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vFCPST" => lambda{|msg,xml|
      		soma_fcp_st = 0.to_d
      		
      		total_fcp_st_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vFCPST","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		valor_fcp_st_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:imposto//xs:ICMS//xs:vFCPST","xs" => "http://www.portalfiscal.inf.br/nfe")
      	
      		valor_fcp_st_xml_tags&.each do |tag|
      			soma_fcp_st += tag.content.to_d
      		end

      		total_fcp_st_xml_tag&.content = "%.2f" % soma_fcp_st.truncate(2)
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vFCPSTRet" => lambda{|msg,xml|
      		soma_fcp_retido = 0.to_d
      		
      		total_fcp_st_retido_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vFCPSTRet","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		valor_fcp_st_retido_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:imposto//xs:ICMS//xs:vFCPSTRet","xs" => "http://www.portalfiscal.inf.br/nfe")
      	
      		valor_fcp_st_retido_xml_tags&.each do |tag|
      			soma_fcp_retido += tag.content.to_d
      		end

      		total_fcp_st_retido_xml_tag&.content = "%.2f" % soma_fcp_retido.truncate(2)
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vProd" => lambda{|msg,xml|
      		soma_valor_produto = 0.to_d
      		
      		total_valor_produto_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vProd","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		valor_produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:vProd","xs" => "http://www.portalfiscal.inf.br/nfe")
      	
      		valor_produto_xml_tags&.each do |tag|
      			soma_valor_produto += tag.content.to_d
      		end

      		total_valor_produto_xml_tag&.content = "%.2f" % soma_valor_produto.truncate(2)
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vFrete" => lambda{|msg,xml|
      		soma_valor_frete = 0.to_d
      		
      		total_valor_frete_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vFrete","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		valor_frete_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:vFrete","xs" => "http://www.portalfiscal.inf.br/nfe")
      	
      		valor_frete_xml_tags&.each do |tag|
      			soma_valor_frete += tag.content.to_d
      		end

      		total_valor_frete_xml_tag&.content = "%.2f" % soma_valor_frete.truncate(2)
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vSeg" => lambda{|msg,xml|
      		soma_valor_seguro = 0.to_d
      		
      		total_valor_seguro_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vSeg","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		valor_seguro_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:vSeg","xs" => "http://www.portalfiscal.inf.br/nfe")
      	
      		valor_seguro_xml_tags&.each do |tag|
      			soma_valor_seguro += tag.content.to_d
      		end

      		total_valor_seguro_xml_tag&.content = "%.2f" % soma_valor_seguro.truncate(2)
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vDesc" => lambda{|msg,xml|
      		soma_valor_desconto = 0.to_d
      		
      		total_valor_desconto_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vDesc","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		valor_desconto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:vDesc","xs" => "http://www.portalfiscal.inf.br/nfe")
      	
      		valor_desconto_xml_tags&.each do |tag|
      			soma_valor_desconto += tag.content.to_d
      		end

      		total_valor_desconto_xml_tag&.content = "%.2f" % soma_valor_desconto.truncate(2)
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vII" => lambda{|msg,xml|
      		soma_ii = 0.to_d
      		
      		total_ii_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vII","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		valor_ii_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:imposto//xs:II//xs:vII","xs" => "http://www.portalfiscal.inf.br/nfe")
      	
      		valor_ii_xml_tags&.each do |tag|
      			soma_ii += tag.content.to_d
      		end

      		total_ii_xml_tag&.content = "%.2f" % soma_ii.truncate(2)
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vIPI" => lambda{|msg,xml|
      		soma_ipi = 0.to_d
      		
      		total_ipi_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vIPI","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		valor_ipi_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:imposto//xs:IPI//xs:vIPI","xs" => "http://www.portalfiscal.inf.br/nfe")
      	
      		valor_ipi_xml_tags&.each do |tag|
      			soma_ipi += tag.content.to_d
      		end

      		total_ipi_xml_tag&.content = "%.2f" % soma_ipi.truncate(2)
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vIPIDevol" => lambda{|msg,xml|
      		soma_ipi_devolvido = 0.to_d
      		
      		total_ipi_devolvido_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vIPIDevol","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		valor_ipi_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:impostoDevol//xs:IPI//xs:vIPIDevol","xs" => "http://www.portalfiscal.inf.br/nfe")
      	
      		valor_ipi_xml_tags&.each do |tag|
      			soma_ipi_devolvido += tag.content.to_d
      		end

      		total_ipi_devolvido_xml_tag&.content = "%.2f" % soma_ipi_devolvido.truncate(2)
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vPIS" => lambda{|msg,xml|
      		soma_pis = 0.to_d
      		
      		total_pis_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vPIS","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		valor_pis_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:imposto//xs:PIS//xs:vPIS","xs" => "http://www.portalfiscal.inf.br/nfe")
      	
      		valor_pis_xml_tags&.each do |tag|
      			soma_pis += tag.content.to_d
      		end

      		total_pis_xml_tag&.content = "%.2f" % soma_pis.truncate(2)
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vCOFINS" => lambda{|msg,xml|
      		soma_cofins = 0.to_d
      		
      		total_cofins_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vCOFINS","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		valor_cofins_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:imposto//xs:COFINS//xs:vCOFINS","xs" => "http://www.portalfiscal.inf.br/nfe")
      	
      		valor_cofins_xml_tags&.each do |tag|
      			soma_cofins += tag.content.to_d
      		end

      		total_cofins_xml_tag&.content = "%.2f" % soma_cofins.truncate(2)
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vOutro" => lambda{|msg,xml|
      		soma_valor_outro = 0.to_d
      		
      		total_valor_outro_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vOutro","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		valor_outro_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod//xs:vOutro","xs" => "http://www.portalfiscal.inf.br/nfe")
      	
      		valor_outro_xml_tags&.each do |tag|
      			soma_valor_outro += tag.content.to_d
      		end

      		total_valor_outro_xml_tag&.content = "%.2f" % soma_valor_outro.truncate(2)
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vNF" => lambda{|msg,xml|
      		soma_servicos = 0.to_d
      		produtos = msg["produtos"]
      		
          produto_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")

          produto_xml_tags&.each_with_index do |tag,index|
          	if !produtos[index].dig("imposto","issqn").nil?
          		soma_servicos += "%.2f" % (produtos[index]["quantidade"].to_d * produtos[index]["preco"].to_d)
          	end
          end

      		total_nota_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vNF","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		
          if !total_nota_xml_tag.nil?
        		total_produtos_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vProd","xs" => "http://www.portalfiscal.inf.br/nfe").first
        		total_descontos_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vDesc","xs" => "http://www.portalfiscal.inf.br/nfe").first
        		total_icms_desonerado_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vICMSDeson","xs" => "http://www.portalfiscal.inf.br/nfe").first
        		total_icms_st_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vST","xs" => "http://www.portalfiscal.inf.br/nfe").first
        		total_fcp_st_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vFCPST","xs" => "http://www.portalfiscal.inf.br/nfe").first
        		total_frete_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vFrete","xs" => "http://www.portalfiscal.inf.br/nfe").first
        		total_seguro_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vSeg","xs" => "http://www.portalfiscal.inf.br/nfe").first
        		total_outros_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vOutro","xs" => "http://www.portalfiscal.inf.br/nfe").first
        		total_ii_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vII","xs" => "http://www.portalfiscal.inf.br/nfe").first
        		total_ipi_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vIPI","xs" => "http://www.portalfiscal.inf.br/nfe").first
        		total_ipi_devolvido_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vIPIDevol","xs" => "http://www.portalfiscal.inf.br/nfe").first

            total_nota = 0.to_d
            total_nota += total_produtos_xml_tag.content.to_d
            total_nota -= total_descontos_xml_tag.content.to_d
            total_nota -= total_icms_desonerado_xml_tag.content.to_d
            total_nota += total_icms_st_xml_tag.content.to_d
            total_nota += total_fcp_st_xml_tag.content.to_d
            total_nota += total_frete_xml_tag.content.to_d
            total_nota += total_seguro_xml_tag.content.to_d
            total_nota += total_outros_xml_tag.content.to_d
            total_nota += total_ii_xml_tag.content.to_d
            total_nota += total_ipi_xml_tag.content.to_d
            total_nota += soma_servicos

        		total_nota_xml_tag&.content = "%.2f" % total_nota.truncate(2)
          end

      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ISSQNtot//xs:vServ" => lambda{|msg,xml|
      		soma_valor_servicos = 0.to_d
      		produtos = msg["produtos"]

      		total_valor_servicos_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ISSQNTot//xs:vServ","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		valor_servico_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:prod","xs" => "http://www.portalfiscal.inf.br/nfe")
      	
      		valor_servico_xml_tags&.each_with_index do |tag,index|
      			if !produtos[index].dig("imposto","issqn").nil?
      				soma_valor_servicos += (produtos[index]["quantidade"].to_d * produtos[index]["preco"].to_d).truncate(2)
      			end
      		end

      		total_valor_servicos_xml_tag&.content = "%.2f" % soma_valor_servicos.truncate(2)
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ISSQNtot//xs:vBC" => lambda{|msg,xml|
      		soma_base_calculo_issqn = 0.to_d

      		total_valor_base_calculo_issqn_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ISSQNTot//xs:vBC","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		valor_base_calculo_issqn_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN//xs:vBC","xs" => "http://www.portalfiscal.inf.br/nfe")
      	
      		valor_base_calculo_issqn_xml_tags&.each do |tag|
      			soma_base_calculo_issqn += tag.content.to_d
      		end

      		total_valor_base_calculo_issqn_xml_tag&.content = "%.2f" % soma_base_calculo_issqn.truncate(2)
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ISSQNtot//xs:vISS" => lambda{|msg,xml|
      		soma_valor_issqn = 0.to_d

      		total_valor_issqn_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ISSQNTot//xs:vISS","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		valor_issqn_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN//xs:vISSQN","xs" => "http://www.portalfiscal.inf.br/nfe")
      	
      		valor_issqn_xml_tags&.each do |tag|
      			soma_valor_issqn += tag.content.to_d
      		end

      		total_valor_issqn_xml_tag&.content = "%.2f" % soma_valor_issqn.truncate(2)
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ISSQNtot//xs:vPIS" => lambda{|msg,xml|
      		soma_pis = 0.to_d
      		produtos = msg["produtos"]

      		total_pis_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ISSQNTot//xs:vPIS","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		det_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det","xs" => "http://www.portalfiscal.inf.br/nfe")
      	
      		det_xml_tags&.each_with_index do |tag,index|
      			if !produtos[index].dig("imposto","issqn").nil?
      				valor_pis_xml_tag = tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:PIS//xs:vPIS","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				if !produtos[index].dig("imposto","pis").nil?
      					soma_pis += valor_pis_xml_tag.content.to_d
      				end
      			end
      		end

      		total_pis_xml_tag&.content = "%.2f" % soma_pis.truncate(2)
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ISSQNtot//xs:vCOFINS" => lambda{|msg,xml|
      		soma_cofins = 0.to_d
      		produtos = msg["produtos"]

      		total_cofins_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ISSQNTot//xs:vCOFINS","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		det_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det","xs" => "http://www.portalfiscal.inf.br/nfe")
      	
      		det_xml_tags&.each_with_index do |tag,index|
      			if !produtos[index].dig("imposto","issqn").nil?
      				valor_cofins_xml_tag = tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:COFINS//xs:vCOFINS","xs" => "http://www.portalfiscal.inf.br/nfe").first
      				if !produtos[index].dig("imposto","pis").nil?
      					soma_cofins += valor_cofins_xml_tag.content.to_d
      				end
      			end
      		end

      		total_cofins_xml_tag&.content = "%.2f" % soma_cofins.truncate(2)
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ISSQNtot//xs:dCompet" => lambda{|msg,xml|
      		data_servico_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ISSQNTot//xs:dCompet","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		data_servico_xml_tag&.content = msg["data_prestacao_servico"]
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ISSQNtot//xs:vDeducao" => lambda{|msg,xml|
      		soma_deducao = 0.to_d

      		total_deducao_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ISSQNTot//xs:vDeducao","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		valor_deducao_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN//xs:vDeducao","xs" => "http://www.portalfiscal.inf.br/nfe")
      	
      		valor_deducao_xml_tags&.each do |tag|
      			soma_deducao += tag.content.to_d
      		end

      		total_deducao_xml_tag&.content = "%.2f" % soma_deducao.truncate(2)
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ISSQNtot//xs:vOutro" => lambda{|msg,xml|
      		soma_outros = 0.to_d

      		total_outros_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ISSQNTot//xs:vOutro","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		valor_outros_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN//xs:vOutro","xs" => "http://www.portalfiscal.inf.br/nfe")
      	
      		valor_outros_xml_tags&.each do |tag|
      			soma_outros += tag.content.to_d
      		end

      		total_outros_xml_tag&.content = "%.2f" % soma_outros.truncate(2)
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ISSQNtot//xs:vDescIncond" => lambda{|msg,xml|
      		soma_desconto_incondicional = 0.to_d

      		total_desconto_incondicional_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ISSQNTot//xs:vDescIncond","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		valor_desconto_incondicional_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN//xs:vDescIncond","xs" => "http://www.portalfiscal.inf.br/nfe")
      	
      		valor_desconto_incondicional_xml_tags&.each do |tag|
      			soma_desconto_incondicional += tag.content.to_d
      		end

      		total_desconto_incondicional_xml_tag&.content = "%.2f" % soma_desconto_incondicional.truncate(2)
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ISSQNtot//xs:vDescCond" => lambda{|msg,xml|
      		soma_desconto_condicional = 0.to_d

      		total_desconto_condicional_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ISSQNTot//xs:vDescCond","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		valor_desconto_condicional_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN//xs:vDescCond","xs" => "http://www.portalfiscal.inf.br/nfe")
      	
      		valor_desconto_condicional_xml_tags&.each do |tag|
      			soma_desconto_condicional += tag.content.to_d
      		end

      		total_desconto_condicional_xml_tag&.content = "%.2f" % soma_desconto_condicional.truncate(2)
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ISSQNtot//xs:vISSRet" => lambda{|msg,xml|
      		soma_issqn_retencao = 0.to_d

      		total_issqn_retencao_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ISSQNTot//xs:vISSRet","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		valor_issqn_retencao_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:det//xs:imposto//xs:ISSQN//xs:vISSRet","xs" => "http://www.portalfiscal.inf.br/nfe")
      	
      		valor_issqn_retencao_xml_tags&.each do |tag|
      			soma_issqn_retencao += tag.content.to_d
      		end

      		total_issqn_retencao_xml_tag&.content = "%.2f" % soma_issqn_retencao.truncate(2)
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ISSQNtot//xs:cRegTrib" => lambda{|msg,xml|
      		codigo_regime_tributacao_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ISSQNTot//xs:cRegTrib","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		codigo_regime_tributacao_xml_tag&.content = msg["codigo_regime_especial_tributacao"]
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:retTrib//xs:vRetPIS" => lambda{|msg,xml|
      		valor_pis_retido_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:retTrib//xs:vRetPIS","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		valor_pis_retido_xml_tag&.content = msg["valor_pis_retido"]
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:retTrib//xs:vRetCOFINS" => lambda{|msg,xml|
      		valor_cofins_retido_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:retTrib//xs:vRetCOFINS","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		valor_cofins_retido_xml_tag&.content = msg["valor_cofins_retido"]
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:retTrib//xs:vRetCSLL" => lambda{|msg,xml|
      		valor_csll_retido_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:retTrib//xs:vRetCSLL","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		valor_csll_retido_xml_tag&.content = msg["valor_csll_retido"]
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:retTrib//xs:vBCIRRF" => lambda{|msg,xml|
      		valor_base_calculo_irrf_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:retTrib//xs:vBCIRRF","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		valor_base_calculo_irrf_xml_tag&.content = msg["valor_base_calculo_irrf"]
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:retTrib//xs:vIRRF" => lambda{|msg,xml|
      		valor_irrf_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:retTrib//xs:vIRRF","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		valor_irrf_xml_tag&.content = msg["valor_irrf"]
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:retTrib//xs:vBCRetPrev" => lambda{|msg,xml|
      		valor_base_calculo_retencao_previdencia_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:retTrib//xs:vBCRetPrev","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		valor_base_calculo_retencao_previdencia_xml_tag&.content = msg["valor_base_calculo_retencao_previdencia"]
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:retTrib//xs:vRetPrev" => lambda{|msg,xml|
      		valor_retencao_previdencia_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:retTrib//xs:vRetPrev","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		valor_retencao_previdencia_xml_tag&.content = msg["valor_retencao_previdencia"]
      	},	
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:modFrete" => lambda{|msg,xml|
      		modalidade_frete = msg.dig("transporte","modalidade_frete")
      		modfrete_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:modFrete","xs"=>"http://www.portalfiscal.inf.br/nfe").first
      		modfrete_xml_tag&.content = modalidade_frete.nil? ? 9 : modalidade_frete
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:transporta//xs:CNPJ" => lambda{|msg,xml|
      		if !msg.dig("transporte","cpf_cnpj").nil?
      			cpf_cnpj_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:transporta//xs:CNPJ","xs"=>"http://www.portalfiscal.inf.br/nfe").first
      			cpf_cnpj_xml_tag&.content = msg.dig("transporte","cpf_cnpj") if msg.dig("transporte","cpf_cnpj")&.length == 14
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:transporta//xs:CPF" => lambda{|msg,xml|
      		if !msg.dig("transporte","cpf_cnpj").nil?
      			cpf_cnpj_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:transporta//xs:CPF","xs"=>"http://www.portalfiscal.inf.br/nfe").first
      			cpf_cnpj_xml_tag&.content = msg.dig("transporte","cpf_cnpj") if msg.dig("transporte","cpf_cnpj")&.length == 11
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:transporta//xs:xNome" => lambda{|msg,xml|
      		if !msg.dig("transporte","nome_razao_social").nil?
      			nome_razao_social_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:transporta//xs:xNome","xs"=>"http://www.portalfiscal.inf.br/nfe").first
      			nome_razao_social_xml_tag&.content = msg.dig("transporte","nome_razao_social")
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:transporta//xs:IE" => lambda{|msg,xml|
      		if !msg.dig("transporte","inscricao_estadual").nil?
      			inscricao_estadual_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:transporta//xs:IE","xs"=>"http://www.portalfiscal.inf.br/nfe").first
      			inscricao_estadual_xml_tag&.content = msg.dig("transporte","inscricao_estadual")
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:transporta//xs:xEnder" => lambda{|msg,xml|
      		if !msg.dig("transporte","endereco").nil?
      			endereco_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:transporta//xs:xEnder","xs"=>"http://www.portalfiscal.inf.br/nfe").first
      			endereco_xml_tag&.content = msg.dig("transporte","endereco")
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:transporta//xs:xMun" => lambda{|msg,xml|
      		if !msg.dig("transporte","nome_municipio").nil?
      			nome_municipio_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:transporta//xs:xMun","xs"=>"http://www.portalfiscal.inf.br/nfe").first
      			nome_municipio_xml_tag&.content = msg.dig("transporte","nome_municipio")
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:transporta//xs:UF" => lambda{|msg,xml|
      		if !msg.dig("transporte","uf_transportador").nil?
      			uf_transportador_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:transporta//xs:UF","xs"=>"http://www.portalfiscal.inf.br/nfe").first
      			uf_transportador_xml_tag&.content = msg.dig("transporte","uf_transportador")
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:retTransp//xs:vServ" => lambda{|msg,xml|
      		if !msg.dig("transporte","valor_servico").nil?
      			valor_servico_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:retTransp//xs:vServ","xs"=>"http://www.portalfiscal.inf.br/nfe").first
      			valor_servico_xml_tag&.content = msg.dig("transporte","valor_servico")
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:retTransp//xs:vBCRet" => lambda{|msg,xml|
      		if !msg.dig("transporte","base_calculo_retencao_icms").nil?
      			base_calculo_retencao_icms_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:retTransp//xs:vBCRet","xs"=>"http://www.portalfiscal.inf.br/nfe").first
      			base_calculo_retencao_icms_xml_tag&.content = "%.2f" % msg.dig("transporte","base_calculo_retencao_icms").to_d.truncate(2)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:retTransp//xs:pICMSRet" => lambda{|msg,xml|
      		if !msg.dig("transporte","aliquota_retencao").nil?
      			aliquota_retencao_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:retTransp//xs:pICMSRet","xs"=>"http://www.portalfiscal.inf.br/nfe").first
      			aliquota_retencao_xml_tag&.content = "%.2f" % msg.dig("transporte","aliquota_retencao").to_d.truncate(2)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:retTransp//xs:vICMSRet" => lambda{|msg,xml|
      		if !msg.dig("transporte","valor_servico").nil?
      			valor_icms_retido_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:retTransp//xs:vICMSRet","xs"=>"http://www.portalfiscal.inf.br/nfe").first
      			valor_icms_retido_xml_tag&.content = "%.2f" % (msg.dig("transporte","aliquota_retencao").to_d.truncate(2) * msg.dig("transporte","base_calculo_retencao_icms").to_d.truncate(2)).truncate(2)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:retTransp//xs:CFOP" => lambda{|msg,xml|
      		if !msg.dig("transporte","cfop").nil?
      			cfop_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:retTransp//xs:CFOP","xs"=>"http://www.portalfiscal.inf.br/nfe").first
      			cfop_xml_tag&.content = msg.dig("transporte","cfop")
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:retTransp//xs:cMunFG" => lambda{|msg,xml|
      		if !msg.dig("transporte","base_calculo_retencao_icms").nil?
      			base_calculo_retencao_icms_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:retTransp//xs:cMunFG","xs"=>"http://www.portalfiscal.inf.br/nfe").first
      			base_calculo_retencao_icms_xml_tag&.content = msg.dig("transporte","base_calculo_retencao_icms")
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:veicTransp//xs:placa" => lambda{|msg,xml|
      		if !msg.dig("transporte","placa").nil?
      			placa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:veicTransp//xs:placa","xs"=>"http://www.portalfiscal.inf.br/nfe").first
      			placa_xml_tag&.content = msg.dig("transporte","placa")
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:veicTransp//xs:UF" => lambda{|msg,xml|
      		if !msg.dig("transporte","uf_trator").nil?
      			uf_trator_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:veicTransp//xs:UF","xs"=>"http://www.portalfiscal.inf.br/nfe").first
      			uf_trator_xml_tag&.content = msg.dig("transporte","uf_trator")
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:veicTransp//xs:RNTC" => lambda{|msg,xml|
      		if !msg.dig("transporte","rntc").nil?
      			rntc_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:veicTransp//xs:RNTC","xs"=>"http://www.portalfiscal.inf.br/nfe").first
      			rntc_xml_tag&.content = msg.dig("transporte","rntc")
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:reboque" => lambda{|msg,xml|
      		reboques = msg.dig("transporte","reboques")
      		reboque_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:reboque","xs" => "http://www.portalfiscal.inf.br/nfe")
      		reboque_xml_tags&.each{|reboque_xml_tag| reboque_xml_tag.remove }

      		rntc_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:rntc","xs" => "http://www.portalfiscal.inf.br/nfe").first

      		reboques&.each do |reboque|
      			reboque_xml_tag = Nokogiri::XML("<reboque>").elements.first
      			ultimo_reboque_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:reboques","xs" => "http://www.portalfiscal.inf.br/nfe").last
      			
      			if !ultimo_reboque_xml_tag.nil?
      				ultimo_reboque_xml_tag&.after(reboque_xml_tag)
      			else
      				rntc_xml_tag&.after(reboque_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:reboque//xs:placa" => lambda{|msg,xml|
      		reboques = msg.dig("transporte","reboques")
      		reboque_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:reboque","xs" => "http://www.portalfiscal.inf.br/nfe")

      		reboque_xml_tags&.each_with_index do |reboque_xml_tag,index|
      			placa_xml_tag = Nokogiri::XML("<placa>").elements.first
      			placa_xml_tag&.content = reboques[index]["placa"]
      			reboque_xml_tag&.add_child(placa_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:reboque//xs:UF" => lambda{|msg,xml|
      		reboques = msg.dig("transporte","reboques")
      		reboque_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:reboque","xs" => "http://www.portalfiscal.inf.br/nfe")

      		reboque_xml_tags&.each_with_index do |reboque_xml_tag,index|
      			uf_xml_tag = Nokogiri::XML("<UF>").elements.first
      			uf_xml_tag&.content = reboques[index]["uf"]
      			reboque_xml_tag&.add_child(uf_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:reboque//xs:RNTC" => lambda{|msg,xml|
      		reboques = msg.dig("transporte","reboques")
      		reboque_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:reboque","xs" => "http://www.portalfiscal.inf.br/nfe")

      		reboque_xml_tags&.each_with_index do |reboque_xml_tag,index|
      			rntc_xml_tag = Nokogiri::XML("<RNTC>").elements.first
      			rntc_xml_tag&.content = reboques[index]["rntc"]
      			reboque_xml_tag&.add_child(rntc_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:vagao" => lambda{|msg,xml|
      		if !msg.dig("transporte","vagao").nil?
      			vagao_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:vagao","xs"=>"http://www.portalfiscal.inf.br/nfe").first
      			vagao_xml_tag&.content = msg.dig("transporte","vagao")
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:balsa" => lambda{|msg,xml|
      		if !msg.dig("transporte","balsa").nil?
      			balsa_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:balsa","xs"=>"http://www.portalfiscal.inf.br/nfe").first
      			balsa_xml_tag&.content = msg.dig("transporte","balsa")
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:vol" => lambda{|msg,xml|
      		volumes = msg.dig("transporte","volumes")
      		transp_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		volume_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:vol","xs" => "http://www.portalfiscal.inf.br/nfe")
      		volume_xml_tags&.each{|volume_xml_tag| volume_xml_tag.remove }

      		volumes&.each do |volume|
      			volume_xml_tag = Nokogiri::XML("<vol>").elements.first
      			transp_xml_tag&.add_child(volume_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:vol//xs:qVol" => lambda{|msg,xml|
      		volumes = msg.dig("transporte","volumes")

      		volumes_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:vol","xs" => "http://www.portalfiscal.inf.br/nfe")

      		volumes_xml_tags&.each_with_index do |volume_xml_tag,index|
      			quantidade_volumes_xml_tag = Nokogiri::XML("<qVol>").elements.first
      			quantidade_volumes_xml_tag&.content = volumes[index]["quantidade_volumes"]
      			volume_xml_tag&.add_child(quantidade_volumes_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:vol//xs:esp" => lambda{|msg,xml|
      		volumes = msg.dig("transporte","volumes")

      		volumes_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:vol","xs" => "http://www.portalfiscal.inf.br/nfe")

      		volumes_xml_tags&.each_with_index do |volume_xml_tag,index|
      			especie_volumes_xml_tag = Nokogiri::XML("<esp>").elements.first
      			especie_volumes_xml_tag&.content = volumes[index]["especie_volumes"]
      			volume_xml_tag&.add_child(especie_volumes_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:vol//xs:marca" => lambda{|msg,xml|
      		volumes = msg.dig("transporte","volumes")

      		volumes_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:vol","xs" => "http://www.portalfiscal.inf.br/nfe")

      		volumes_xml_tags&.each_with_index do |volume_xml_tag,index|
      			marca_volumes_xml_tag = Nokogiri::XML("<marca>").elements.first
      			marca_volumes_xml_tag&.content = volumes[index]["marca_volumes"]
      			volume_xml_tag&.add_child(marca_volumes_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:vol//xs:nVol" => lambda{|msg,xml|
      		volumes = msg.dig("transporte","volumes")

      		volumes_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:vol","xs" => "http://www.portalfiscal.inf.br/nfe")

      		volumes_xml_tags&.each_with_index do |volume_xml_tag,index|
      			numeracao_volumes_xml_tag = Nokogiri::XML("<nVol>").elements.first
      			numeracao_volumes_xml_tag&.content = volumes[index]["numeracao_volumes"]
      			volume_xml_tag&.add_child(numeracao_volumes_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:vol//xs:pesoL" => lambda{|msg,xml|
      		volumes = msg.dig("transporte","volumes")

      		volumes_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:vol","xs" => "http://www.portalfiscal.inf.br/nfe")

      		volumes_xml_tags&.each_with_index do |volume_xml_tag,index|
      			peso_liquido_xml_tag = Nokogiri::XML("<pesoL>").elements.first
      			peso_liquido_xml_tag&.content = volumes[index]["peso_liquido"]
      			volume_xml_tag&.add_child(peso_liquido_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:vol//xs:pesoB" => lambda{|msg,xml|
      		volumes = msg.dig("transporte","volumes")

      		volumes_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:vol","xs" => "http://www.portalfiscal.inf.br/nfe")

      		volumes_xml_tags&.each_with_index do |volume_xml_tag,index|
      			peso_bruto_xml_tag = Nokogiri::XML("<pesoB>").elements.first
      			peso_bruto_xml_tag&.content = volumes[index]["peso_bruto"]
      			volume_xml_tag&.add_child(peso_bruto_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:vol//xs:lacres" => lambda{|msg,xml|
      		volumes = msg.dig("transporte","volumes")

      		volumes_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:vol","xs" => "http://www.portalfiscal.inf.br/nfe")

      		volumes_xml_tags&.each_with_index do |volume_xml_tag,index|
      			if !volumes[index]["lacres"].nil?
      				lacres = volumes[index]["lacres"]

      				lacres&.each do |lacre|
      					lacre_xml_tag = Nokogiri::XML("<lacre>").elements.first
      					volume_xml_tag&.add_child(lacre_xml_tag)
      				end
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:vol//xs:lacres//xs:nLacre" => lambda{|msg,xml|
      		volumes = msg.dig("transporte","volumes")

      		volumes_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:vol","xs" => "http://www.portalfiscal.inf.br/nfe")

      		volumes_xml_tags&.each_with_index do |volume_xml_tag,volume_index|
      			lacres_xml_tags = volume_xml_tag.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:transp//xs:vol//xs:lacres","xs" => "http://www.portalfiscal.inf.br/nfe")
      			
      			lacres_xml_tags&.each_with_index do |lacre_xml_tag,lacre_index|
      				lacre = volumes[volume_index]["lacres"][lacre_index]
      				numero_lacre_xml_tag = Nokogiri::XML("<nLacre>").elements.first
      				numero_lacre_xml_tag&.content = lacre["numero_lacre"]
      				lacre_xml_tag&.add_child(numero_lacre_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:cobr//xs:fat//xs:nFat" => lambda{|msg,xml|
      		fatura_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:cobr//xs:nFat","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		fatura_xml_tag&.content = msg.dig("cobranca","fatura")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:cobr//xs:fat//xs:vOrig" => lambda{|msg,xml|
      		valor_total_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:cobr//xs:vOrig","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		valor_total_xml_tag&.content = msg.dig("cobranca","valor_total")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:cobr//xs:fat//xs:vDesc" => lambda{|msg,xml|
      		valor_desconto_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:cobr//xs:vDesc","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		valor_desconto_xml_tag&.content = msg.dig("cobranca","valor_desconto")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:cobr//xs:fat//xs:vLiq" => lambda{|msg,xml|
      		valor_liquido_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:cobr//xs:vLiq","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		valor_liquido_xml_tag&.content = msg.dig("cobranca","valor_liquido")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:cobr//xs:dup" => lambda{|msg,xml|
      		cobranca_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:cobr","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		parcela_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:cobr//xs:dup","xs" => "http://www.portalfiscal.inf.br/nfe")
      		parcela_xml_tags&.each{|parcela_xml_tag| parcela_xml_tag.remove }

      		parcelas = msg.dig("cobranca","parcelas")

      		parcelas&.each do |parcela|
      			parcela_xml_tag = Nokogiri::XML("<dup>").elements.first
      			cobranca_xml_tag&.add_child(parcela_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:cobr//xs:dup//xs:nDup" => lambda{|msg,xml|
      		parcela_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:cobr//xs:dup","xs" => "http://www.portalfiscal.inf.br/nfe")

      		parcelas = msg.dig("cobranca","parcelas")

      		parcela_xml_tags&.each_with_index do |parcela_xml_tag,index|
      			numero_parcela_xml_tag = Nokogiri::XML("<nDup>").elements.first
      			numero_parcela_xml_tag&.content = parcelas[index]["numero_parcela"]
      			parcela_xml_tag&.add_child(numero_parcela_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:cobr//xs:dup//xs:dVenc" => lambda{|msg,xml|
      		parcela_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:cobr//xs:dup","xs" => "http://www.portalfiscal.inf.br/nfe")

      		parcelas = msg.dig("cobranca","parcelas")

      		parcela_xml_tags&.each_with_index do |parcela_xml_tag,index|
      			vencimento_xml_tag = Nokogiri::XML("<dVenc>").elements.first
      			vencimento_xml_tag&.content = parcelas[index]["vencimento"]
      			parcela_xml_tag&.add_child(vencimento_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:cobr//xs:dup//xs:vDup" => lambda{|msg,xml|
      		parcela_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:cobr//xs:dup","xs" => "http://www.portalfiscal.inf.br/nfe")

      		parcelas = msg.dig("cobranca","parcelas")

      		parcela_xml_tags&.each_with_index do |parcela_xml_tag,index|
      			valor_xml_tag = Nokogiri::XML("<vDup>").elements.first
      			valor_xml_tag&.content = parcelas[index]["valor"]
      			parcela_xml_tag&.add_child(valor_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:pag//xs:detPag" => lambda{|msg,xml|
      		troco_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:pag//xs:vTroco","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		detalhe_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:pag//xs:detPag","xs" => "http://www.portalfiscal.inf.br/nfe")
      		detalhe_xml_tags&.each{|detalhe_xml_tag| detalhe_xml_tag.remove }

      		detalhes = msg.dig("pagamento","detalhes")

      		detalhes&.each do |detalhe|
      			detalhe_xml_tag = Nokogiri::XML("<detPag>").elements.first
      			troco_xml_tag&.before(detalhe_xml_tag)
      		end

          if detalhes.nil?
            detalhe_xml_tag = Nokogiri::XML("<detPag>").elements.first
            troco_xml_tag&.before(detalhe_xml_tag)
          end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:pag//xs:detPag//xs:indPag" => lambda{|msg,xml|
      		detalhe_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:pag//xs:detPag","xs" => "http://www.portalfiscal.inf.br/nfe")

      		detalhes = msg.dig("pagamento","detalhes")

          if detalhes.nil?
            detalhe_xml_tag = detalhe_xml_tags.first
            forma_pagamento_xml_tag = Nokogiri::XML("<indPag>").elements.first
            forma_pagamento_xml_tag&.content = 0
            detalhe_xml_tag&.add_child(forma_pagamento_xml_tag)
          else
        		detalhe_xml_tags&.each_with_index do |detalhe_xml_tag,index|
        			forma_pagamento_xml_tag = Nokogiri::XML("<indPag>").elements.first
        			forma_pagamento_xml_tag&.content = detalhes[index]["forma_pagamento"].nil?
        			detalhe_xml_tag&.add_child(forma_pagamento_xml_tag)
        		end
          end

      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:pag//xs:detPag//xs:tPag" => lambda{|msg,xml|
      		detalhe_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:pag//xs:detPag","xs" => "http://www.portalfiscal.inf.br/nfe")

      		detalhes = msg.dig("pagamento","detalhes")

          if detalhes.nil?
            detalhe_xml_tag = detalhe_xml_tags.first
            meio_pagamento_xml_tag = Nokogiri::XML("<tPag>").elements.first
            meio_pagamento_xml_tag&.content = "01"
            detalhe_xml_tag&.add_child(meio_pagamento_xml_tag)            
          else
        		detalhe_xml_tags&.each_with_index do |detalhe_xml_tag,index|
        			meio_pagamento_xml_tag = Nokogiri::XML("<tPag>").elements.first
        			meio_pagamento_xml_tag&.content = "%02d" % detalhes[index]["meio_pagamento"].nil?
        			detalhe_xml_tag&.add_child(meio_pagamento_xml_tag)
        		end
          end

      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:pag//xs:detPag//xs:vPag" => lambda{|msg,xml|
          pag_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:pag","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		detalhe_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:pag//xs:detPag","xs" => "http://www.portalfiscal.inf.br/nfe")

      		detalhes = msg.dig("pagamento","detalhes")

          if !pag_xml_tag.nil?
            if detalhes.nil?
              total_nota_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:total//xs:ICMSTot//xs:vNF","xs" => "http://www.portalfiscal.inf.br/nfe").first
              detalhe_xml_tag = detalhe_xml_tags.first
              valor_xml_tag = Nokogiri::XML("<vPag>").elements.first
              valor_xml_tag&.content = total_nota_xml_tag.content
              detalhe_xml_tag&.add_child(valor_xml_tag)
            else
          		detalhe_xml_tags&.each_with_index do |detalhe_xml_tag,index|
          			valor_xml_tag = Nokogiri::XML("<vPag>").elements.first
          			valor_xml_tag&.content = detalhes[index]["valor"]
          			detalhe_xml_tag&.add_child(valor_xml_tag)
          		end
            end
          end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:pag//xs:detPag//xs:card//xs:tpIntegra" => lambda{|msg,xml|
      		cartao_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:pag//xs:detPag//xs:card","xs" => "http://www.portalfiscal.inf.br/nfe")

      		detalhes = msg.dig("pagamento","detalhes")

          if !detalhes.nil?
        		cartao_xml_tags&.each_with_index do |cartao_xml_tag,index|
        			tipo_integracao_xml_tag = Nokogiri::XML("<tpIntegra>").elements.first
        			tipo_integracao_xml_tag&.content = detalhes[index]["tipo_integracao"]
        			cartao_xml_tag&.add_child(tipo_integracao_xml_tag)
        		end
          end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:pag//xs:detPag//xs:card//xs:CNPJ" => lambda{|msg,xml|
      		cartao_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:pag//xs:detPag//xs:card","xs" => "http://www.portalfiscal.inf.br/nfe")

      		detalhes = msg.dig("pagamento","detalhes")

          if !detalhes.nil?
        		cartao_xml_tags&.each_with_index do |cartao_xml_tag,index|
        			cnpj_xml_tag = Nokogiri::XML("<CNPJ>").elements.first
        			cnpj_xml_tag&.content = detalhes[index]["cnpj"]
        			cartao_xml_tag&.add_child(cnpj_xml_tag)
        		end
          end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:pag//xs:detPag//xs:card//xs:tBand" => lambda{|msg,xml|
      		cartao_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:pag//xs:detPag//xs:card","xs" => "http://www.portalfiscal.inf.br/nfe")

      		detalhes = msg.dig("pagamento","detalhes")

          if !detalhes.nil?
        		cartao_xml_tags&.each_with_index do |cartao_xml_tag,index|
        			bandeira_xml_tag = Nokogiri::XML("<tBand>").elements.first
        			bandeira_xml_tag&.content = detalhes[index]["bandeira"]
        			cartao_xml_tag&.add_child(bandeira_xml_tag)
        		end
          end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:pag//xs:detPag//xs:card//xs:cAut" => lambda{|msg,xml|
      		cartao_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:pag//xs:detPag//xs:card","xs" => "http://www.portalfiscal.inf.br/nfe")

      		detalhes = msg.dig("pagamento","detalhes")

          if !detalhes.nil?
        		cartao_xml_tags&.each_with_index do |cartao_xml_tag,index|
        			numero_autorizacao_xml_tag = Nokogiri::XML("<cAut>").elements.first
        			numero_autorizacao_xml_tag&.content = detalhes[index]["numero_autorizacao"]
        			cartao_xml_tag&.add_child(numero_autorizacao_xml_tag)
        		end
          end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:pag//xs:vTroco" => lambda{|msg,xml|
      		troco_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:pag//xs:vTroco","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		troco_xml_tag&.content = "%.2f" % msg.dig("pagamento","troco").to_d.truncate(2)
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:infIntermed//xs:CNPJ" => lambda{|msg,xml|
      		cnpj_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:infIntermed//xs:CNPJ","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		cnpj_xml_tag&.content = msg.dig("informacoes_intermediario","cnpj")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:infIntermed//xs:idCadIntTtran" => lambda{|msg,xml|
      		identificador_intermediario_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:infIntermed//xs:idCadIntTtran","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		identificador_intermediario_xml_tag&.content = msg.dig("informacoes_intermediario","identificador_intermediario")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:infAdic//xs:infAdFisco" => lambda{|msg,xml|
      		fisco_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:infAdic//xs:infAdFisco","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		fisco_xml_tag&.content = msg.dig("informacoes_adicionais","fisco")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:infAdic//xs:infCpl" => lambda{|msg,xml|
      		contribuinte_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:infAdic//xs:infCpl","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		contribuinte_xml_tag&.content = msg.dig("informacoes_adicionais","contribuinte")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:infAdic//xs:obsCont" => lambda{|msg,xml|
      		infcpl_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:infAdic//xs:infCpl","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		campo_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:infAdic//xs:obsCont","xs" => "http://www.portalfiscal.inf.br/nfe")
      		campo_xml_tags&.each{|campo_xml_tag| campo_xml_tag.remove }

      		campos = msg.dig("informacoes_adicionais","campos_contribuinte")

      		campos&.each do |campo|
      			ultimo_campo_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:infAdic//xs:obsCont","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			campo_xml_tag = Nokogiri::XML("<obsCont>").elements.first
      			if !ultimo_campo_xml_tag.nil?
      				ultimo_campo_xml_tag&.after(campo_xml_tag)
      			else
      				infcpl_xml_tag&.add_child(campo_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:infAdic//xs:obsCont//@xCampo" => lambda{|msg,xml|
      		campo_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:infAdic//xs:obsCont","xs" => "http://www.portalfiscal.inf.br/nfe")

      		campos = msg.dig("informacoes_adicionais","campos_contribuinte")

      		campo_xml_tags&.each_with_index do |campo_xml_tag,index|
      			campo_xml_tag["xCampo"] = campos[index]["campo"]
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:infAdic//xs:obsCont//xs:xTexto" => lambda{|msg,xml|
      		campo_contribuinte_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:infAdic//xs:obsCont","xs" => "http://www.portalfiscal.inf.br/nfe")

      		campos = msg.dig("informacoes_adicionais","campos_contribuinte")

      		campo_contribuinte_xml_tags&.each_with_index do |campo_contribuinte_xml_tag,index|
      			texto_xml_tag = Nokogiri::XML("<xTexto>").elements.first
      			texto_xml_tag&.content = campos[index]["conteudo"]
      			campo_contribuinte_xml_tag&.add_child(texto_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:infAdic//xs:obsFisco" => lambda{|msg,xml|
      		infcpl_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:infAdic//xs:infCpl","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		ultimo_campo_contribuinte_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:infAdic//xs:obsCont","xs" => "http://www.portalfiscal.inf.br/nfe").last
      		campo_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:infAdic//xs:obsFisco","xs" => "http://www.portalfiscal.inf.br/nfe")
      		campo_xml_tags&.each{|campo_xml_tag| campo_xml_tag.remove }

      		campos = msg.dig("informacoes_adicionais","campos_fisco")

      		campos&.each do |campo|
      			ultimo_campo_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:infAdic//xs:obsFisco","xs" => "http://www.portalfiscal.inf.br/nfe").first
      			campo_xml_tag = Nokogiri::XML("<obsFisco>").elements.first
      			if !ultimo_campo_xml_tag.nil?
      				ultimo_campo_xml_tag&.after(campo_xml_tag)
      			else
      				if !ultimo_campo_contribuinte_xml_tag.nil?
      					ultimo_campo_contribuinte_xml_tag&.add_child(campo_xml_tag)
      				else
      					infcpl_xml_tag&.add_child(campo_xml_tag)
      				end
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:infAdic//xs:obsFisco//@xCampo" => lambda{|msg,xml|
      		campo_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:infAdic//xs:obsFisco","xs" => "http://www.portalfiscal.inf.br/nfe")

      		campos = msg.dig("informacoes_adicionais","campos_fisco")

      		campo_xml_tags&.each_with_index do |campo_xml_tag,index|
      			campo_xml_tag["xCampo"] = campos[index]["campo"]
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:infAdic//xs:obsFisco//xs:xTexto" => lambda{|msg,xml|
      		campos_fisco_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:infAdic//xs:obsFisco","xs" => "http://www.portalfiscal.inf.br/nfe")

      		campos = msg.dig("informacoes_adicionais","campos_fisco")

      		campos_fisco_xml_tags&.each_with_index do |campo_fisco_xml_tag,index|
      			texto_xml_tag = Nokogiri::XML("<xTexto>").elements.first
      			texto_xml_tag&.content = campos[index]["conteudo"]
      			campos_fisco_xml_tag&.add_child(texto_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:infAdic//xs:procRef" => lambda{|msg,xml|
      		infadic_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:infAdic","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		referencia_processo_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:infAdic//xs:procRef","xs" => "http://www.portalfiscal.inf.br/nfe")
      		referencia_processo_xml_tags&.each{|referencia_processo_xml_tag| referencia_processo_xml_tag.remove }

      		processos = msg.dig("informacoes_adicionais","processos")

      		processos&.each do |processo|
      			processo_xml_tag = Nokogiri::XML("<procRef>").elements.first
      			infadic_xml_tag&.add_child(campo_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:infAdic//xs:procRef//xs:nProc" => lambda{|msg,xml|
      		processos_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:infAdic//xs:procRef","xs" => "http://www.portalfiscal.inf.br/nfe")

      		processos = msg.dig("informacoes_adicionais","processos")

      		processos_xml_tags&.each_with_index do |processo_xml_tag,index|
      			numero_processo_xml_tag = Nokogiri::XML("<nProc>").elements.first
      			numero_processo_xml_tag&.content = processos[index]["numero_processo"]
      			processos_xml_tag&.add_child(numero_processo_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:infAdic//xs:procRef//xs:indProc" => lambda{|msg,xml|
      		processos_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:infAdic//xs:procRef","xs" => "http://www.portalfiscal.inf.br/nfe")

      		processos = msg.dig("informacoes_adicionais","processos")

      		processos_xml_tags&.each_with_index do |processo_xml_tag,index|
      			origem_processo_xml_tag = Nokogiri::XML("<indProc>").elements.first
      			origem_processo_xml_tag&.content = processos[index]["origem_processo"]
      			processos_xml_tag&.add_child(origem_processo_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:infAdic//xs:procRef//xs:tpAto" => lambda{|msg,xml|
      		processos_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:infAdic//xs:procRef","xs" => "http://www.portalfiscal.inf.br/nfe")

      		processos = msg.dig("informacoes_adicionais","processos")

      		processos_xml_tags&.each_with_index do |processo_xml_tag,index|
      			tipo_ato_xml_tag = Nokogiri::XML("<tpAto>").elements.first
      			tipo_ato_xml_tag&.content = processos[index]["tipo_ato"]
      			processos_xml_tag&.add_child(tipo_ato_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:exporta//xs:UFSaidaPais" => lambda{|msg,xml|
      		uf_saida_pais_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:exporta//xs:UFSaidaPais","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		uf_saida_pais_xml_tag&.content = msg.dig("exportacao","uf_saida_pais")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:exporta//xs:xLocExporta" => lambda{|msg,xml|
      		local_embarque_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:exporta//xs:xLocExporta","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		local_embarque_xml_tag&.content = msg.dig("exportacao","local_embarque")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:exporta//xs:xLocDespacho" => lambda{|msg,xml|
      		local_despacho_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:exporta//xs:xLocDespacho","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		local_despacho_xml_tag&.content = msg.dig("exportacao","local_despacho")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:compra//xs:xNEmp" => lambda{|msg,xml|
      		nota_empenho_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:compra//xs:xNEmp","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		nota_empenho_xml_tag&.content = msg.dig("compra","nota_empenho")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:compra//xs:xPed" => lambda{|msg,xml|
      		pedido_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:compra//xs:xPed","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		pedido_xml_tag&.content = msg.dig("compra","pedido")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:compra//xs:xCont" => lambda{|msg,xml|
      		contrato_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:compra//xs:xCont","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		contrato_xml_tag&.content = msg.dig("compra","contrato")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:cana//xs:safra" => lambda{|msg,xml|
      		safra_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:cana//xs:safra","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		safra_xml_tag&.content = msg.dig("cana","safra")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:cana//xs:ref" => lambda{|msg,xml|
      		mes_ano_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:cana//xs:ref","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		mes_ano_xml_tag&.content = msg.dig("cana","mes_ano")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:cana//xs:forDia" => lambda{|msg,xml|
      		mes_ano_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:cana//xs:ref","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		for_dia_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:cana//xs:forDia","xs" => "http://www.portalfiscal.inf.br/nfe")
      		for_dia_xml_tags&.each{|for_dia_xml_tag| for_dia_xml_tag.remove }

      		dias = msg.dig("cana","dias")

      		dias&.each do |dia|
      			ultimo_dia_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:cana//xs:forDia","xs" => "http://www.portalfiscal.inf.br/nfe").last
      			dia_xml_tag = Nokogiri::XML("<forDia>").elements.first
      			if !ultimo_dia_xml_tag.nil?
      				ultimo_dia_xml_tag&.after(dia_xml_tag)
      			else
      				mes_ano_xml_tag&.after(dia_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:cana//xs:forDia//@dia" => lambda{|msg,xml|
      		for_dia_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:cana//xs:forDia","xs" => "http://www.portalfiscal.inf.br/nfe")

      		dias = msg.dig("cana","dias")

      		for_dia_xml_tags&.each_with_index do |for_dia_xml_tag,index|
      			for_dia_xml_tag["dia"] = dias[index]["dia"]
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:cana//xs:forDia//xs:qtde" => lambda{|msg,xml|
      		for_dia_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:cana//xs:forDia","xs" => "http://www.portalfiscal.inf.br/nfe")

      		dias = msg.dig("cana","dias")

      		for_dia_xml_tags&.each_with_index do |for_dia_xml_tag,index|
      			quantidade_xml_tag = Nokogiri::XML("<qtde>").elements.first
      			quantidade_xml_tag&.content = dias[index]["quantidade"]
      			for_dia_xml_tag&.add_child(quantidade_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:cana//xs:qTotMes" => lambda{|msg,xml|
      		quantidade_total_mes_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:cana//xs:qTotMes","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		quantidade_total_mes_xml_tag&.content = msg.dig("cana","quantidade_total_mes")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:cana//xs:qTotAnt" => lambda{|msg,xml|
      		quantidade_total_anterior_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:cana//xs:qTotAnt","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		quantidade_total_anterior_xml_tag&.content = msg.dig("cana","quantidade_total_anterior")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:cana//xs:qTotGer" => lambda{|msg,xml|
      		quantidade_total_geral_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:cana//xs:qTotGer","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		quantidade_total_geral_xml_tag&.content = msg.dig("cana","quantidade_total_geral")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:cana//xs:deduc" => lambda{|msg,xml|
      		quantidade_total_geral_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:cana//xs:qTotGer","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		deducao_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:cana//xs:deduc","xs" => "http://www.portalfiscal.inf.br/nfe")
      		deducao_xml_tags&.each{|deducao_xml_tag| deducao_xml_tag.remove }

      		deducoes = msg.dig("cana","deducoes")

      		deducoes&.each do |deducao|
      			ultima_deducao_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:cana//xs:deduc","xs" => "http://www.portalfiscal.inf.br/nfe").last
      			deducao_xml_tag = Nokogiri::XML("<deduc>").elements.first
      			if !ultima_deducao_xml_tag.nil?
      				ultima_deducao_xml_tag&.after(deducao_xml_tag)
      			else
      				quantidade_total_geral_xml_tag&.after(deducao_xml_tag)
      			end
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:cana//xs:deduc//xs:xDed" => lambda{|msg,xml|
      		deducao_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:cana//xs:deduc","xs" => "http://www.portalfiscal.inf.br/nfe")

      		deducoes = msg.dig("cana","deducoes")

      		deducao_xml_tags&.each_with_index do |deducao_xml_tag,index|
      			descricao_xml_tag = Nokogiri::XML("<xDed>").elements.first
      			descricao_xml_tag&.content = deducoes[index]["descricao"]
      			deducao_xml_tag&.add_child(descricao_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:cana//xs:deduc//xs:vDed" => lambda{|msg,xml|
      		deducao_xml_tags = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:cana//xs:deduc","xs" => "http://www.portalfiscal.inf.br/nfe")

      		deducoes = msg.dig("cana","deducoes")

      		deducao_xml_tags&.each_with_index do |deducao_xml_tag,index|
      			valor_xml_tag = Nokogiri::XML("<vDed>").elements.first
      			valor_xml_tag&.content = deducoes[index]["valor"]
      			deducao_xml_tag&.add_child(valor_xml_tag)
      		end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:cana//xs:vFor" => lambda{|msg,xml|
      		valor_fornecimento_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:cana//xs:vFor","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		valor_fornecimento_xml_tag&.content = msg.dig("cana","valor_fornecimento")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:cana//xs:vTotDed" => lambda{|msg,xml|
      		valor_total_deducao_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:cana//xs:vTotDed","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		valor_total_deducao_xml_tag&.content = msg.dig("cana","valor_total_deducao")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:cana//xs:vLiqFor" => lambda{|msg,xml|
      		valor_liquido_fornecimentos_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:cana//xs:vLiqFor","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		valor_liquido_fornecimentos_xml_tag&.content = msg.dig("cana","valor_liquido_fornecimentos")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:infRespTec//xs:CNPJ" => lambda{|msg,xml|
      		cnpj_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:infRespTec//xs:CNPJ","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		cnpj_xml_tag&.content = msg.dig("responsavel_tecnico","cnpj")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:infRespTec//xs:xContato" => lambda{|msg,xml|
      		nome_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:infRespTec//xs:xContato","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		nome_xml_tag&.content = msg.dig("responsavel_tecnico","nome")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:infRespTec//xs:email" => lambda{|msg,xml|
      		email_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:infRespTec//xs:email","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		email_xml_tag&.content = msg.dig("responsavel_tecnico","email")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:infRespTec//xs:fone" => lambda{|msg,xml|
      		fone_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:infRespTec//xs:fone","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		fone_xml_tag&.content = msg.dig("responsavel_tecnico","fone")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:infRespTec//xs:idCSRT" => lambda{|msg,xml|
      		id_csrt_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:infRespTec//xs:idCSRT","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		id_csrt_xml_tag&.content = msg.dig("responsavel_tecnico","id_csrt")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFe//xs:infRespTec//xs:hashCSRT" => lambda{|msg,xml|
      		hash_csrt_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:infRespTec//xs:hashCSRT","xs" => "http://www.portalfiscal.inf.br/nfe").first
      		hash_csrt_xml_tag&.content = msg.dig("responsavel_tecnico","hash_csrt")
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFeSupl//xs:qrCode" => lambda{|msg,xml|
          qr_code_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFeSupl//xs:qrCode","xs" => "http://www.portalfiscal.inf.br/nfe").first
          ambiente_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:tpAmb","xs" => "http://www.portalfiscal.inf.br/nfe").first
          uf_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:enderEmit//xs:UF","xs" => "http://www.portalfiscal.inf.br/nfe").first
          id_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//@Id","xs" => "http://www.portalfiscal.inf.br/nfe").first

          if !qr_code_xml_tag.nil?
            qr_code_xml_tag.content = "<![CDATA[#{BRNF::WebServices::get_webservice(uf_xml_tag.content,"normal",ambiente_xml_tag.content,"qrcode")}?chNFe=#{id_xml_tag.content.gsub('NFe','')}]]>"
          end
      	},
      	"//xs:enviNFe//xs:NFe//xs:infNFeSupl//xs:urlChave" => lambda{|msg,xml|
          url_chave_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFeSupl//xs:urlChave","xs" => "http://www.portalfiscal.inf.br/nfe").first
          ambiente_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:tpAmb","xs" => "http://www.portalfiscal.inf.br/nfe").first
          uf_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:enderEmit//xs:UF","xs" => "http://www.portalfiscal.inf.br/nfe").first
          id_xml_tag = xml.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//@Id","xs" => "http://www.portalfiscal.inf.br/nfe").first
          
          if !url_chave_xml_tag.nil?
            chave = id_xml_tag.content.gsub('NFe','')
            versao = "2"
            ambiente = ambiente_xml_tag.content
            identificador_csc = msg["identificador_csc"]
            csc = msg["csc"]
            string_parametros = "#{chave}|#{versao}|#{ambiente}|#{identificador_csc.to_i}|#{csc}"
            codigo_hash = Digest::SHA1.hexdigest(string_parametros)
            url = "#{BRNF::WebServices::get_webservice(uf_xml_tag.content,"normal",ambiente_xml_tag.content,"url_chave")}"

            url_chave_xml_tag.content = "#{url}?p=#{string_parametros}|#{codigo_hash}"
          end
      	}
      }
    end
end