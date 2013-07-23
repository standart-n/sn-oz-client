
# Text

Backbone = require('backbone')

module.exports = Backbone.Router.extend
	
	routes:
		'main/text/apteki': 		'apteki'

	initialize: () ->
		alert 'router'

	apteki: () ->
		alert 'apteki'


