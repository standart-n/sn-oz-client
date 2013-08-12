
Template = 									require('Template')
FeedBox = 									require('FeedBox')
FeedNews = 									require('FeedNews')

module.exports = Template.extend

	el: 									'#feed'
	url: 									'view/feed/feed.html'

	initialize: () ->

		if this.$el.length?
			this.render()

		window.app.on 'switch', () =>
			if this.$el.length?
				this.setElement('#feed')
				this.render()

	render: () ->
		this.template()
		this.box = 							new FeedBox()
		this.news = 						new FeedNews()

