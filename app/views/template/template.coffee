
# Template

require('ejs')
require('jquery')

Backbone = 											require('Backbone')

module.exports = Backbone.View.extend

	ext: 		'.html'
	markup: 	off

	template: () ->
		if this.url?

			text = 									''
			ms = 									[]
			data = 									this.data()
			
			if !$.isArray(data) then ms[0] = data else ms = data

			for res in ms

				text += new EJS(url: this.url, ext: this.ext, type: '[', cache: off).render(res) ? ''

			text = window.markup?.render(text) if this.markup
			
			this.$el.html text

	render: () ->
		this.template()

	data: () ->
