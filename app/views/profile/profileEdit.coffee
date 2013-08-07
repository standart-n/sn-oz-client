
Backbone = 									require('Backbone')
Template = 									require('Template')

ProfileEditPersonal = 						require('ProfileEditPersonal')
ProfileEditSecurity = 						require('ProfileEditSecurity')

module.exports = Template.extend

	el:										'#primary'
	url:									'view/profile/profileEdit.html'

	initialize: () ->

		this.model = 						window.user ? Backbone.Model.extend()

	render: () ->
		this.template()
		this.personal = 					new ProfileEditPersonal()
		this.security = 					new ProfileEditSecurity()
		

	data: () ->
		this.model.toJSON()

