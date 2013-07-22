
# Content

Template = require('Template')

module.exports = Template.extend

	path: 'content'
	ext: '.html'

	render: () ->
		if this.file?
			region = 		window.sn.get('region').name
			this.url = 		this.path + '/' + region + '/' + this.file
			this.template()

	data: () ->
		result = 
			region: 	window.sn.get('region')
			theme:		window.sn.get('theme')

		