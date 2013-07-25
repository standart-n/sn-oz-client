
# ContentPrimary

Content = require('Content')

module.exports = Content.extend

	el: 	'#primary'
	file:	'main.html'

	initialize: () ->
		this.render()

	switch: (part,page) ->

		this.file = "#{page}.html"
		this.render()
			
