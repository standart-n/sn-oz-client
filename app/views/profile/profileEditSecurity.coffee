
Backbone = 									require('Backbone')
Template = 									require('Template')

module.exports = Template.extend

	el:										'#tab-profile-security'
	url:									'view/profile/profileEditSecurity.html'

	events:
		'submit .profile-security-form' 	: 'submit'


	initialize: () ->
		this.model = 						window.user
		this.render()

		this.$password_new = 				this.$el.find('.profile-password-new')
		this.$password_repeat = 			this.$el.find('.profile-password-repeat')

		this.$success = 					this.$el.find('.alert-success')
		this.$error = 						this.$el.find('.alert-error')

	render: () ->
		this.template()		

	data: () ->
		this.model.toJSON()

	checking: () ->
		if this.model.get('password_change')? is true
			this.$success.show()
			this.$error.hide()
			this.model.updateCookie()
		else 
			this.$success.hide()
			this.$error.show()

		this.$password_new.val('')
		this.$password_repeat.val('')

		this.model.unset 'notice'
		this.model.unset 'key_new'
		this.model.unset 'password_new'
		this.model.unset 'password_repeat'
		this.model.unset 'password_change'

	submit: (e) ->
		e.preventDefault()
		this.model.save
			password_new:				this.$password_new.val()
			password_repeat:			this.$password_repeat.val()
		,
			url: window.sn.get('server').host + '/edit/password/' + window.user.get('id') + '/' + window.user.get('key')
			dataType: 'jsonp'
			success: (s) => 
				this.checking()

