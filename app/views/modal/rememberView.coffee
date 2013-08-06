
# Remember

Modal = require('Modal')

module.exports = Modal.extend

	el:			'#remember'
	url:		'view/remember/remember.html'

	initialize: () ->
		this.render()

		this.$modal = 					this.$el.find('.modal')
		this.$close = 					this.$el.find('.modal-header').find('.close')

	submit: (e) ->
		e.preventDefault()



		