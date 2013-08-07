
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

		window.user = 						new Self()

		_.extend this, Backbone.Events

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
			this.signinView.model.reset()
			this.registrationView.model.reset()
			window.user.reset()
			$.removeCookie 'id'
			$.removeCookie 'key'

			window.location.href = '#main/text/main'


	checking: () ->
		# this.profile ?= 					new Profile()

		if window.user.get('email')? isnt '' and window.user.get('firstname')? isnt ''
			this.signinToolbar.signin()

			$.cookie 'id', 		window.user.get('id'), 			expires: 365
			$.cookie 'key', 	window.user.get('key'), 		expires: 365

			window.user.set('signin',true)

	fetch: () ->
		window.user.fetch
			url: window.sn.get('server').host + '/signin/' + window.user.get('id') + '/' + window.user.get('key')
			dataType: 'jsonp'
			success: (s) => 
				this.checking()


	eventSignin: (model) ->

		if model.get('success') is true

			window.user.set 'id', 			model.get('id')
			window.user.set 'key', 			model.get('key')
			this.fetch()


	checkCookie: () ->
		if $.cookie('id')? and $.cookie('key')?

			window.user.set 'id', 			$.cookie 'id'
			window.user.set 'key', 			$.cookie 'key'
			this.fetch()

