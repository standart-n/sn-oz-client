
require('moment')

Modal = 								require('Modal')
Remember = 								require('Remember')


module.exports = Modal.extend

	el:									'#remember'
	url:								'view/remember/remember.html'

	initialize: () ->
		this.model = 					new Remember()
		this.render()
		this.$email = 					this.$el.find('.remember-email')

		this.$modal = 					this.$el.find('.modal')
		this.$close = 					this.$el.find('.modal-header').find('.close')
		this.$form = 					this.$el.find('.remember-form')
		this.$button = 					this.$el.find('button')

		this.$alertSuccess = 			this.$el.find('.alert-success')
		this.$alertError = 				this.$el.find('.alert-error')

		if window.user?
			
			window.user.on 'change:signin', () =>
				if window.user.get('signin') is false
					this.model.reset()

	data: () ->
		this.model.toJSON()


	checking: () ->

		this.$email.val ''
		this.$email.focus()

		setTimeout () =>
			this.$button.button			'reset'
		, 400

		if this.model.get('success')
			this.success()
		else
			this.error 					'<b>Ошибка!</b> ' + this.model.get('notice') + '.'

		this.model.unset 				'success'
		this.model.unset 				'password'
		this.model.unset 				'email'


	afterShow: () ->
		this.$alertSuccess.hide()
		this.$alertError.hide()
		this.$email.val ''
		this.$email.focus()


	success: () ->

		mark = moment().unix()

		this.$alertSuccess.show()
		this.$alertSuccess.data 'mark',	mark
		this.$alertError.hide()

		setTimeout () =>
			if this.$alertSuccess.data('mark') is mark
				this.$alertSuccess.hide()
		, 2500


	error: (notice = '') ->

		mark = moment().unix()

		this.$alertError.show().html 	notice
		this.$alertError.data 'mark',	mark
		this.$alertSuccess.hide()

		setTimeout () =>
			if this.$alertError.data('mark') is mark
				this.$alertError.hide()
		, 2500


	submit: (e) ->
		e.preventDefault()
		this.model.save
			email:						this.$email.val()
			region: 					window.sn.get('region')
		,
			url:						window.sn.get('server').host + '/remember'
			timeout: 					3000
			dataType:					'jsonp'

			beforeSend: () =>
				this.$button.button 	'loading'

			success: (s) => 
				this.checking()

			error: () =>
				this.$button.button		'reset'
				this.error 				'<b>Ошибка!</b> Сервер не отвечает!'


		