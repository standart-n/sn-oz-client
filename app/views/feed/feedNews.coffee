	
Template = 									require('Template')
Posts = 									require('Posts')
Complete = 									require('Complete')

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


	removePost: (id) ->
		this.state = 						'remove'

		$post = 							this.$el.find("[data-post-id=\"#{id}\"]")
		$text = 							$post.find('.post-text')
		$footer = 							$post.find('.post-footer')
		$toolsRemove = 						$post.find('.post-tools-remove')

		post = 								this.posts.get(id)

		$text.hide()
		$toolsRemove.show()
		$footer.hide()


	editPost: (id) ->
		this.state = 						'edit'

		$post = 							this.$el.find("[data-post-id=\"#{id}\"]")
		$text = 							$post.find('.post-text')
		$edit = 							$post.find('.post-edit')
		$footer = 							$post.find('.post-footer')
		$toolsEdit = 						$post.find('.post-tools-edit')
		$area = 							$post.find('textarea')

		post = 								this.posts.get(id)
		text = 								post.get('message').text

		$text.hide()
		$edit.show()
		$toolsEdit.show()
		$area.val(text)						if $area.val() is ''
		$footer.hide()


	savePost: (id) ->
		alert id

	deletePost: (id) ->
		alert id


	blurPost: (id) ->
		this.state = 						'ready'

		$post = 							this.$el.find("[data-post-id=\"#{id}\"]")
		$text = 							$post.find('.post-text')
		$edit = 							$post.find('.post-edit')
		$footer = 							$post.find('.post-footer')
		$toolsEdit = 						$post.find('.post-tools-edit')
		$toolsRemove = 						$post.find('.post-tools-remove')
		$area = 							$post.find('textarea')

		post = 								this.posts.get(id)
		text = 								post.get('message').text

		$text.show()
		$edit.hide()
		$toolsEdit.hide()
		$toolsRemove.hide()
		$footer.show()


	checking: () ->
		this.state = 						'ready'

		this.render()

		new Complete
			el: 		this.el
			icons:		on
			tooltips:	on

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


