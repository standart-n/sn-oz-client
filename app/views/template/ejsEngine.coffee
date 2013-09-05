
require('ejs')

Backbone = 											require('Backbone')

module.exports = Backbone.View.extend

	url: 		''
	ext: 		'.html'

	ejs: (res = {}) ->

		new EJS(url: this.url, ext: this.ext, type: '[', cache: off).render(res) ? ''

