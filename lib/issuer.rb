require_relative 'webservices.rb'
require 'savon'
require 'openssl'

module BRNF

	class Issuer

		DEFAULT_UF = "RS"
		DEFAULT_TYPE = "normal"
		UF = {
			"11": "RO",
			"12": "AC",
			"13": "AM",
			"14": "RR",
			"15": "PA",
			"16": "AP",
			"17": "TO",
			"21": "MA",
			"22": "PI",
			"23": "CE",
			"24": "RN",
			"25": "PB",
			"26": "PE",
			"27": "AL",
			"28": "SE",
			"29": "BA",
			"31": "MG",
			"32": "ES",
			"33": "RJ",
			"35": "SP",
			"41": "PR",
			"42": "SC",
			"43": "RS",
			"50": "MS",
			"51": "MT",
			"52": "GO",
			"53": "DF"
		}

		def initialize(password, pfx_file_path: nil, cert_file_path: nil, key_file_path: nil, ca_file_path: nil)
			pfx_not_present = pfx_file_path.nil?
			auth_files_not_present = cert_file_path.nil? or key_file_path.nil? or ca_file_path.nil?

			raise "Error: certificate is missing." if pfx_not_present and auth_files_not_present
			raise "Error: invalid password" if !password.is_a?(String) and !password.is_a?(Integer)

			@password = password
			@cert_file = File.open(cert_file_path,'r') if !cert_file_path.nil?
			@key_file = File.open(key_file_path,'r') if !key_file_path.nil?
			@ca_file = File.open(key_file_path,'r') if !ca_file_path.nil?
			@webservices = BRNF::WebServices::WEB_SERVICES

			generate_auth_files(pfx_file_path,@password) if !pfx_file_path.nil?

			validate_cert_file
		end

		def autorizar_nota(message)
			send_message(__method__,message)
		end

		def consultar_status_servico(message)
			send_message(__method__,message)
		end

		def consultar_retorno_autorizacao(message)
			send_message(__method__,message)
		end

		def inutilizar_numeracao(message)
			send_message(__method__,message)
		end

		def nfe_distribuicao_dfe(message)
			send_message(__method__,message)
		end

		def consultar_protocolo(message)
			send_message(__method__,message)
		end

		def criar_carta_correcao(message)
			send_message(__method__,message)
		end

		def confirmacao_da_operacao(message)
			send_message(__method__,message)
		end

		def ciencia_da_operacao(message)
			send_message(__method__,message)
		end

		def desconhecimento_da_operacao(message)
			send_message(__method__,message)
		end

		def operacao_nao_realizada(message)
			send_message(__method__,message)
		end

		def emissao_contingencia(message)
			send_message(__method__,message)
		end

		def cancelar_nota_substituicao(message)
			send_message(__method__,message)
		end

		def cancelar_nota(message)
			send_message(__method__,message)
		end

		def prorrogar_prazo_1(message)
			send_message(__method__,message)
		end

		def prorrogar_prazo_2(message)
			send_message(__method__,message)
		end

		def ator_interessado(message)
			send_message(__method__,message)
		end

		def cancelamento_prazo_1(message)
			send_message(__method__,message)
		end
		
		def cancelamento_prazo_2(message)
			send_message(__method__,message)
		end

		def consultar_cadastro(message)
			send_message(__method__,message)
		end

		private

		def send_message(service,message)
			case service
			when :autorizar_nota
 				service_name = "NFeAutorizacao" 				
 				type = DEFAULT_TYPE
 				uf = message.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:emit//xs:enderEmit//xs:UF","xs" => "http://www.portalfiscal.inf.br/nfe").first.content
 				environment = message.xpath("//xs:enviNFe//xs:NFe//xs:infNFe//xs:ide//xs:tpAmb","xs" => "http://www.portalfiscal.inf.br/nfe").first.content
 				service_url = BRNF::WebServices::get_webservice(uf,type,environment,service_name)[:url]
 				call_service(service_url,message)
			when :consultar_status_servico
 				service_name = "NfeStatusServico" 				
 				type = DEFAULT_TYPE
 				uf = UF[message.xpath("//xs:consStatServ//xs:cUF","xs" => "http://www.portalfiscal.inf.br/nfe").first.content]
 				environment = message.xpath("//xs:consStatServ//xs:tpAmb","xs" => "http://www.portalfiscal.inf.br/nfe").first.content
 				service_url = BRNF::WebServices::get_webservice(uf,type,environment,service_name)[:url]
 				call_service(service_url,message)
			when :consultar_retorno_autorizacao
 				service_name = "NFeRetAutorizacao"
 				type = DEFAULT_TYPE
				uf = message.xpath("//xs:consReciNFe//xs:nRec","xs" => "http://www.portalfiscal.inf.br/nfe").first.content
 				environment = message.xpath("//xs:consReciNFe//xs:tpAmb","xs" => "http://www.portalfiscal.inf.br/nfe").first.content
 				service_url = BRNF::WebServices::get_webservice(uf,type,environment,service_name)[:url]
 				call_service(service_url,message)
			when :inutilizar_numeracao
				service_name = "NfeInutilizacao"
 				type = DEFAULT_TYPE
 				uf = UF[message.xpath("//xs:inutNFe//xs:infInut//xs:cUF","xs" => "http://www.portalfiscal.inf.br/nfe").first.content]
 				environment = message.xpath("//xs:inutNFe//xs:infInut//xs:tpAmb","xs" => "http://www.portalfiscal.inf.br/nfe").first.content
 				service_url = BRNF::WebServices::get_webservice(uf,type,environment,service_name)[:url]
 				call_service(service_url,message)
			when :nfe_distribuicao_dfe
				service_name = "RecepcaoEvento"
 				type = DEFAULT_TYPE
 				uf = UF[message.xpath("//xs:distDFeInt//xs:cUFAutor","xs" => "http://www.portalfiscal.inf.br/nfe").first.content]
 				environment = message.xpath("//xs:distDFeInt//xs:tpAmb","xs" => "http://www.portalfiscal.inf.br/nfe").first.content
 				service_url = BRNF::WebServices::get_webservice(uf,type,environment,service_name)[:url]
 				call_service(service_url,message)
			when :consultar_protocolo
 				service_name = "NfeConsultaProtocolo"
 				type = DEFAULT_TYPE
 				uf = UF[message.xpath("//xs:consSitNFe//xs:chNFe","xs" => "http://www.portalfiscal.inf.br/nfe").first.content[0..1]]
 				environment = message.xpath("//xs:consSitNFe//xs:tpAmb","xs" => "http://www.portalfiscal.inf.br/nfe").first.content
 				service_url = BRNF::WebServices::get_webservice(uf,type,environment,service_name)[:url]
 				call_service(service_url,message)
			when :criar_carta_correcao
				service_name = "RecepcaoEvento"
 				type = DEFAULT_TYPE
 				uf = UF[message.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:cOrgao","xs" => "http://www.portalfiscal.inf.br/nfe").first.content]
 				environment = message.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:tpAmb","xs" => "http://www.portalfiscal.inf.br/nfe").first.content
 				service_url = BRNF::WebServices::get_webservice(uf,type,environment,service_name)[:url]
 				call_service(service_url,message)
			when :confirmacao_da_operacao
				service_name = "RecepcaoEvento"
 				type = DEFAULT_TYPE
 				uf = UF[message.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:cOrgao","xs" => "http://www.portalfiscal.inf.br/nfe").first.content]
 				environment = message.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:tpAmb","xs" => "http://www.portalfiscal.inf.br/nfe").first.content
 				service_url = BRNF::WebServices::get_webservice(uf,type,environment,service_name)[:url]
 				call_service(service_url,message)
			when :ciencia_da_operacao
				service_name = "RecepcaoEvento"				
 				type = DEFAULT_TYPE
 				uf = UF[message.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:cOrgao","xs" => "http://www.portalfiscal.inf.br/nfe").first.content]
 				environment = message.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:tpAmb","xs" => "http://www.portalfiscal.inf.br/nfe").first.content
 				service_url = BRNF::WebServices::get_webservice(uf,type,environment,service_name)[:url]
 				call_service(service_url,message)
			when :desconhecimento_da_operacao
				service_name = "RecepcaoEvento"				
 				type = DEFAULT_TYPE
 				uf = UF[ message.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:cOrgao","xs" => "http://www.portalfiscal.inf.br/nfe").first.content]
 				environment = message.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:tpAmb","xs" => "http://www.portalfiscal.inf.br/nfe").first.content
 				service_url = BRNF::WebServices::get_webservice(uf,type,environment,service_name)[:url]
 				call_service(service_url,message)
			when :operacao_nao_realizada
				service_name = "RecepcaoEvento"				
 				type = DEFAULT_TYPE
 				uf = UF[message.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:cOrgao","xs" => "http://www.portalfiscal.inf.br/nfe").first.content]
 				environment = message.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:tpAmb","xs" => "http://www.portalfiscal.inf.br/nfe").first.content
 				service_url = BRNF::WebServices::get_webservice(uf,type,environment,service_name)[:url]
 				call_service(service_url,message)
			when :emissao_contingencia
				service_name = "RecepcaoEvento"				
 				type = "contingencia"
 				uf = UF[message.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:cOrgao","xs" => "http://www.portalfiscal.inf.br/nfe").first.content]
 				environment = message.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:tpAmb","xs" => "http://www.portalfiscal.inf.br/nfe").first.content
 				service_url = BRNF::WebServices::get_webservice(uf,type,environment,service_name)[:url]
 				call_service(service_url,message)
			when :cancelar_nota_substituicao
				service_name = "RecepcaoEvento"				
 				type = DEFAULT_TYPE
 				uf = UF[message.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:cOrgao","xs" => "http://www.portalfiscal.inf.br/nfe").first.content]
 				environment = message.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:tpAmb","xs" => "http://www.portalfiscal.inf.br/nfe").first.content
 				service_url = BRNF::WebServices::get_webservice(uf,type,environment,service_name)[:url]
 				call_service(service_url,message)
			when :cancelar_nota
				service_name = "RecepcaoEvento"				
 				type = DEFAULT_TYPE
 				uf = UF[message.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:cOrgao","xs" => "http://www.portalfiscal.inf.br/nfe").first.content]
 				environment = message.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:tpAmb","xs" => "http://www.portalfiscal.inf.br/nfe").first.content
 				service_url = BRNF::WebServices::get_webservice(uf,type,environment,service_name)[:url]
 				call_service(service_url,message)
			when :prorrogar_prazo_1
				service_name = "RecepcaoEvento"				
 				type = DEFAULT_TYPE
 				uf = UF[message.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:cOrgao","xs" => "http://www.portalfiscal.inf.br/nfe").first.content]
 				environment = message.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:tpAmb","xs" => "http://www.portalfiscal.inf.br/nfe").first.content
 				service_url = BRNF::WebServices::get_webservice(uf,type,environment,service_name)[:url]
 				call_service(service_url,message)
			when :prorrogar_prazo_2
				service_name = "RecepcaoEvento"				
 				type = DEFAULT_TYPE
 				uf = UF[message.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:cOrgao","xs" => "http://www.portalfiscal.inf.br/nfe").first.content]
 				environment = message.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:tpAmb","xs" => "http://www.portalfiscal.inf.br/nfe").first.content
 				service_url = BRNF::WebServices::get_webservice(uf,type,environment,service_name)[:url]
 				call_service(service_url,message)
			when :ator_interessado
				service_name = "RecepcaoEvento"				
 				type = DEFAULT_TYPE
 				uf = UF[message.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:cOrgao","xs" => "http://www.portalfiscal.inf.br/nfe").first.content]
 				environment = message.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:tpAmb","xs" => "http://www.portalfiscal.inf.br/nfe").first.content
 				service_url = BRNF::WebServices::get_webservice(uf,type,environment,service_name)[:url]
 				call_service(service_url,message)
			when :cancelamento_prazo_1
				service_name = "RecepcaoEvento"				
 				type = DEFAULT_TYPE
 				uf = UF[message.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:cOrgao","xs" => "http://www.portalfiscal.inf.br/nfe").first.content]
 				environment = message.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:tpAmb","xs" => "http://www.portalfiscal.inf.br/nfe").first.content
 				service_url = BRNF::WebServices::get_webservice(uf,type,environment,service_name)[:url]
 				call_service(service_url,message)
			when :cancelamento_prazo_2
				service_name = "RecepcaoEvento"				
 				type = DEFAULT_TYPE
 				uf = UF[message.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:cOrgao","xs" => "http://www.portalfiscal.inf.br/nfe").first.content]
 				environment = message.xpath("//xs:envEvento//xs:evento//xs:infEvento//xs:tpAmb","xs" => "http://www.portalfiscal.inf.br/nfe").first.content
 				service_url = BRNF::WebServices::get_webservice(uf,type,environment,service_name)[:url]
 				call_service(service_url,message)
			when :consultar_cadastro
 				service_name = "NfeConsultaCadastro" 				
 				type = DEFAULT_TYPE
 				uf = message.xpath("//xs:ConsCad//xs:infCons//xs:UF","xs" => "http://www.portalfiscal.inf.br/nfe")
 				environment = "1"
 				service_url = BRNF::WebServices::get_webservice(uf,type,environment,service_name)[:url]
 				call_service(service_url,message)
			end
		end

		def generate_auth_files(pfx_file_path,password)
			begin
				pfx_file = OpenSSL::PKCS12.new(File.open(pfx_file_path,'r').read,password)

				@cert_file = Tempfile.new
				@key_file = Tempfile.new
				@ca_file = Tempfile.new

				@cert_file.write(pfx_file.certificate.to_s)
				@key_file.write(pfx_file.key.to_s)
				@ca_file.write(pfx_file.ca_certs.to_s)

				@cert_file.rewind
				@key_file.rewind
				@ca_file.rewind

				validate_cert_file
			rescue OpenSSL::PKCS12::PKCS12Error
				raise "Error: wrong password or invalid certificate file."
			end
		end

		def validate_cert_file
			cert = OpenSSL::X509::Certificate.new(@cert_file.read)
			@cert_file.rewind

			not_before = cert.not_before
			not_after = cert.not_after

			raise "Error: expired certificate. Valid until #{not_after}" if not_after < Time.now
			raise "Error: certificate not valid yet. Valid after #{not_before}" if not_before > Time.now
		end

		def create_client(wsdl)
		    Savon.client(
		    	log: true,
		      wsdl: wsdl,
		      ssl_cert_key_file: @key_file,
		      ssl_cert_key_password: @password,
		      ssl_ca_cert_file: @ca_file,
		      ssl_cert_file: @cert_file,
		      ssl_verify_mode: :none
		    )
		end

		def call_service(service_url,message)
			client = create_client(service_url)
			client.call(client.operations.first,message: message.root.to_xml)
		end
	end
end