
require('moment')
require('_')
	
FeedNewsSync = 								require('FeedNewsSync')
Posts = 									require('Posts')
Update = 									require('Update')

module.exports = FeedNewsSync.extend

	el: 									'#feed-news'
	url: 									'view/feed/feedNews.html'

	initialize: () ->

		this.limit = 						10
		this.step = 						10
		this.state = 						'ready'

		this.posts = 						new Posts()
		this.update = 						new Update()

		this.startSync()

		this.fetch()

	render: () ->


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
		$area.val(text)
		$area.focus()
		$footer.hide()


	savePost: (id) ->
		this.state = 						'save'
		post = 								this.posts.get(id)

		$post = 							this.$el.find("[data-post-id=\"#{id}\"]")
		$area = 							$post.find('textarea')
		$button = 							$post.find('.post-tools-edit').find('.btn-success')

		if window.user?
			if window.user.get('signin') is true

				author =  					post.get('author')

				_.extend author, {
					id:						window.user.get('id')
					key:					window.user.get('key')
				}

				message = 
					text:					$area.val()


				if message.text isnt ''

					post.save
						author:					author
						message:				message
					,
						url: 					"#{window.sn.get('server').host}/feed/post/edit"
						timeout: 				3000
						dataType: 				'jsonp'

						beforeSend: () =>
							$button.button 		'loading'

						success: (s) => 
							this.afterSavePost(id)

						error: () =>
							$button.button		'reset'
							this.error 			id, '<b>Ошибка!</b> Сервер не отвечает!'


	afterSavePost: (id) ->
		post = 								this.posts.get(id)

		$post = 							this.$el.find("[data-post-id=\"#{id}\"]")
		$button = 							$post.find('.post-tools-edit').find('.btn-success')

		setTimeout () =>
			$button.button					'reset'
		, 400

		if post.get('success') is true
			this.state = 					'ready'			
			this.blurPost(id)
		
		else
			this.error id, post.get('notice')

		post.unset('success')
		post.unset('notice')


	deletePost: (id) ->
		this.state = 						'save'
		post = 								this.posts.get(id)

		$post = 							this.$el.find("[data-post-id=\"#{id}\"]")
		$button = 							$post.find('.post-tools-edit').find('.btn-success')

		if window.user?
			if window.user.get('signin') is true

				author = 					post.get('author')

				_.extend author, {
					id:						window.user.get('id')
					key:					window.user.get('key')
				}

				message = 
					text:					''

				post.save
					author:					author
				,
					url: 					"#{window.sn.get('server').host}/feed/post/delete"
					timeout: 				3000
					dataType: 				'jsonp'

					beforeSend: () =>
						$button.button 		'loading'

					success: (s) => 
						this.afterDeletePost(id)

					error: () =>
						$button.button		'reset'
						this.error 			id, '<b>Ошибка!</b> Сервер не отвечает!'



	afterDeletePost: (id) ->
		post = 								this.posts.get(id)

		$post = 							this.$el.find("[data-post-id=\"#{id}\"]")
		$button = 							$post.find('.post-tools-edit').find('.btn-success')

		setTimeout () =>
			$button.button					'reset'
		, 400

		if post.get('success') is true
			this.posts.remove(post)
		
		else
			this.error id, post.get('notice')

		post.unset('success')
		post.unset('notice')

	blurPost: (id) ->
		this.state = 						'ready'

		$post = 							this.$el.find("[data-post-id=\"#{id}\"]")
		$text = 							$post.find('.post-text')
		$edit = 							$post.find('.post-edit')
		$footer = 							$post.find('.post-footer')
		$toolsEdit = 						$post.find('.post-tools-edit')
		$toolsRemove = 						$post.find('.post-tools-remove')
		$area = 							$post.find('textarea')
		$alertError = 						$post.find('.alert-error')
		$alertSuccess = 					$post.find('.alert-success')

		post = 								this.posts.get(id)
		text = 								post.get('message').text

		$text.show()
		$edit.hide()
		$toolsEdit.hide()
		$toolsRemove.hide()
		$footer.show()

		$alertError.hide()
		$alertSuccess.hide()

	error: (id, notice = '') ->
		mark = moment().unix()

		$post = 							this.$el.find("[data-post-id=\"#{id}\"]")
		$alertError = 						$post.find('.alert-error')
		$alertSuccess = 					$post.find('.alert-success')

		$alertError.show().html 			notice
		$alertError.data 'mark',			mark
		$alertSuccess.hide()

		setTimeout () =>
			if $alertError.data('mark') is mark
				$alertError.hide()
		, 2000



	checking: () ->
		this.state = 						'ready'

		# this.render()

		# new Complete
		# 	el: 		this.el
		# 	icons:		on
		# 	tooltips:	on

	down: () ->
		this.limit = 						this.posts.length + this.step
		this.fetch()


	updating: () ->

		post = this.posts.last()

		if post?

			if post.get('seria') isnt ''

				this.update.fetch

					url: 					"#{window.sn.get('server').host}/feed/post/#{window.sn.get('region').name}/#{post.get('seria')}"
					timeout: 	3000
					dataType: 	'jsonp'

					data:
						limit:	this.limit

					success: () => 
						if this.update.get('update') is true
							this.update.set 'update', false
							this.fetch()


	fetch: () ->

		if this.state is 'ready'

			this.posts.fetch
				url: 						"#{window.sn.get('server').host}/feed/post/#{window.sn.get('region').name}"
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


