
Backbone = 									require('Backbone')

SigninView =  								require('SigninView')
RegistrationView =  						require('RegistrationView')
RememberView =  							require('RememberView')

module.exports = Backbone.Router.extend

	routes:
		'signin':							'routeSignin'
		'registration':						'routeRegistration'
		'remember':							'routeRemember'

	initialize: () ->

		_.extend this, Backbone.Events

		# views
		this.signinView = 					new SigninView()
		this.registrationView = 			new RegistrationView()
		this.rememberView = 				new RememberView()
		

	routeSignin: () ->
		this.signinView.open()

	routeRegistration: () ->
		this.registrationView.open()

	routeRemember: () ->
		this.rememberView.open()


