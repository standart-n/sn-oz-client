
Backbone = 									require('Backbone')
Template = 									require('Template')
Complete = 									require('Complete')

module.exports = Template.extend

	el:										'#primary'
	url:									'view/profile/profileEdit.html'

	initialize: () ->

		this.model = 						window.self

	render: () ->
		this.template()
		

	data: () ->
		this.model.toJSON()

