require 'json'
require 'nokogiri'
require 'open-uri'

def getMainLanguages()
	mainpage =  open('https://en.wikipedia.org/wiki/Main_Page')
	Nokogiri::HTML(mainpage).css('.interlanguage-link-target').map {|l| [l.text,l.attribute('href').value]}.to_h
end

def getChildCategories(baseUrl,parentCategory,catRegex)
  url=baseUrl+"/w/api.php?action=categorytree&category=#{parentCategory}&format=json"
  URI.parse(URI.escape(url)).read.scan(catRegex).map {|e| e.gsub('Category:','')}
end

def getPages(baseUrl,category)
  url=baseUrl+"/w/api.php?action=query&format=json&list=categorymembers&cmtype=page&cmlimit=max&cmtitle=Category:"
  JSON.parse(URI.parse(URI.escape(url<<category)).read)["query"]["categorymembers"]
end

def getPageContent(baseUrl,pageName)
  url=baseUrl+"/w/api.php?format=json&action=query&prop=extracts&explaintext=&titles="
  JSON.parse(URI.parse(URI.escape(url<<pageName)).read)['query']['pages'].map{|k,v| v}[0]['extract']
end
