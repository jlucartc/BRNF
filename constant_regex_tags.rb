require_relative './xml/tag_map.rb'

constant_regex_tags = [
	{"id"=>"2", "name"=>"versao"},
	{"id"=>"11", "name"=>"versao"},
	{"id"=>"27", "name"=>"Algorithm"},
	{"id"=>"29", "name"=>"Algorithm"},
	{"id"=>"34", "name"=>"Algorithm"},
	{"id"=>"37", "name"=>"Algorithm"},
	{"id"=>"40", "name"=>"Algorithm"},
	{"id"=>"80", "name"=>"versao"},
	{"id"=>"96", "name"=>"Algorithm"},
	{"id"=>"98", "name"=>"Algorithm"},
	{"id"=>"103", "name"=>"Algorithm"},
	{"id"=>"106", "name"=>"Algorithm"},
	{"id"=>"109", "name"=>"Algorithm"},
	{"id"=>"124", "name"=>"descEvento"},
	{"id"=>"126", "name"=>"xCondUso"},
	{"id"=>"131", "name"=>"descEvento"},
	{"id"=>"148", "name"=>"descEvento"},
	{"id"=>"154", "name"=>"descEvento"},
	{"id"=>"162", "name"=>"xCondUso"},
	{"id"=>"164", "name"=>"versao"},
	{"id"=>"991", "name"=>"hashCSRT"},
	{"id"=>"998", "name"=>"Algorithm"},
	{"id"=>"1000", "name"=>"Algorithm"},
	{"id"=>"1005", "name"=>"Algorithm"},
	{"id"=>"1008", "name"=>"Algorithm"},
	{"id"=>"1011", "name"=>"Algorithm"}
]

constant_regex_tags.each do |item|
	fill_with_regex(xml,item["id"],map)
end

def fill_with_regex(xml,tag_id,map)
	tag = map.get_tag(tag_id)
	tag = xml.xpath(tag["xpath"],"xs" => tag["xpath_namespace"]).first
	tag.content = Regexp.new(regex).random_example.gsub("\u0000",'')
end