DATE = $(shell date +%I:%M%p)


install: 
	@mkdir -p ./script/
	@mkdir -p ./style/
	@mkdir -p ./view/
	@npm install
	@cp -R ./install/* ./
	@./node_modules/.bin/grunt all


build:
	@./node_modules/.bin/grunt


bootstrap:
	@./node_modules/.bin/grunt bootstrap



server:
	@./node_modules/.bin/grunt server
	@node ./server.js
	

finish:
	@echo "\nSuccessfully built at ${DATE}."


.PHONY: install server bootstrap
