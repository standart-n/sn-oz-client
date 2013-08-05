
Backbone = 								require('Backbone')

module.exports = Backbone.View.extend

	el: 								'#bar'

	initialize: () ->

		this.$signin = 					this.$el.find('.bar-signin')
		this.$logout = 					this.$el.find('.bar-logout')
		this.$registration = 			this.$el.find('.bar-registration')
		this.$remember = 				this.$el.find('.bar-remember')

	signin: () ->
		this.$logout.show()
		this.$signin.hide()
		this.$registration.hide()
		this.$remember.hide()

	logout: () ->
		this.$logout.hide()
		this.$signin.show()
		this.$registration.show()
		this.$remember.show()



