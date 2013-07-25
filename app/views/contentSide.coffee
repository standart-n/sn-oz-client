
# ContentSide

require('jquery')

Content = require('Content')

module.exports = Content.extend

	el: 	'#side'
	file:	'side_main.html'

	initialize: () ->
		this.render()

	switch: (part,page) ->

		if this.file != "side_#{part}.html"
			this.file = "side_#{part}.html"
			this.render()

		this.$el.find('.nav').find('li').each () ->
			if $(this).find('a').attr('href').match("#{part}/text/#{page}")
				$(this).addClass('active')
			else
				$(this).removeClass('active')

