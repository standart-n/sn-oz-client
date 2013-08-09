
Backbone = 									require('Backbone')
Template = 									require('Template')
Password = 									require('Password')

module.exports = Template.extend

	el:										'#tab-profile-security'
	url:									'view/profile/profileEditSecurity.html'

	events:
		'submit .profile-security-form'		: 'submit'


	initialize: () ->

		this.password = 					new Password()

		this.render()

		this.$password_new = 				this.$el.find('.profile-password-new')
		this.$password_repeat = 			this.$el.find('.profile-password-repeat')

		this.$success = 					this.$el.find('.alert-success')
		this.$error = 						this.$el.find('.alert-error')

	render: () ->
		this.template()		

	data: () ->
		this.password.toJSON()

	checking: () ->

		if window.user?

			if this.password.get('password_change') is true
				this.$success.show().html(this.password.get('notice') + '.')
				this.$error.hide()
				window.user.set('key', this.password.get('key'))
			else 
				this.$success.hide()
				this.$error.show().html('<b>Ошибка!</b> ' + this.password.get('notice').replace('Error: ','') + '.')

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
				dataType: 'jsonp'
				success: (s) => 
					this.checking()

