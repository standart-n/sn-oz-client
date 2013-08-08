
Backbone = 									require('Backbone')

ProfileView =  								require('ProfileView')
ProfileEdit =  								require('ProfileEdit')

module.exports = Backbone.Router.extend

	routes:
		'profile/edit':						'routeEdit'

	initialize: () ->

		this.profileView = 					new ProfileView()
		this.profileEdit = 					new ProfileEdit()


	routeEdit: () ->
		this.profileEdit.render()
		window.app?.links?.switch()



