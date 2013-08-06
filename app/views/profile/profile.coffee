
Backbone = 									require('Backbone')
Template = 									require('Template')

module.exports = Template.extend

	el:										'#profile'
	url:									'view/profile/profile.html'

	initialize: () ->

		this.model = 						window.social.self

		_.extend this.model, Backbone.Events

		this.model.on 'change:signin', () =>
			this.render()

	render: () ->
		this.template()

	data: () ->
		this.model.toJSON()

