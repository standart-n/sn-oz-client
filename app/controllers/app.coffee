
# App

Backbone = 							require('Backbone')

LayoutBar = 						require('LayoutBar')
LayoutMain = 						require('LayoutMain')
LayoutFooter = 						require('LayoutFooter')

ContentSide =  						require('ContentSide')
ContentPrimary =					require('ContentPrimary')

Spoiler = 							require('Spoiler')
BootstrapButtons = 					require('BootstrapButtons')

module.exports = Backbone.Router.extend

	routes:
		':part/text/:page':			'routeText'
		'signin':					'routeSignin'
		'registration':				'routeRegistration'
		'remember':					'routeRemember'

	initialize: () ->

		# layout
		this.layoutBar = 			new LayoutBar()
		this.layoutMain = 			new LayoutMain()
		this.layoutFooter = 		new LayoutFooter()

		# content
		this.contentSide = 			new ContentSide()
		this.contentPrimary = 		new ContentPrimary()

		# triggers
		new BootstrapButtons()
		new Spoiler()


	routeText: (part,page) ->
		this.contentSide.switch(part,page)
		this.contentPrimary.switch(part,page)