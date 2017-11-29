require 'json'
require 'open-uri'

def getMainLanguages()
	mainpage =  open('https://en.wikipedia.org/wiki/Main_Page')
	Nokogiri::HTML(mainpage).css('.interlanguage-link-target').map {|l| l.text}
end

def getChildCategories(parentCategory,catRegex)
  url="https://en.wikipedia.org/w/api.php?action=categorytree&category=#{parentCategory}&format=json"
  URI.parse(url).read.scan(catRegex).map {|e| e.gsub('Category:','')}
end

def getPages(category)
  url="https://en.wikipedia.org/w/api.php?action=query&format=json&list=categorymembers&cmtype=page&cmlimit=max&cmtitle=Category:"
  JSON.parse(URI.parse(url<<category).read)["query"]["categorymembers"]
end

def getPageContent(pageName)
  url="https://en.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&explaintext=&titles="
  JSON.parse(URI.parse(url<<pageName).read)['query']['pages'].map{|k,v| v}[0]['extract']
end
