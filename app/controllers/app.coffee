
# App

Backbone = 			require('Backbone')

LayoutBar = 		require('LayoutBar')
LayoutMain = 		require('LayoutMain')
LayoutFooter = 		require('LayoutFooter')

ContentSide =  		require('ContentSide')
ContentPrimary =	require('ContentPrimary')

Signin =  			require('Signin')

Spoiler = 			require('Spoiler')
BootstrapButtons = 	require('BootstrapButtons')

module.exports = Backbone.Router.extend

	routes:
		':part/text/:page':		'text'

	initialize: () ->

		# layout
		this.layoutBar = 			new LayoutBar()
		this.layoutMain = 			new LayoutMain()
		this.layoutFooter = 		new LayoutFooter()

		# content
		this.contentSide = 			new ContentSide()
		this.contentPrimary = 		new ContentPrimary()

		# views
		this.signin = 				new Signin()

		# triggers
		new BootstrapButtons()
		new Spoiler()


	text: (part,page) ->

		this.contentSide.switch(part,page)
		this.contentPrimary.switch(part,page)