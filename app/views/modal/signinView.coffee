
# Signin

Modal = require('Modal')

module.exports = Modal.extend

	el:			'#signin'
	url:		'view/signin/signin.html'

	initialize: () ->
		this.render()

		this.$modal = 					this.$el.find('.modal')
		this.$close = 					this.$el.find('.modal-header').find('.close')

	submit: (e) ->
		e.preventDefault()



		