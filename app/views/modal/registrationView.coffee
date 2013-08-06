
Modal = 								require('Modal')
Registration = 							require('Registration')
RegistrationAlertSuccess = 				require('RegistrationAlertSuccess')
RegistrationAlertError = 				require('RegistrationAlertError')
RegistrationTextSuccess = 				require('RegistrationTextSuccess')

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

		this.$modal = 					this.$el.find('.modal')
		this.$close = 					this.$el.find('.modal-header').find('.close')
		this.$form = 					this.$el.find('.registration-form')

		this.model.set region: 			window.sn.get('region')

		this.alertSuccess = 			new RegistrationAlertSuccess()
		this.alertError = 				new RegistrationAlertError()
		this.textSuccess = 				new RegistrationTextSuccess()

	afterShow: () ->
		this.alertSuccess.hide()
		this.alertError.hide()
		this.textSuccess.hide()
		this.$form.show()

	data: () ->
		this.model.toJSON()

	checking: () ->
		if this.model.get('success')
			this.$form.hide()
			this.alertSuccess.show()
			this.alertError.hide()
			this.textSuccess.show
				email:					this.model.get('email')
				password:				this.model.get('password')

			# window.app.user.trigger 'signin', 'after registration'

		else
			this.alertError.show this.model.get('err')
			this.alertSuccess.hide()
			this.textSuccess.hide()
			this.$form.show()

	submit: (e) ->
		e.preventDefault()
		this.model.save
			firstname: 					this.$firstname.val()
			lastname: 					this.$lastname.val()
			email:						this.$email.val()
			company:					this.$company.val()
		,
			url:						window.sn.get('server').host + '/registration'
			dataType:					'jsonp'
			success: (s) => 
				this.checking()
				# alert JSON.stringify(s)
				# alert s.id



