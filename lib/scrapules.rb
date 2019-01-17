require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'

PAGE_URL = 'http://www2.assemblee-nationale.fr/deputes/liste/alphabetique'
PAGE_URL2 = 'http://www2.assemblee-nationale.fr'

def get_scrapules_urls
  
	page = Nokogiri::HTML(open(PAGE_URL))
	scrapules = []
	camino_scrapules = page.xpath('//*[@id="deputes-list"]/div/ul/li/a')
	camino_scrapules.each do |scrapule|
	scrapules << scrapule['href']
	end
	
	return scrapules
end 

def get_scrapules_infos(urls)
	
	scrapules_mails = []
	scrapules_names = []

	urls.each do |url|
		page = Nokogiri::HTML(open(PAGE_URL2+url))
		name_path = page.xpath('/html/body/div[3]/div/div/div/section[1]/div/article/div[2]/h1')
		email_path = page.xpath('//a[@class="email"]')
		b = email_path[0]['href']
		b[0..6] = ''
		scrapules_mails << b
		scrapules_names << name_path.text
 end

 split_names = []
 scrapules_names.each do |name|
  if name.start_with? "M."
    name[0..2] = ""
  split_names << name.split
  else
  name[0..3] = ""
  split_names << name.split
  end
end

 fusion = []
 
 split_names.each_with_index do |name, i|  

  fusion[i] = {"Prenom" => name[0], "Nom" => name[1..100].join(' '), "mail" => scrapules_mails[i]       }

end

puts fusion.inspect

end

get_scrapules_infos(get_scrapules_urls)