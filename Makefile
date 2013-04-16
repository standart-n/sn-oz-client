TPL=smarty
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
	@jade --pretty ./jade/users/* -O ./view/

client-js:
	@coffee -cbjvp ./client/* > ./script/sn.js

css:
	@recess --compile ./less/silver/index.less > ./style/silver/theme.css

	
finish:
	@echo "\nSuccessfully built at ${DATE}."





#
# RUN JSHINT & QUNIT TESTS IN PHANTOMJS
#
# @coffee -cbjvp ./client/oz*.coffee > ./public/js/client/oz.js

#.PHONY: docs watch gh-pages
