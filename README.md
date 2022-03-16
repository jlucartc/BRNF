# br_nf

## Features
- Issues brazilian invoice(in progress)
- generates test invoice with random data(Ready! See an example of valid invoice xml at [this file](https://github.com/jlucartc/gem_nf/blob/master/nota_exemplo.xml))

## Future improvements
- Random invoice data still doesn't have any configuration options, like selecting certain groups or filling in part of the xml with your own data. This will be included in the future.

- It would be nice to allow using a hash with default values. That would give more freedom to the users, since their business requirements wouldn't be affected by the default values specified by the gem code, and it would be safer in case of misuse of the api (e.g. forgeting to fill in a field when sending a message).

## How to use?

### Generating random data

To generate random data, just call the method that builds the XML for the desired service.
e.g.: To issue a new invoice, your should call the method `autorizar_nota`:

```ruby
	require_relative './lib/brnf.rb'

	# If you want a brand new invoice, that's the method call:
	generator = BRNF::XML.new
	xml = generator.autorizar_nota()

	# If you wanna validate your own invoice xml, use this:
	generator = BRNF::XML.new
	xml = generator.autorizar_nota(documento: File.open("your_invoice.xml"){ |f| Nokogiri::XML(f) })
```