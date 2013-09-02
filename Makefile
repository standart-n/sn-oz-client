DATE = $(shell date +%I:%M%p)


install: 
	@mkdir -p ./script/
	@mkdir -p ./style/
	@mkdir -p ./view/
	@npm install
	@./node_modules/.bin/bower install --force --allow-root
	@./node_modules/.bin/grunt al


build:
	@./node_modules/.bin/grunt


bootstrap:
	@./node_modules/.bin/grunt bootstrap



test:
	@./node_modules/.bin/grunt test
	

finish:
	@echo "\nSuccessfully built at ${DATE}."


.PHONY: test bootstrap
