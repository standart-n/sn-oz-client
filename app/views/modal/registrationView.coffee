
# Registration

Modal = 								require('Modal')
Registration = 							require('Registration')
RegistrationAlertSuccess = 				require('RegistrationAlertSuccess')
RegistrationAlertError = 				require('RegistrationAlertError')

module.exports = Modal.extend

	el:									'#registration'
	url:								'view/registration/registration.html'
	model:								new Registration()

	initialize: () ->
		this.render()
		this.$firstname = 				this.$el.find('.registration-firstname')
		this.$lastname = 				this.$el.find('.registration-lastname')
		this.$email = 					this.$el.find('.registration-email')
		this.$company = 				this.$el.find('.registration-company')

		this.alertSuccess = 			new RegistrationAlertSuccess()
		this.alertError = 				new RegistrationAlertError()

	data: () ->
		this.model.toJSON()

	checking: () ->
		if this.model.get('success')
			this.alertSuccess.show()
			this.alertError.hide()
		else
			this.alertError.show this.model.get('err')
			this.alertSuccess.hide()

	submit: (e) ->
		e.preventDefault()
		this.model.save
			firstname: 					this.$firstname.val()
			lastname: 					this.$lastname.val()
			email:						this.$email.val()
			company:					this.$company.val()
		,
			url:						'http://dev.st-n.ru/registration'
			dataType:					'jsonp'
			success: (s) => 
				this.checking()
				# alert JSON.stringify(s)
				# alert s.id



