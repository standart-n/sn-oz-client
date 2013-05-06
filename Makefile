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

client-js:
	@coffee -cbjvp ./client/* > ./script/sn.js

css:

	@recess --compile ./less/reload/bootstrap/bootstrap.less > ./style/reload/bootstrap.css
	@recess --compile ./less/reload/bootstrap-ie6/bootstrap-ie6.less > ./style/reload/bootstrap-ie6.css

	
finish:
	@echo "\nSuccessfully built at ${DATE}."


bs-js:
	@cat ./js/bootstrap/bootstrap-*.js  > ./script/bootstrap.js
	@uglifyjs ./script/bootstrap.js -nc > ./script/bootstrap.min.js


#
# RUN JSHINT & QUNIT TESTS IN PHANTOMJS
#
# @coffee -cbjvp ./client/oz*.coffee > ./public/js/client/oz.js
# @recess --compile ./less/silver/index.less > ./style/silver/theme.css

#.PHONY: docs watch gh-pages
