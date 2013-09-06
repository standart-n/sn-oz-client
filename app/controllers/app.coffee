
# App

Backbone = 							require('Backbone')

LayoutBar = 						require('LayoutBar')
LayoutMain = 						require('LayoutMain')
LayoutFooter = 						require('LayoutFooter')

ContentSide =  						require('ContentSide')
ContentPrimary =					require('ContentPrimary')

Spoiler = 							require('Spoiler')
Links = 							require('Links')
Scroll = 							require('Scroll')
BootstrapButtons = 					require('BootstrapButtons')

module.exports = Backbone.Router.extend

	defUrl:							'main/text/main'

	routes:
		''							: 'routeText'
		':part/text/:page'			: 'routeText'

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
		this.scroll = 				new Scroll()
		this.links = 				new Links auto: off


	routeText: (part,page) ->
		if !part? or !page?
			part = 					'main'
			page = 					'main'

		href = 						"#{part}/text/#{page}"

		this.contentSide.switch(part,page)
		this.contentPrimary.switch(part,page)

		this.links.switch(href) if this.links?

		if href is 'main/text/main' and window.news?
			window.news.trigger 'feed'

		this.trigger 'switch', part, page


