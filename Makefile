DATE=$(shell date +%I:%M%p)
CHECK=\033[32m✔\033[39m
HR=\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#


#
# BUILD DOCS
#

def: all

all: client finish

client: client-js css templates

templates:
	@jade --pretty ./jade/index.jade -O ./
	@jade --pretty ./jade/view/* -O ./view/
	@jade --pretty ./jade/layout/izhevsk/* -O ./layout/izhevsk
	@jade --pretty ./jade/layout/kirov/* -O ./layout/kirov
	@jade --pretty ./jade/layout/stavropol/* -O ./layout/stavropol
	@jade --pretty ./jade/layout/volgograd/* -O ./layout/volgograd

client-js:
	@coffee -cbjvp ./client/* > ./script/sn.js

css:
	@recess --compile ./less/silver/index.less > ./style/silver/theme.css

	@recess --compile ./less/classic/index.less > ./style/classic/theme.css
	@recess --compile ./less/classic/ie6.less > ./style/classic/ie6.css

	
finish:
	@echo "\nSuccessfully built at ${DATE}."





#
# RUN JSHINT & QUNIT TESTS IN PHANTOMJS
#
# @coffee -cbjvp ./client/oz*.coffee > ./public/js/client/oz.js

#.PHONY: docs watch gh-pages
