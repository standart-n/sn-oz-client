
Template = 									require('Template')
Backbone = 									require('Backbone')
Complete = 									require('Complete')

module.exports = Template.extend

	path: 									'content'
	markup: 								on
	autorender: 							on

	initialize: () ->
		if this.autorender is on 
			this.render()
		this.customize()

	customize: () ->

	render: () ->
		if this.file?
			this.beforeRender()
			this.region = 					window.sn.get('region').name
			this.url = 						"#{this.path}/#{this.region}/#{this.file}"
			this.template()
			this.afterRender()

	
	data: () ->
		result = 
			region: 	window.sn.get('region')
			theme:		window.sn.get('theme')

	beforeRender: () ->

	afterRender: () ->
		new Complete
			el: 		this.el
			icons:		on
			tooltips:	on
