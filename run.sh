#!/usr/bin/env bash

if ! gem list tty-prompt | grep tty-prompt
then
	gem install tty-prompt
fi

if ! gem list tty-pager | grep tty-pager 
then
	gem install tty-pager
fi

if ! gem list pastel | grep pastel 
then
	gem install pastel
fi

if ! gem list  nokogiri | grep nokogiri
then
	gem install nokogiri
fi

echo -e "All required gems are already installed.\nLaunching program."
sleep 5
./scraper.rb
