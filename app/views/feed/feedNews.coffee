
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
		$files = 							$post.find('.post-files')
		$photos = 							$post.find('.post-photos')
		$footer = 							$post.find('.post-footer')
		$toolsRemove = 						$post.find('.post-tools-remove')

		post = 								this.posts.get(id)

		$text.hide()
		$files.hide()
		$photos.hide()
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

				message = 
					text:					$area.val()

				post.set
					message:				message
				,
					silent:					true

				aid = window.aid()
				
				if message.text isnt ''

					req = 								_.pick(post.toJSON(),'id','author', 'message','region')


					this.state = 						'ready'

					post = 								this.posts.get(id)

					$post = 							this.$el.find("[data-post-id=\"#{id}\"]")
					$button = 							$post.find('.post-tools-edit').find('.btn-success')		

					$.ajax
						url: 							window.sn.get('server').host + '/feed/post/'
						timeout: 						10000
						type:							'PUT'
						dataType:						'iframe'
						formData: [
							{
								name:					'model'
								value:					JSON.stringify(req)
							},
							{
								name:					'token'
								value:					window.user.get('token')
							},
							{
								name:					'sessid'
								value:					window.user.get('sessid')
							}
							{
								name:					'aid'
								value:					aid
							}
						]

						beforeSend: () ->
							$button.button ('loading')
							setTimeout () ->
								$button.button('reset')
							, 400							

						success: () =>

							this.getResultFromServer aid, id, (data) =>
								
								if data.success is true

									this.blurPost(id)
									this.fetch() if !window.isSocketReady

								else 
									if data.notice?
										this.error(id, data.notice)
									else
										this.error(id)

						error: () =>
							this.error(id)



	deletePost: (id) ->
		this.state = 'ready'
		this.blurPost(id)

		if window.user?
			if window.user.get('signin') is true

				$.ajax
					url: 							"#{window.sn.get('server').host}/feed/post/#{id}"
					timeout: 						10000
					type:							'DELETE'
					dataType:						'iframe'
					formData: [
						{
							name:					'token'
							value:					window.user.get('token')
						},
						{
							name:					'sessid'
							value:					window.user.get('sessid')
						}
					]

					success: () =>

						if !window.isSocketReady
							this.fetch()


	getResultFromServer: (aid, id, callback) ->

		$.ajax
			url:				window.sn.get('server').host + '/action/' + aid
			timeout: 			10000
			dataType:			'jsonp'
			
			success: (data) =>
				callback(data) if callback				

			error: () =>
				this.error(id)



	blurPost: (id) ->
		this.state = 						'ready'

		$post = 							this.$el.find("[data-post-id=\"#{id}\"]")
		$area = 							$post.find('textarea')
		$text = 							$post.find('.post-text')
		$edit = 							$post.find('.post-edit')
		$files = 							$post.find('.post-files')
		$photos = 							$post.find('.post-photos')
		$footer = 							$post.find('.post-footer')
		$toolsEdit = 						$post.find('.post-tools-edit')
		$toolsRemove = 						$post.find('.post-tools-remove')
		$alertError = 						$post.find('.alert-error')
		$alertSuccess = 					$post.find('.alert-success')

		post = 								this.posts.get(id)
		text = 								post.get('message').text

		$text.show()
		$files.show()
		$photos.show()
		$edit.hide()
		$toolsEdit.hide()
		$toolsRemove.hide()
		$footer.show()

		$alertError.hide()
		$alertSuccess.hide()

	error: (id, notice = 'Произошла ошибка!') ->
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


	down: () ->
		this.limit = if this.posts.length >= 10 then this.posts.length + this.step else 10
		this.fetch()


	updating: () ->

		post = this.posts.last()

		if post?

			if post.get('seria') isnt ''

				this.update.fetch

					url: 		"#{window.sn.get('server').host}/feed/post/#{window.sn.get('region').name}/#{post.get('seria')}"
					timeout: 	10000
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
				timeout: 					20000
				dataType: 					'jsonp'

				data:
					limit:					this.limit


				beforeSend: () ->
					this.state = 			'loading'

				success: (s) => 
					this.checking()

				error: () ->
					this.state = 			'ready'


