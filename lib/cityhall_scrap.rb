#######################################################################################################################
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^   REQUIERED   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^#

require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'

#######################################################################################################################
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^   METHODS   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^#


PAGE_URL = 'http://annuaire-des-mairies.com/val-d-oise.html'
PAGE_URL2 = 'http://annuaire-des-mairies.com/'

#On définit la fonction pour récupérer les URLs des différentes villes.
def get_townhall_urls
  
   page = Nokogiri::HTML(open(PAGE_URL))
   cities = []
   path_city = page.css('a.lientxt')  # On récupère les données brutes
   path_city.each do |city|
    a = city['href']                  # On récupère le href qui link vers les pages des communes
    a[0] = ''
    cities << a
    end

    return cities
end

#On définit la fonction pour récupérer les infos.
def get_townhall_email(urls)

  #On définit les arrays principaux.
  city_mail = []     # Pour les mails
  city_name = []     # Pour les noms
  fusion = []        # Array final qui contiendra les hashs

  #On récupère les infos.
  urls.each do |url|
    
    page = Nokogiri::HTML(open(PAGE_URL2+url))   # On combine l'url de base et les url de chaque commune.
    emails_path = page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]')
    name_path = page.css('small')
    city_name_temp = name_path.text    # On récupère les noms.
    city_name_temp[0..10] = ''         # On enlève le "Commune de".
    city_mail << emails_path.text      
    city_name << city_name_temp
  end

  city_name.each_with_index do |name, i|   # On fusionne tous les éléments.
    
    # On crée une variable pour indiquer les e-mails non renseignés.
    empty_mail = "Adresse e-mail non renseignée. Ces bouseux n'ont sûrement pas Internet de toute façon!"
    
    city_mail[i].length < 1 ? city_mail[i] = empty_mail : nil # Condition pour emails non renseignés
    fusion[i] = { name => city_mail[i] }
  end
  
  puts fusion
  return fusion.inspect

end

#######################################################################################################################
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^   INITIALIZE   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^#

                                     get_townhall_email(get_townhall_urls)

#######################################################################################################################