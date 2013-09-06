
Backbone = 									require('Backbone')
Feed = 										require('Feed')

module.exports = Backbone.Router.extend



	initialize: () ->

		_.extend this, Backbone.Event

		this.feed = 						new Feed()

		this.on 'feed', () =>
			this.feed.render()

