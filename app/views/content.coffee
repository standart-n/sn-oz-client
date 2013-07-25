
# Content

Template = require('Template')

module.exports = Template.extend

	path: 		'content'
	ext: 		'.html'
	markup: 	on

	render: () ->
		if this.file?
			this.beforeRender()
			region = 		window.sn.get('region').name
			this.url = 		"#{this.path}/#{region}/#{this.file}"
			this.template()
			this.afterRender()

	
	data: () ->
		result = 
			region: 	window.sn.get('region')
			theme:		window.sn.get('theme')

	beforeRender: () ->

	afterRender: () ->
		this.$el.find('.tooltip-toggle').tooltip()
		if $.isFunction($.bootstrapIE6)
			$.bootstrapIE6(this.el)
