
Backbone = 									require('Backbone')

# models
Self = 		 								require('Self')

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
		this.listenTo window.authorization.registrationView.model, 'change', () =>
			this.eventSignin(window.authorization.registrationView.model)


	eventSignin: (model) ->
		if model.get('success') is true
			this.signinToolbar.signin()

			this.self.set('email', 			model.get('email'))
			this.self.set('key', 			model.get('password_hash'))

			this.self.set('firstname', 		model.get('firstname'))
			this.self.set('lastname', 		model.get('lastname'))
			this.self.set('company', 		model.get('company'))

			this.self.set('signin', 		true)

	eventLogout: () ->
			this.signinToolbar.logout()
			
			this.self.clear()









