#!/usr/bin/env ruby
require 'tty/prompt'
require 'tty/pager'
require './scraperUtils'
require 'pastel'

userPath=[['Reference','Culture','Geography','Health','History','Mathematics','Nature','People','Philosophy','Religion','Society','Technology']]
catRegex=%r{Category:[a-zA-Z_()]+}


prompt = TTY::Prompt.new
pager = TTY::Pager.new
pastel = Pastel.new
cursor = TTY::Cursor

system('clear')
choice = prompt.select("Choose :",  userPath.last(),per_page:12)
cursor.forward()

loop do
  if choice != "GO BACK"
    action = prompt.select("Choose action :",["Display subcategories","Display articles in this category"])
    system('clear')
    if action == "Display articles in this category"
      pagesList = getPages(choice)
      if pagesList.empty? then puts pastel.red("There are not any pages in this category"); next end
      pageSelect = prompt.select("Chose :",pagesList.map{|x| x['title']},per_page:12)
      pager.page(getPageContent(pageSelect))
    end
    unless action == "Display articles in this category"
      userPath.push( getChildCategories(choice,catRegex).unshift('GO BACK'))
    end
  else
    userPath.pop()
  end
  choice = prompt.select("Chose :", userPath.last(),per_page:12)

end

