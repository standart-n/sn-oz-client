
require('moment')

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
		this.$button = 					this.$el.find('button')

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

		setTimeout () =>
			this.$button.button			'reset'
		, 400

		if this.model.get('success') is true
			this.success 				this.model.get('email'), this.model.get('password')
		else
			this.error 					'<b>Ошибка!</b> ' + this.model.get('valid') + '.'

		this.model.unset 				'success'
		this.model.unset 				'password'
		this.model.unset 				'valid'

	success: (email, password) ->
		this.$form.hide()
		this.$alertSuccess.show()
		this.$alertError.hide()
		this.textSuccess.show
			email:						email
			password: 					password


	error: (notice = '') ->

		mark = moment().unix()

		this.$alertError.show().html 	notice
		this.$alertError.data 'mark',	mark
		this.$alertSuccess.hide()
		this.textSuccess.hide()
		this.$form.show()

		setTimeout () =>
			if this.$alertError.data('mark') is mark
				this.$alertError.hide()
		, 2000


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
			timeout: 					3000
			dataType:					'jsonp'

			beforeSend: () =>
				this.$button.button 	'loading'

			success: (s) => 
				this.checking()

			error: () =>
				this.$button.button		'reset'
				this.error 				'<b>Ошибка!</b> Сервер не отвечает!'



