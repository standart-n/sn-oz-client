
require('ejs')

Backbone = 											require('Backbone')

module.exports = Backbone.View.extend

	url: 		''
	ext: 		'.html'

	ejs: (res = {}, url) ->

		new EJS
			url: 		if url then url else this.url
			ext: 		this.ext
			type: 		'['
			cache: 		off
		.render(res)

