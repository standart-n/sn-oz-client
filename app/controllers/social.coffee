
require('cookie')

Backbone = 									require('Backbone')

# models
Self = 		 								require('Self')
Profile = 		 							require('Profile')

# views
SigninToolbar =  							require('SigninToolbar')

module.exports = Backbone.Router.extend

	routes:
		'logout':							'routeLogout'

	initialize: () ->

		_.extend this, Backbone.Events

		this.self = 						new Self()
		this.signinToolbar = 				new SigninToolbar()

		#events
		this.listenTo window.authorization.registrationView.model, 'change:success', () =>
			this.eventSignin(window.authorization.registrationView.model)

		this.listenTo window.authorization.signinView.model, 'change:success', () =>
			this.eventSignin(window.authorization.signinView.model)

		this.checkCookie()

	checking: () ->
		this.profile ?= 					new Profile()

		if this.self.get('email')? and this.self.get('firstname')?
			this.signinToolbar.signin()

			$.cookie 'id', 		this.self.get('id'), 		expires: 365
			$.cookie 'key', 	this.self.get('key'), 		expires: 365

			this.self.set('signin',true)

	fetch: () ->
		this.self.fetch
			url:						window.sn.get('server').host + '/signin/' + this.self.get('id') + '/' + this.self.get('key')
			dataType:					'jsonp'
			success: (s) => 
				this.checking()

	eventSignin: (model) ->

		if model.get('success') is true

			this.self.set 'id', 			model.get('id')
			this.self.set 'key', 			model.get('key')
			this.fetch()

	checkCookie: () ->
		if $.cookie('id')? and $.cookie('key')?

			this.self.set 'id', 			$.cookie 'id'
			this.self.set 'key', 			$.cookie 'key'
			this.fetch()


	routeLogout: () ->
			this.signinToolbar.logout()
			window.authorization.registrationView.model.clear()
			window.authorization.signinView.model.clear()
			this.self.clear()
			this.self.set('signin',false)
			$.removeCookie 'id'
			$.removeCookie 'key'

