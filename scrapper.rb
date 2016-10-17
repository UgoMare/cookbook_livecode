require 'nokogiri'
require 'open-uri'

class Scrapper

  def search(ingredient)
    result_array = []
    url = "http://www.jamieoliver.com/search/?s=#{ingredient}"
    doc = Nokogiri::HTML(open(url), nil, 'utf-8')
    doc.search('div.recipe').each do |node|
      name = node.css('h2').text
      url = node.css('a').attr('href').text
      recipe = Recipe.new(name, nil)
      recipe.url = url
      result_array << recipe
    end
    return result_array
  end

  def get_description(url)
    doc = Nokogiri::HTML(open(url), nil, 'utf-8')
    return doc.search('.recipe-intro').text.strip
  end



end
