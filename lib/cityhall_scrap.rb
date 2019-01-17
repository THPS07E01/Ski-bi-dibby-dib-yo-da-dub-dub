require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'

PAGE_URL = 'http://annuaire-des-mairies.com/val-d-oise.html'
PAGE_URL2 = 'http://annuaire-des-mairies.com/'

def get_townhall_urls
  
   page = Nokogiri::HTML(open(PAGE_URL))
   cities = []
   path_city = page.css('a.lientxt')
   path_city.each do |city|
    a = city['href']
    a[0] = ''
    cities << a
    end

    return cities
end

def get_townhall_email(urls)
  city_mail = []
  city_name = []
  fusion = []
  urls.each do |url|
    
    page = Nokogiri::HTML(open(PAGE_URL2+url))
    emails_path = page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]')
    name_path = page.css('small')
    city_name_temp = name_path.text
    city_name_temp[0..10] = ''
    city_mail << emails_path.text
    city_name << city_name_temp
  end

  city_name.each_with_index do |name, i|   
    
    if city_mail[i].length < 1
       city_mail[i] = "Adresse e-mail non renseignée. Ces bouseux n'ont sûrement pas Internet de toute façon!"
       fusion[i] = { name => city_mail[i] }
    else 
       fusion[i] = { name => city_mail[i] }
    end
  
  end
  
  puts fusion

end

get_townhall_email(get_townhall_urls)
