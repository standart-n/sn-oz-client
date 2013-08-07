
Backbone = 									require('Backbone')

ProfileView =  								require('ProfileView')
ProfileEdit =  								require('ProfileEdit')

module.exports = Backbone.Router.extend

	routes:
		'profile/edit':						'routeEdit'

	initialize: () ->

		_.extend this, Backbone.Events

		this.profileView = 					new ProfileView()
		this.profileEdit = 					new ProfileEdit()


	routeEdit: () ->
		this.profileEdit.render()



