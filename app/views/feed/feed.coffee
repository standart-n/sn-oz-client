
Template = 									require('Template')

module.exports = Template.extend

	el: 									'#feed'
	url: 									'view/feed/feed.html'

	initialize: () ->
		this.render()

	render: () ->
		this.template()

