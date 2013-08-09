
require('cookie')

Backbone = 									require('Backbone')

SigninView =  								require('SigninView')
RegistrationView =  						require('RegistrationView')
RememberView =  							require('RememberView')
SigninToolbar =  							require('SigninToolbar')

module.exports = Backbone.Router.extend

	routes:
		'signin':							'routeSignin'
		'registration':						'routeRegistration'
		'remember':							'routeRemember'
		'logout':							'routeLogout'

	initialize: () ->

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

		if window.user?
			window.user.reset()
			window.user.removeCookie()

		window.location.href = '#main/text/main'


	checking: () ->
		if window.user?
			if window.user.get('id') isnt '' and window.user.get('email') isnt '' and window.user.get('firstname') isnt ''

				window.user.set('signin',true)
				window.user.updateCookie()

	fetch: (id, key) ->
		if id? and key?
			window.user.fetch
				url: window.sn.get('server').host + '/signin/' + id + '/' + key
				dataType: 'jsonp'
				success: (s) => 
					this.checking()


	eventSignin: (model) ->

		if model.get('success') is true
			this.fetch(model.get('id'), model.get('key'))


	checkCookie: () ->
		if $.cookie('id')? and $.cookie('key')?
			this.fetch($.cookie('id'), $.cookie('key'))

