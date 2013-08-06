
Backbone = 								require('Backbone')

module.exports = Backbone.View.extend

	el: 								'#bar'

	initialize: () ->

		this.$signin = 					this.$el.find('.bar-signin')
		this.$logout = 					this.$el.find('.bar-logout')
		this.$registration = 			this.$el.find('.bar-registration')
		this.$remember = 				this.$el.find('.bar-remember')

	signin: () ->
		this.$logout.removeClass('hide')
		this.$signin.addClass('hide')
		this.$registration.addClass('hide')
		this.$remember.addClass('hide')

	logout: () ->
		this.$logout.addClass('hide')
		this.$signin.removeClass('hide')
		this.$registration.removeClass('hide')
		this.$remember.removeClass('hide')



