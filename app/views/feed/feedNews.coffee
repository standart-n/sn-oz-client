	
Template = 									require('Template')
Posts = 									require('Posts')

module.exports = Template.extend

	el: 									'#feed-news'
	url: 									'view/feed/feedNews.html'


	initialize: () ->

		this.posts = 						new Posts()

		this.fetch()

	render: () ->
		this.template()


	data: () ->
		this.posts.toJSON()	

	checking: () ->

		this.render()


	fetch: () ->

		this.posts.fetch
			url: 							window.sn.get('server').host + '/feed/post/'
			timeout: 						3000
			dataType: 						'jsonp'

			success: (s) => 
				this.checking()


