
Modal = 								require('Modal')
Registration = 							require('Registration')
RegistrationTextSuccess = 				require('RegistrationTextSuccess')

module.exports = Modal.extend

	el:									'#registration'
	url:								'view/registration/registration.html'

	initialize: () ->
		this.model = 					new Registration()
		this.render()
		this.$firstname = 				this.$el.find('.registration-firstname')
		this.$lastname = 				this.$el.find('.registration-lastname')
		this.$email = 					this.$el.find('.registration-email')
		this.$company = 				this.$el.find('.registration-company')

		this.$modal = 					this.$el.find('.modal')
		this.$close = 					this.$el.find('.modal-header').find('.close')
		this.$form = 					this.$el.find('.registration-form')

		this.model.set region: 			window.sn.get('region')

		this.textSuccess = 				new RegistrationTextSuccess()

		this.$alertSuccess = 			this.$el.find('.alert-success')
		this.$alertError = 				this.$el.find('.alert-error')

		if window.user?
			
			window.user.on 'change:signin', () =>
				if window.user.get('signin') is false
					this.model.reset()


	afterShow: () ->
		this.$alertSuccess.hide()
		this.$alertError.hide()
		this.textSuccess.hide()
		this.$form.show()
		this.$firstname.focus()

	data: () ->
		this.model.toJSON()

	checking: () ->
		if this.model.get('success')
			this.$form.hide()
			this.$alertSuccess.show()
			this.$alertError.hide()
			this.textSuccess.show
				email:					this.model.get('email')
				password:				this.model.get('password')

		else
			this.$alertError.show().html(this.model.get('valid').replace('Error:', '<b>Ошибка!</b>') + '.')
			this.$alertSuccess.hide()
			this.textSuccess.hide()
			this.$form.show()

			setTimeout () =>
				this.$alertError.hide()
			, 1500

		this.model.unset 				'password'
		this.model.unset 				'valid'

	focus: (e) ->
		e.preventDefault()
		this.$alertError.hide()

	submit: (e) ->
		e.preventDefault()
		this.model.save
			firstname: 					this.$firstname.val()
			lastname: 					this.$lastname.val()
			email:						this.$email.val()
			company:					this.$company.val()
			region: 					window.sn.get('region')
		,
			url:						window.sn.get('server').host + '/registration'
			dataType:					'jsonp'
			success: (s) => 
				this.checking()



