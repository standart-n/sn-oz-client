
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

		this.listenTo window.authorization.signinView.model, 'change', () =>
			this.eventSignin(window.authorization.signinView.model)


	eventSignin: (model) ->
		if model.get('success') is true
			this.signinToolbar.signin()

			this.self.set('email', 			model.get('email'))
			this.self.set('key', 			model.get('key'))

			# this.self.save()
			# ,
			# 	url:						window.sn.get('server').host + '/signin'
			# 	dataType:					'jsonp'
			# 	success: (s) => 
			# 		this.checking()


	routeLogout: () ->
			this.signinToolbar.logout()
			window.authorization.registrationView.model.clear()
			window.authorization.signinView.model.clear()
			this.self.clear()









