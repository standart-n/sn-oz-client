
Backbone = 								require('Backbone')

module.exports = Backbone.View.extend

	el: 								'#bar'

	initialize: () ->

		this.$signin = 					this.$el.find('.bar-signin')
		this.$logout = 					this.$el.find('.bar-logout')
		this.$registration = 			this.$el.find('.bar-registration')
		this.$remember = 				this.$el.find('.bar-remember')

		if window.user?
			
			window.user.on 'change:signin', () =>
				if window.user.get('signin') is true
					this.signin()
				else
					this.logout()


	signin: () ->
		this.$logout.shown()
		this.$signin.addClass('hide')
		this.$registration.addClass('hide')
		this.$remember.addClass('hide')

	logout: () ->
		this.$logout.addClass('hide')
		this.$signin.shown()
		this.$registration.shown()
		this.$remember.shown()



