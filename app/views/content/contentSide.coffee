
require('jquery')

Content = 									require('Content')

module.exports = Content.extend

	el: 									'#side'
	file:									''
	# file:									'side_main.html'
	autorender: 							off

	switch: (part, page) ->

		if this.file != "side_#{part}.html"
			this.file = "side_#{part}.html"
			this.render()
