
# Layout

Backbone = require('backbone')

module.exports = Backbone.View.extend

	path: 'layout'
	ext: '.html'

	render: () ->
		if this.file?
			region = 	window.sn.get('region').name
			url = 		this.path + '/' + region + '/' + this.file
			if url.match(/[\w]*\/[\w]*\/[\w]*.html/)
				this.$el.html new EJS(url: url, ext: this.ext).render(this.data())

	data: () ->
		result = 
			region: 	window.sn.get('region')
			theme:		window.sn.get('theme')


		