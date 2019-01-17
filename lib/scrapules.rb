#######################################################################################################################
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^   REQUIERED   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^#

require 'rubygems'  
require 'nokogiri'
require 'open-uri'
require 'pry'

#######################################################################################################################
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^   METHODS   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^#

#On définit les pages dont on va se servir plus tard.
PAGE_URL = 'http://www2.assemblee-nationale.fr/deputes/liste/alphabetique'
PAGE_URL2 = 'http://www2.assemblee-nationale.fr'


#On définit la fonction pour récupérer les urls.
def get_scrapules_urls
  
	page = Nokogiri::HTML(open(PAGE_URL))
	scrapules = []
	camino_scrapules = page.xpath('//*[@id="deputes-list"]/div/ul/li/a')
	camino_scrapules.each do |scrapule|
	scrapules << scrapule['href']
	end
	
	return scrapules
end 

#On définit la fonction pour récupérer les infos.
def get_scrapules_infos(urls)
	
	#On définit les arrays principaux.
	scrapules_mails = []   # Pour récupérer les mails
	scrapules_names = []   # Pour récupérer les noms et prénoms
	split_names = []       # Pour récupérer les noms et prenoms séparés
	fusion = []            # Array final qui contiendra les hashs

	#On récupère les infos.
	urls.each do |url|
		page = Nokogiri::HTML(open(PAGE_URL2+url))
		name_path = page.xpath('/html/body/div[3]/div/div/div/section[1]/div/article/div[2]/h1')
		email_path = page.xpath('//a[@class="email"]')
		b = email_path[0]['href']        # On récuppère le href
		b[0..6] = ''                     # On enlève le "mailto:"
		scrapules_mails << b
		scrapules_names << name_path.text
 end

 #On fusionne les infos pour obtenir le format demandé.
 # D'abord en séparant les noms de famille et prenoms dans des array distincts.
 scrapules_names.each do |name|

	(name.start_with? "M.") ? name[0..2] = "" : name[0..3] = ""  # Petite contition pour enlever les M. et Mme.
	split_names << name.split
 end

 # Puis en fusionnant tous les élements dans des hashs inclus dans un grand array.
 split_names.each_with_index do |name, i|  

  fusion[i] = {"Prenom" => name[0], "Nom" => name[1..100].join(' '), "mail" => scrapules_mails[i] }

 end

 puts fusion.inspect

end
######
#######################################################################################################################
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^   INITIALIZE   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^#

                                   get_scrapules_infos(get_scrapules_urls)

#######################################################################################################################