
Backbone = 									require('Backbone')
Feed = 										require('Feed')

module.exports = Backbone.Router.extend

	# routes:
	# 	'':									'routeRender'
	# 	'main/text/main':					'routeRender'


	initialize: () ->

		_.extend this, Backbone.Event

		this.feed = 						new Feed()

		this.on 'feed', () =>
			this.feed.render()

	# routeRender: () ->

	# 	alert 'render!'

	# 	this.feed.render()





