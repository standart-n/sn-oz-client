
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
			url:			'http://dev.st-n.ru/registration'
			dataType:		'jsonp'
			success: 		(s) -> 
				alert JSON.stringify(s)
				alert s.id

