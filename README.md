# BRNF

## Features
- Issues brazilian invoice(ready, but still lacking testing)
- generates test invoice with random data(Ready! See an example of valid invoice xml at [this file](https://github.com/jlucartc/gem_nf/blob/master/nota_exemplo.xml))

## Future improvements
- Random invoice data still doesn't have any configuration options, like selecting certain groups or filling in part of the xml with your own data. This will be included in the future.

- It would be nice to allow using a hash with default values. That would give more freedom to the users, since their business requirements wouldn't be affected by the default values specified by the gem code, and it would be safer in case of misuse of the api (e.g. forgeting to fill in a field when sending a message).

## How to use?

### Generating random data

To generate random data, just call the method that builds the XML for the desired service.
e.g.: To issue a new invoice, your should call the method `autorizar_nota`:

```ruby
require_relative 'lib/brnf'

# If you want a random invoice, that's the method call:
generator = BRNF::XML.new
xml = generator.autorizar_nota()
```

### Using a service

Follow these steps if you want to use any of the services available at SEFAZ:

```ruby
require_relative 'lib/brnf'

# If you wanna create an invoice with your data, use this:
generator = BRNF::XML.new
xml = generator.autorizar_nota(message: JSON.parse(File.open("my_json_message.json","r").read))

# Object responsible for choosing the right webservice for each service, creating and
# sending a SOAP message with the xml generated from the provided data.
issuer = BRNF::Issuer.new(certificate_password,pfx_file_path: pfx_certificate_file_path)

# Sends the message with the invoice data and receives a response
# containing fields confirming the invoice acceptance or denial.
response = issuer.autorizar_nota(xml)
```

If you dont have a .pfx file and instead have .pem files, you can create an `Issuer` instance like this:

```ruby
issuer = BRNF::Issuer.new(certificate_password,key_file_path: 'my_key.pem', cert_file_path: 'my_certificate.pem', ca_file_path: 'my_ca.pem')
```

You may find more information about the message format accepted by each service at the next section.

## Message structure

A rough description for each message can be found at [this folder](https://github.com/jlucartc/gem_nf/blob/master/messages/api)). There you'll find an OpenAPI description for each service, but keep in mind that these descriptions are not strict enough. To find more strict documentation, see [this folder](https://github.com/jlucartc/gem_nf/blob/master/schemas/producao)), and look for the files below:


- [enviNFe_v4.00.xsd](https://github.com/jlucartc/gem_nf/blob/master/schemas/producao/arquivos/enviNFe_v4.00.xsd) for description of `BRNF::XML.new.autorizar_nota()`
- [inutNFe_v4.00.xsd](https://github.com/jlucartc/gem_nf/blob/master/schemas/producao/arquivos/inutNFe_v4.00.xsd) for description of `BRNF::XML.new.inutilizar_numeracao()`
- [envCCe_v1.00.xsd](https://github.com/jlucartc/gem_nf/blob/master/schemas/producao/arquivos/envCCe_v1.00.xsd) for description of `BRNF::XML.new.criar_carta_correcao()`
- [envEventoCancNFe_v1.00.xsd](https://github.com/jlucartc/gem_nf/blob/master/schemas/producao/arquivos/envEventoCancNFe_v1.00.xsd) for description of `BRNF::XML.new.cancelar_nota()`
- [consStatServ_v4.00.xsd](https://github.com/jlucartc/gem_nf/blob/master/schemas/producao/arquivos/consStatServ_v4.00.xsd) for description of `BRNF::XML.new.consultar_status_servico()`
- [envEventoCancSubst_v1.00.xsd](https://github.com/jlucartc/gem_nf/blob/master/schemas/producao/arquivos/envEventoCancSubst_v1.00.xsd) for description of `BRNF::XML.new.cancelar_nota_substituicao()`
- [envRemIndus_v1.00.xsd](https://github.com/jlucartc/gem_nf/blob/master/schemas/producao/arquivos/envRemIndus_v1.00.xsd) for description of `BRNF::XML.new.prorrogar_prazo_1()`
- [envRemIndus_v1.00.xsd](https://github.com/jlucartc/gem_nf/blob/master/schemas/producao/arquivos/envRemIndus_v1.00.xsd) for description of `BRNF::XML.new.prorrogar_prazo_2()`
- [envEventoAtorInteressado_v1.00.xsd](https://github.com/jlucartc/gem_nf/blob/master/schemas/producao/arquivos/envEventoAtorInteressado_v1.00.xsd) for description of `BRNF::XML.new.ator_interessado()`
- [envConfRecebto_v1.00.xsd](https://github.com/jlucartc/gem_nf/blob/master/schemas/producao/arquivos/envConfRecebto_v1.00.xsd) for description of `BRNF::XML.new.confirmacao_da_operacao()`
- [envConfRecebto_v1.00.xsd](https://github.com/jlucartc/gem_nf/blob/master/schemas/producao/arquivos/envConfRecebto_v1.00.xsd) for description of `BRNF::XML.new.ciencia_da_operacao()`
- [envConfRecebto_v1.00.xsd](https://github.com/jlucartc/gem_nf/blob/master/schemas/producao/arquivos/envConfRecebto_v1.00.xsd) for description of `BRNF::XML.new.desconhecimento_da_operacao()`
- [envConfRecebto_v1.00.xsd](https://github.com/jlucartc/gem_nf/blob/master/schemas/producao/arquivos/envConfRecebto_v1.00.xsd) for description of `BRNF::XML.new.operacao_nao_realizada()`
- [envEPEC_v1.00.xsd](https://github.com/jlucartc/gem_nf/blob/master/schemas/producao/arquivos/envEPEC_v1.00.xsd) for description of `BRNF::XML.new.emissao_contingencia()`
- [envRemIndus_v1.00.xsd](https://github.com/jlucartc/gem_nf/blob/master/schemas/producao/arquivos/envRemIndus_v1.00.xsd) for description of `BRNF::XML.new.cancelamento_prazo_1()`
- [envRemIndus_v1.00.xsd](https://github.com/jlucartc/gem_nf/blob/master/schemas/producao/arquivos/envRemIndus_v1.00.xsd) for description of `BRNF::XML.new.cancelamento_prazo_2()`
- [consReciNFe_v4.00.xsd](https://github.com/jlucartc/gem_nf/blob/master/schemas/producao/arquivos/consReciNFe_v4.00.xsd) for description of `BRNF::XML.new.consultar_retorno_autorizacao()`
- [consSitNFe_v4.00.xsd](https://github.com/jlucartc/gem_nf/blob/master/schemas/producao/arquivos/consSitNFe_v4.00.xsd) for description of `BRNF::XML.new.consultar_protocolo()`
- [distDFeInt_v1.01.xsd](https://github.com/jlucartc/gem_nf/blob/master/schemas/producao/arquivos/distDFeInt_v1.01.xsd) for description of `BRNF::XML.new.nfe_distribuicao_dfe()`
- [consCad_v2.00.xsd](https://github.com/jlucartc/gem_nf/blob/master/schemas/producao/arquivos/consCad_v2.00.xsd) for description of `BRNF::XML.new.consultar_cadastro()`

The list above was the reference used to create the XML's, and they should provide a better comprehension of the OpenAPI messages when needed. It should be noted that the messages' purpose is only to convey the information needed to fill the xml tags, but they won't be validated at all. The only thing being validated here is the XML(and only at the the test cases or if you explicitly do so by comparing the xml against it's schema).

## Errors and Bugs

If you are having problems with requests denied by SEFAZ, due to malformed XML or broken rules, please open an issue and provide a repeatable case where the error can be reproduced, including the exact message sent, and the results(XML, SEFAZ response), preferably with fake data. Altough I won't be able to reproduce the case fully everytime, since doing so would demand a certificate issued for each state, maybe someone else can see the issue and shed some light over why it's it happening, in the worst case.

Currently, there are some services whose WSDL can't be accessed. Some of these services are not maintained by the UFs, and others can't be accessed due to some misconfiguration at the SOAP creation or at the HTTP request.
The table below presents which services are unavailable at the moment, and at which UF:

| Services               | Environment | Type         | UF's                                                                             |
|------------------------|-------------|--------------|----------------------------------------------------------------------------------|
| "NFeAutorizacao"       | producao    | normal       |                                                                                  |
| "NfeStatusServico"     | producao    | normal       |                                                                                  |
| "NFeRetAutorizacao"    | producao    | normal       |                                                                                  |
| "NfeInutilizacao"      | producao    | normal       |                                                                                  |
| "RecepcaoEvento"       | producao    | normal       |                                                                                  |
| "NfeConsultaProtocolo" | producao    | normal       |                                                                                  |
| "RecepcaoEvento"       | producao    | normal       |                                                                                  |
| "NfeConsultaCadastro"  | producao    | normal       | PE                                                                               |
| "NFeAutorizacao"       | homologacao | normal       |                                                                                  |
| "NfeStatusServico"     | homologacao | normal       |                                                                                  |
| "NFeRetAutorizacao"    | homologacao | normal       |                                                                                  |
| "NfeInutilizacao"      | homologacao | normal       |                                                                                  |
| "RecepcaoEvento"       | homologacao | normal       |                                                                                  |
| "NfeConsultaProtocolo" | homologacao | normal       |                                                                                  |
| "RecepcaoEvento"       | homologacao | normal       |                                                                                  |
| "NfeConsultaCadastro"  | homologacao | normal       | AM,GO,PE,MA                                                                      |
| "NFeAutorizacao"       | producao    | contingência | RS                                                                               |
| "NfeStatusServico"     | producao    | contingência |                                                                                  |
| "NFeRetAutorizacao"    | producao    | contingência | RS                                                                               |
| "NfeInutilizacao"      | producao    | contingência | AM,BA,CE,GO,MS,MT,PE,PR,MA                                                       |
| "RecepcaoEvento"       | producao    | contingência |                                                                                  |
| "NfeConsultaProtocolo" | producao    | contingência |                                                                                  |
| "RecepcaoEvento"       | producao    | contingência |                                                                                  |
| "NfeConsultaCadastro"  | producao    | contingência | AM,BA,CE,GO,MG,MS,MT,PE,PR,RS,SP,MA,AC,AL,AP,DF,ES,PA,PB,PI,RJ,RN,RO,RR,SC,SE,TO |
| "NFeAutorizacao"       | homologacao | contingência |                                                                                  |
| "NfeStatusServico"     | homologacao | contingência |                                                                                  |
| "NFeRetAutorizacao"    | homologacao | contingência | RS                                                                               |
| "NfeInutilizacao"      | homologacao | contingência | AM,BA,GO,MS,MT,PE,PR,MA                                                          |
| "RecepcaoEvento"       | homologacao | contingência |                                                                                  |
| "NfeConsultaProtocolo" | homologacao | contingência |                                                                                  |
| "RecepcaoEvento"       | homologacao | contingência |                                                                                  |
| "NfeConsultaCadastro"  | homologacao | contingência | AM,BA,CE,GO,MG,MS,MT,PE,PR,RS,SP,MA,AC,AL,AP,DF,ES,PA,PB,PI,RJ,RN,RO,RR,SC,SE,TO |
