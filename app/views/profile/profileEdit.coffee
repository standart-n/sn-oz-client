
Backbone = 									require('Backbone')
Template = 									require('Template')

ProfileEditPersonal = 						require('ProfileEditPersonal')
ProfileEditSecurity = 						require('ProfileEditSecurity')

module.exports = Template.extend

	el:										'#primary'
	url:									'view/profile/profileEdit.html'

	initialize: () ->

	render: () ->
		this.template()
		this.personal = 					new ProfileEditPersonal()
		this.security = 					new ProfileEditSecurity()
		
	data: () ->
		if window.user? then window.user.toJSON() else {}

