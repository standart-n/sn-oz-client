
Backbone = 									require('Backbone')
Template = 									require('Template')
Complete = 									require('Complete')

module.exports = Template.extend

	el:										'#profile'
	url:									'view/profile/profile.html'

	initialize: () ->

		this.model = 						window.self

		_.extend this.model, Backbone.Events

		this.model.on 'change:signin', () =>
			this.render()

	render: () ->
		this.template()
		new Complete
			el: 							this.el
			icons:							on

	data: () ->
		this.model.toJSON()

