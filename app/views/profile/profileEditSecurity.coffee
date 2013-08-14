
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

			if this.password.get('password_change') is true

				this.success 				this.password.get('notice') + '.'

				window.user.set 
					key: 					this.password.get('key')

			else 

				this.error 					'<b>Ошибка!</b> ' + this.password.get('notice') + '.'

			this.$password_new.val('')
			this.$password_repeat.val('')

			this.password.unset 'id'
			this.password.unset 'key'
			this.password.unset 'notice'
			this.password.unset 'key_new'
			this.password.unset 'password_new'
			this.password.unset 'password_repeat'
			this.password.unset 'password_change'

	submit: (e) ->
		e.preventDefault()

		if window.user?

			this.password.set 
				id:							window.user.get('id')
				key: 						window.user.get('key')

			this.password.save
				password_new:				this.$password_new.val()
				password_repeat:			this.$password_repeat.val()
			,
				url: 						window.sn.get('server').host + '/edit/password/'
				timeout: 					3000
				dataType: 'jsonp'

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





