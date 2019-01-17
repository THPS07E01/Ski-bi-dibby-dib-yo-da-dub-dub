require 'nokogiri'
require 'open-uri'
require 'pry'


def crypto_scrapper

  page = Nokogiri::HTML(open('https://coinmarketcap.com/all/views/all/'))
  pathvalues = page.css('a.price')                           # Récupère la classe css qui correspond aux valeurs.
  pathcrypto_names = page.css('td.text-left.col-symbol')     # Récupère la classe css qui correspond aux noms abbrégés des cryptos.

  values = []                                                # On défini les deux arrays vides qui nous serviront plus tard.
  crypto_names = []

  passvalues.each do |value|                                 # On prend les valeurs une par une , on les converti en texte, enlève le signe "$" et converti en float et met dans l'array values
    values << value.text.delete('$').to_f
  end

  passcrypto_names.each do |crypto|                          # On prend les noms un par un, on les converti en texte et on les met dans l'array crypto_names
    crypto_names << crypto.text
  end

  fusion = []                                                  # On crée un array vide qui contiendra nos hashs     
  crypto_names.each_with_index do |name, i|                  # On fait fusier les deux arrays names et values dans main.
    fusion[i] = { name => values[i] }
  end

  puts fusion.inspect

end