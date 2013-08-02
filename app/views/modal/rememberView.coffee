
# Remember

Modal = require('Modal')

module.exports = Modal.extend

	el:			'#remember'
	url:		'view/remember/remember.html'

	initialize: () ->
		this.render()

	submit: (e) ->
		e.preventDefault()



		