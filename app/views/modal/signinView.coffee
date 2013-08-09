
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

		this.model.set region: 			window.sn.get('region')

		this.$alertError = 				this.$el.find('.alert-error')

		if window.user?
			
			window.user.on 'change:signin', () =>
				if window.user.get('signin') is false
					this.model.reset()
		

	checking: () ->
		this.$password.val('')

		if this.model.get('success')
			this.$alertError.hide()
			this.$form.hide()
			this.hide()
		else
			this.$alertError.show().html('<b>Ошибка!</b> ' + this.model.get('notice') + '.')
			this.$form.show()

		this.model.unset 	'notice'
		this.model.unset 	'password'

	submit: (e) ->
		e.preventDefault()
		this.model.save
			email:						this.$email.val()
			password:					this.$password.val()
		,
			url:						window.sn.get('server').host + '/signin'
			dataType:					'jsonp'
			success: (s) => 
				this.checking()


	afterShow: () ->
		this.$alertError.hide()
		this.$form.show()
		this.$password.val('')

	data: () ->
		this.model.toJSON()
		