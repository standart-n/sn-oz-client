
Backbone = 									require('Backbone')
Template = 									require('Template')

module.exports = Template.extend

	el:										'#tab-profile-security'
	url:									'view/profile/profileEditSecurity.html'

	events:
		'submit .profile-security-form' 	: 'submit'


	initialize: () ->
		this.model = 						window.user ? Backbone.Model.extend()
		this.render()

		this.$password = 					this.$el.find('.profile-password')
		this.$password_new = 				this.$el.find('.profile-password-new')
		this.$password_repeat = 			this.$el.find('.profile-password-repeat')

		this.$success = 					this.$el.find('.alert-success')
		this.$error = 						this.$el.find('.alert-error')

	render: () ->
		this.template()		

	data: () ->
		this.model.toJSON()

	checking: () ->
		alert JSON.stringify(this.model.toJSON())

	submit: (e) ->
		e.preventDefault()
		this.model.save
			password:					this.$password.val()
			password_new:				this.$password_new.val()
			password_repeat:			this.$password_repeat.val()
		,
			url:						window.sn.get('server').host + '/edit/password'
			dataType:					'jsonp'
			success: (s) => 
				this.checking()

