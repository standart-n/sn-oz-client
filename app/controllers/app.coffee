
# App

Backbone = 							require('Backbone')

LayoutBar = 						require('LayoutBar')
LayoutMain = 						require('LayoutMain')
LayoutFooter = 						require('LayoutFooter')

ContentSide =  						require('ContentSide')
ContentPrimary =					require('ContentPrimary')

Spoiler = 							require('Spoiler')
Links = 							require('Links')
BootstrapButtons = 					require('BootstrapButtons')

module.exports = Backbone.Router.extend

	routes:
		':part/text/:page':			'routeText'

	initialize: () ->

		_.extend this, Backbone.Event

		# layout
		this.layoutBar = 			new LayoutBar()
		this.layoutMain = 			new LayoutMain()
		this.layoutFooter = 		new LayoutFooter()

		# content
		this.contentSide = 			new ContentSide()
		this.contentPrimary = 		new ContentPrimary()

		# triggers
		this.bootstrapButtons = 	new BootstrapButtons()
		this.spoiler = 				new Spoiler()
		this.links = 				new Links auto: off


	routeText: (part,page) ->
		this.contentSide.switch(part,page)
		this.contentPrimary.switch(part,page)
		this.links.switch() if this.links?

		this.trigger 'switch', part, page


