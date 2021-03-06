
# Layout

Template = 		require('Template')
Complete = 		require('Complete')

module.exports = Template.extend

	path: 		'layout'
	markup: 	off

	render: () ->
		if this.file? and this.path?
			this.beforeRender()
			this.region = 	window.sn?.get('region').name ? ''
			this.url = 		"#{this.path}/#{this.region}/#{this.file}"
			this.template()
			this.afterRender()

	data: () ->
		result = 
			region: 	window.sn.get('region')
			theme:		window.sn.get('region')


	beforeRender: () ->

	afterRender: () ->
		new Complete
			el: 		this.el
			icons:			on

		