
# Content

Template = 		require('Template')
Complete = 		require('Complete')

module.exports = Template.extend

	path: 		'content'
	ext: 		'.html'
	markup: 	on

	render: () ->
		if this.file?
			this.beforeRender()
			this.region = 	window.sn.get('region').name
			this.url = 		"#{this.path}/#{this.region}/#{this.file}"
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
