
Template = 									require('Template')
FeedBox = 									require('FeedBox')
FeedNews = 									require('FeedNews')

module.exports = Template.extend

	el: 									'#feed'
	url: 									'view/feed/feed.html'

	initialize: () ->

		this.render()

		window.app.on 'switch', () =>
			this.setElement('#feed')
			this.render()

		$(document).on 'scrollDown', () =>	
			this.news.down()

		this.box.$el.on 'send.success', () =>
			this.news.fetch()

		

	render: () ->
		this.template()
		this.box = 							new FeedBox()
		this.news = 						new FeedNews()

