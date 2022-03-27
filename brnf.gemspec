Gem::Specification.new do |s|
  s.name        = 'brnf'
  s.version     = '0.0.0'
  s.summary     = "Issues brazilian invoice"
  s.description = "Issues brazilian invoice and generates invoice XML with random data. It can also generate XML for other SEFAZ services."
  s.authors     = ["jlucartc"]
  s.email       = 'jlucartc@gmail.com'
  s.files       = ["lib/brnf.rb","lib/builder.rb","lib/generator.rb","lib/issuer.rb","lib/parser.rb","lib/signer.rb","lib/tag_lambdas.rb","lib/tag_map.rb","lib/tags.csv","lib/webservices.rb","lib/xml.rb"]
  s.homepage    = "https://github.com/jlucartc/BRNF"
  s.add_dependency 'openssl', '2.2.0'
  s.add_dependency 'nokogiri', '1.13.3'
  s.add_dependency 'savon', '2.12.1'
  s.add_dependency 'regexp-examples', '1.5.1'
  s.add_dependency 'digest', '3.1.0'
  s.add_dependency 'base64', '0.1.0'
  s.add_dependency 'csv', '3.1.9'
  s.add_dependency 'json', '2.5.1'
  s.add_dependency 'bigdecimal', '3.0.0'
end