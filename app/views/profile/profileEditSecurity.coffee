
require('moment')

Backbone = 									require('Backbone')
Template = 									require('Template')
Password = 									require('Password')

module.exports = Template.extend

	el:										'#tab-profile-security'
	url:									'view/profile/profileEditSecurity.html'

	events:
		'submit .profile-security-form' 	: 'submit'

	initialize: () ->

		this.password = 					new Password()

		this.render()

		this.$password_new = 				this.$el.find('.profile-password-new')
		this.$password_repeat = 			this.$el.find('.profile-password-repeat')

		this.$success = 					this.$el.find('.alert-success')
		this.$error = 						this.$el.find('.alert-error')

		this.$button = 						this.$el.find('button')

	render: () ->
		this.template()		

	data: () ->
		this.password.toJSON()

	checking: () ->

		setTimeout () =>
			this.$button.button				'reset'
		, 400

		if window.user?

			if this.password.get('success') is true

				this.success 				this.password.get('notice') + '.'

				window.user.set 
					key: 					this.password.get('key')

			else 

				this.error 					'<b>Ошибка!</b> ' + this.password.get('notice') + '.'

			this.$password_new.val('')
			this.$password_repeat.val('')

			this.password.clear()

	submit: (e) ->
		e.preventDefault()

		if this.$password_new.val() isnt this.$password_repeat.val()

			this.error('<b>Ошибка!</b> Пароли не совпадают!')

		else

			if window.user?

				this.password.set 
					id:							window.user.get('id')
					password_new:				this.$password_new.val()

				req = JSON.stringify this.password

				this.password.save null,
					url: 						window.sn.get('server').host + '/edit/password/'
					timeout: 					10000
					dataType: 'jsonp'
					data:
						model:					req
						sessid:					window.user.get('sessid')
						token:					window.user.get('token')
						_method:				'PUT'

					beforeSend: () =>
						this.$button.button 	'loading'

					success: (s) => 
						this.checking()

					error: () =>
						this.$button.button		'reset'
						this.error 				'<b>Ошибка!</b> Сервер не отвечает!'


	error: (notice = '') ->

		mark = moment().unix()

		this.$error.show().html	 			notice
		this.$error.data 'mark', 			mark
		this.$success.hide()

		setTimeout () =>
			if this.$error.data('mark') is mark
				this.$error.hide()
		, 3000


	success: (notice = '') ->

		mark = moment().unix()

		this.$success.show().html 			notice
		this.$success.data 'mark', 			mark
		this.$error.hide()

		setTimeout () =>
			if this.$success.data('mark') is mark
				this.$success.hide()
		, 1500





