
# Registration

Modal = 			require('Modal')
Registration = 		require('Registration')

module.exports = Modal.extend

	el:			'#registration'
	url:		'view/registration/registration.html'
	model:		new Registration()

	initialize: () ->
		this.render()

	submit: (e) ->
		e.preventDefault()
		this.model.save {},
			url:			'//dev.st-n.ru'
			error:			() -> alert 'error'
			dataType:		'jsonp'



		