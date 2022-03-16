require_relative './lib/brnf.rb'

api = BRNF::XML.new

api.autorizar_nota(mensagem: JSON.parse(File.open('mensagens/api/message_example.json','r').read))