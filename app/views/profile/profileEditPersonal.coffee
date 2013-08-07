
Backbone = 									require('Backbone')
Template = 									require('Template')

module.exports = Template.extend

	el:										'#tab-profile-personal'
	url:									'view/profile/profileEditPersonal.html'

	initialize: () ->

		_.extend this, Backbone.Event

		this.model = 						window.user
		this.render()

		this.$firstname = 					this.$el.find('.profile-firstname')
		this.$lastname = 					this.$el.find('.profile-lastname')

		this.model.on 'change:firstname', () =>
			this.$firstname.val this.model.get('firstname')

		this.model.on 'change:lastname', () =>
			this.$lastname.val this.model.get('lastname')

	render: () ->
		this.template()
		

	data: () ->
		this.model.toJSON()

