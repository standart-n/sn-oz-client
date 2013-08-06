
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

	checking: () ->
		alert JSON.stringify(this.self)



	eventSignin: (model) ->
		if model.get('success') is true
			this.signinToolbar.signin()

			this.self.set('id', 			model.get('id'))
			this.self.set('key', 			model.get('key'))

			this.self.fetch
				url:						window.sn.get('server').host + '/signin/' + this.self.get('id') + '/' + this.self.get('key')
				dataType:					'jsonp'
				success: (s) => 
					this.checking()


	routeLogout: () ->
			this.signinToolbar.logout()
			window.authorization.registrationView.model.clear()
			window.authorization.signinView.model.clear()
			this.self.clear()









