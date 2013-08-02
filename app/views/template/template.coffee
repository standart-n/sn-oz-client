
# Template

require('ejs')
Backbone = 		require('Backbone')

module.exports = Backbone.View.extend

	ext: 		'.html'
	markup: 	off

	template: () ->
		if this.url?	
			text = new EJS(url: this.url, ext: this.ext, type: '[').render(this.data()) ? ''
			text = window.markup?.render(text) if this.markup ? ''
			this.$el.html text

	render: () ->

	data: () ->
