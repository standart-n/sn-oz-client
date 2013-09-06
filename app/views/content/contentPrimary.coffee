
Content = 									require('Content')

module.exports = Content.extend

	el: 									'#primary'
	file:									''
	page: 									''
	# file:									'main.html'
	# page: 									'main'
	autorender: 							off

	switch: (part, page) ->
		this.page = page
		this.file = "#{page}.html"
		this.render()

			
