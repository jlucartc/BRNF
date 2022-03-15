# br_nf

## Features
- Issues brazilian invoice(in progress)
- generates test invoice with random data(Ready! See an example of valid invoice xml at [this file](https://github.com/jlucartc/gem_nf/blob/master/nota_exemplo.xml))

## Future improvements
- Random invoice data still doesn't have any configuration options, like selecting certain groups or filling in part of the xml with your own data. This will be included in the future.

## How to use?

### Generating random data

To generate random data, just call the method that builds the XML for the desired service.
e.g.: To issue a new invoice, your should call the method `autorizar_nota`:

```ruby
	require_relative './lib/brnf.rb'

	# If you want a brand new invoice, that's the method call:
	generator = BRNF::Mock::Generator.new
	xml = generator.autorizar_nota()

	# If you wanna validate your own invoice xml, use this:
	generator = BRNF::Mock::Generator.new
	xml = generator.autorizar_nota(documento: File.open("your_invoice.xml"){ |f| Nokogiri::XML(f) })
```