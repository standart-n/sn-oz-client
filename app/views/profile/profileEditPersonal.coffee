
Backbone = 									require('Backbone')
Template = 									require('Template')

module.exports = Template.extend

	el:										'#tab-profile-personal'
	url:									'view/profile/profileEditPersonal.html'

	events:
		'submit .profile-personal-form' 	: 'submit'

	initialize: () ->

		this.model = 						window.user
		this.render()

		this.$firstname = 					this.$el.find('.profile-firstname')
		this.$lastname = 					this.$el.find('.profile-lastname')

		this.$success = 					this.$el.find('.alert-success')
		this.$error = 						this.$el.find('.alert-error')

		this.model.on 'change:firstname', () =>
			this.$firstname.val this.model.get('firstname')

		this.model.on 'change:lastname', () =>
			this.$lastname.val this.model.get('lastname')

	render: () ->
		this.template()
		

	data: () ->
		this.model.toJSON()

	submit: (e) ->
		e.preventDefault()
		this.model.save
			firstname_new:				this.$firstname.val()
			lastname_new:				this.$lastname.val()
		,
			url: window.sn.get('server').host + '/edit/personal/' + window.user.get('id') + '/' + window.user.get('key')
			dataType: 'jsonp'
			success: (s) => 
				this.checking()

	checking: () ->
		if this.model.get('personal_change')? is true
			this.$success.show()
			this.$error.hide()
		else 
			this.$success.hide()
			this.$error.show()

		this.model.unset 'notice'
		this.model.unset 'firstname_new'
		this.model.unset 'lastname_new'



