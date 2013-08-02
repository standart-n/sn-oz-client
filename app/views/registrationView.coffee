
# Registration

Modal = 			require('Modal')
Registration = 		require('Registration')

module.exports = Modal.extend

	el:			'#registration'
	url:		'view/registration/registration.html'
	model:		new Registration()

	initialize: () ->
		this.render()
		this.$firstname = 		this.$el.find('.registration-firstname')
		this.$lastname = 		this.$el.find('.registration-lastname')
		this.$email = 			this.$el.find('.registration-email')
		this.$company = 		this.$el.find('.registration-company')

	data: () ->
		this.model.toJSON()

	submit: (e) ->
		e.preventDefault()
		_this = this
		this.model.save
			firstname: 		this.$firstname.val()
			lastname: 		this.$lastname.val()
			email:			this.$email.val()
			company:		this.$company.val()
		,
			url:			'http://dev.st-n.ru/registration'
			dataType:		'jsonp'
			success: 		(s) -> 
				alert JSON.stringify(_this.model.toJSON())
				# alert JSON.stringify(s)
				# alert s.id



