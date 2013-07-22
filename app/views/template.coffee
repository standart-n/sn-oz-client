
# Template

require('ejs')
Backbone = 		require('backbone')

module.exports = Backbone.View.extend

	ext: '.html'

	template: () ->
		if this.url?.match(/[\w]*\/[\w]*\/[\w]*.html/)	
			this.$el.html new EJS(url: this.url, ext: this.ext).render(this.data())

	data: () ->



		