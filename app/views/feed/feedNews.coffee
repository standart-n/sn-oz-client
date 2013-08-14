	
Template = 									require('Template')
Posts = 									require('Posts')

module.exports = Template.extend

	el: 									'#feed-news'
	url: 									'view/feed/feedNews.html'

	initialize: () ->

		this.limit = 						10
		this.step = 						10
		this.state = 						'ready'

		this.posts = 						new Posts()

		this.fetch()

	render: () ->
		this.template()


	data: () ->
		this.posts.toJSON()	

	checking: () ->

		this.render()
		this.state = 						'ready'


	down: () ->
		this.limit = 						this.posts.length + this.step
		this.fetch()


	fetch: () ->

		if this.state is 'ready'

			this.posts.fetch
				url: 						window.sn.get('server').host + '/feed/post/' + window.sn.get('region').name
				timeout: 					3000
				dataType: 					'jsonp'

				data:
					limit:					this.limit

				beforeSend: () ->
					this.state = 			'loading'

				success: (s) => 
					this.checking()

				error: () ->
					this.state = 			'ready'


