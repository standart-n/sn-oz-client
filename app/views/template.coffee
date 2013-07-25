
# Template

require('ejs')
Backbone = 		require('Backbone')

module.exports = Backbone.View.extend

	ext: 		'.html'
	markup: 	off

	template: () ->
		if this.url?.match(/[\w]*\/[\w]*\/[\w]*.html/)	
			text = new EJS(url: this.url, ext: this.ext).render(this.data())
			text = window.markup.render(text) if this.markup
			this.$el.html text

	data: () ->
		