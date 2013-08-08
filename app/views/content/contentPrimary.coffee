
# ContentPrimary

Content = require('Content')

module.exports = Content.extend

	el: 	'#primary'
	file:	'main.html'
	page: 	'main'

	initialize: () ->
		this.render()

	switch: (part,page) ->
		this.page = page
		this.file = "#{page}.html"
		this.render()
			
