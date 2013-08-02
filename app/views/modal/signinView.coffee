
# Signin

Modal = require('Modal')

module.exports = Modal.extend

	el:			'#signin'
	url:		'view/signin/signin.html'

	initialize: () ->
		this.render()

	submit: (e) ->
		e.preventDefault()



		