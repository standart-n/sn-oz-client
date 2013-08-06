
Modal = 								require('Modal')
Signin = 								require('Signin')
SigninAlertError = 						require('SigninAlertError')

module.exports = Modal.extend

	el:									'#signin'
	url:								'view/signin/signin.html'
	model:								new Signin()

	initialize: () ->
		this.render()

		this.$email = 					this.$el.find('.signin-email')
		this.$password = 				this.$el.find('.signin-password')

		this.$modal = 					this.$el.find('.modal')
		this.$close = 					this.$el.find('.modal-header').find('.close')
		this.$form = 					this.$el.find('.signin-form')

		this.model.set region: 			window.sn.get('region')

		this.alertError = 				new SigninAlertError()

	checking: () ->
		if this.model.get('success')
			this.alertError.hide()
			this.$form.hide()
			this.hide()
		else
			this.alertError.show()
			this.$form.show()

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
		this.alertError.hide()
		this.$form.show()

	data: () ->
		this.model.toJSON()
		