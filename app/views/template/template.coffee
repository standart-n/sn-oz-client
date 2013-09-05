
require('jquery')

EjsEngine = 										require('EjsEngine')

module.exports = EjsEngine.extend

	url: 		''
	ext: 		'.html'
	markup: 	off

	template: () ->
		if this.url?

			text = 									''
			ms = 									[]
			data = 									this.data()
			
			if !$.isArray(data) then ms[0] = data else ms = data

			for res in ms

				text += this.ejs(res)

			text = window.markup?.render(text) if this.markup
			
			this.$el.html text

	render: () ->
		this.template()

	data: () ->
