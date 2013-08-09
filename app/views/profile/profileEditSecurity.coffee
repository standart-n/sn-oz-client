
Backbone = 									require('Backbone')
Template = 									require('Template')

module.exports = Template.extend

	el:										'#tab-profile-security'
	url:									'view/profile/profileEditSecurity.html'

	events:
		'submit .profile-security-form'		: 'submit'


	initialize: () ->

		this.render()

		this.$password_new = 				this.$el.find('.profile-password-new')
		this.$password_repeat = 			this.$el.find('.profile-password-repeat')

		this.$success = 					this.$el.find('.alert-success')
		this.$error = 						this.$el.find('.alert-error')

	render: () ->
		this.template()		

	data: () ->
		if window.user? then window.user.toJSON() else {}

	checking: () ->

		if window.user?

			if window.user.get('password_change') is true
				this.$success.show().html(window.user.get('notice') + '.')
				this.$error.hide()
				window.user.updateCookie()
			else 
				this.$success.hide()
				this.$error.show().html('<b>Ошибка!</b> ' + window.user.get('notice').replace('Error: ','') + '.')

			this.$password_new.val('')
			this.$password_repeat.val('')

			window.user.unset 'notice'
			window.user.unset 'key_new'
			window.user.unset 'password_new'
			window.user.unset 'password_repeat'
			window.user.unset 'password_change'

	submit: (e) ->
		e.preventDefault()

		if window.user?

			window.user.save
				password_new:				this.$password_new.val()
				password_repeat:			this.$password_repeat.val()
			,
				url: 						window.sn.get('server').host + '/edit/password/'
				dataType: 'jsonp'
				success: (s) => 
					this.checking()

