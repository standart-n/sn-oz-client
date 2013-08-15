
require('moment')

Modal = 								require('Modal')
Signin = 								require('Signin')

module.exports = Modal.extend

	el:									'#signin'
	url:								'view/signin/signin.html'

	initialize: () ->

		this.model = 					new Signin()

		this.render()

		this.$email = 					this.$el.find('.signin-email')
		this.$password = 				this.$el.find('.signin-password')

		this.$modal = 					this.$el.find('.modal')
		this.$close = 					this.$el.find('.modal-header').find('.close')
		this.$form = 					this.$el.find('.signin-form')
		this.$button = 					this.$el.find('button')

		this.model.set region: 			window.sn.get('region')

		this.$alertError = 				this.$el.find('.alert-error')

		if window.user?
			
			window.user.on 'change:signin', () =>
				if window.user.get('signin') is false
					this.model.reset()
		

	checking: () ->

		this.$password.val('')

		setTimeout () =>
			this.$button.button('reset')
		, 400

		if this.model.get('success')
			this.$alertError.hide()
			this.$form.hide()
			this.hide()
		else
			this.error 					'<b>Ошибка!</b> ' + this.model.get('notice') + '.'
			this.$form.show()

		this.model.reset()

	submit: (e) ->
		e.preventDefault()

		this.model.save
			email:						this.$email.val()
			password:					this.$password.val()
		,
			url:						window.sn.get('server').host + '/signin'
			dataType:					'jsonp'
			timeout:					3000

			beforeSend: () =>
				this.$button.button 	'loading'

			success: (s) => 
				this.checking()

			error: () =>
				this.$button.button		'reset'
				this.error 				'<b>Ошибка!</b> Сервер не отвечает!'


	error: (notice = '') ->

		mark = moment().unix()

		this.$alertError.show().html(notice)
		this.$alertError.data 'mark', mark

		setTimeout () =>
			if this.$alertError.data('mark') is mark
				this.$alertError.hide()
		, 3000


	afterShow: () ->
		this.$alertError.hide()
		this.$form.show()
		this.$password.val('')
		this.$email.focus()

	data: () ->
		this.model.toJSON()
		