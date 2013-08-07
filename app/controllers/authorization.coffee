
require('cookie')

Backbone = 									require('Backbone')

SigninView =  								require('SigninView')
RegistrationView =  						require('RegistrationView')
RememberView =  							require('RememberView')
SigninToolbar =  							require('SigninToolbar')

Self = 		 								require('Self')

module.exports = Backbone.Router.extend

	routes:
		'signin':							'routeSignin'
		'registration':						'routeRegistration'
		'remember':							'routeRemember'
		'logout':							'routeLogout'

	initialize: () ->

		window.self = 						new Self()

		_.extend this, Backbone.Events

		# views
		this.signinView = 					new SigninView()
		this.registrationView = 			new RegistrationView()
		this.rememberView = 				new RememberView()
		this.signinToolbar = 				new SigninToolbar()
		
		this.listenTo this.registrationView.model, 'change:success', () =>
			this.eventSignin(this.registrationView.model)

		this.listenTo this.signinView.model, 'change:success', () =>
			this.eventSignin(this.signinView.model)

		this.checkCookie()

	routeSignin: () ->
		this.signinView.open()

	routeRegistration: () ->
		this.registrationView.open()

	routeRemember: () ->
		this.rememberView.open()

	routeLogout: () ->
			this.signinToolbar.logout()
			this.registrationView.model.clear()
			this.signinView.model.clear()
			window.self.clear()
			window.self.set('signin',false)
			$.removeCookie 'id'
			$.removeCookie 'key'


	checking: () ->
		# this.profile ?= 					new Profile()

		if window.self.get('email')? and window.self.get('firstname')?
			this.signinToolbar.signin()

			$.cookie 'id', 		window.self.get('id'), 			expires: 365
			$.cookie 'key', 	window.self.get('key'), 		expires: 365

			window.self.set('signin',true)

	fetch: () ->
		window.self.fetch
			url: window.sn.get('server').host + '/signin/' + window.self.get('id') + '/' + window.self.get('key')
			dataType: 'jsonp'
			success: (s) => 
				this.checking()


	eventSignin: (model) ->

		if model.get('success') is true

			window.self.set 'id', 			model.get('id')
			window.self.set 'key', 			model.get('key')
			this.fetch()


	checkCookie: () ->
		if $.cookie('id')? and $.cookie('key')?

			window.self.set 'id', 			$.cookie 'id'
			window.self.set 'key', 			$.cookie 'key'
			this.fetch()

