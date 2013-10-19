
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
		this.state = 'remove'
		this.visible(id, 'remove')


	editPost: (id) ->
		this.state = 'edit'
		this.visible(id, 'edit')


	savePost: (id) ->
		this.state = 		'save'
		post = 				this.posts.get(id)
		aid = 				window.aid()

		$post = 			this.$el.find("[data-post-id=\"#{id}\"]")
		$textarea = 		$post.find('textarea')

		if window.user?
			if window.user.get('signin') is true
			
				if $textarea.val() isnt ''

					this.visible(id, 'send-start')

					this.state = 'ready'

					post.set
						message:
							text: 	$textarea.val()
					,
						silent:		true


					req = _.pick(post.toJSON(),'id','author', 'message','region')

					$.ajax
						url: 				window.sn.get('server').host + '/feed/post/'
						timeout: 			10000
						type:				'PUT'
						dataType:			'iframe'
						formData: [
							{
								name:		'model'
								value:		JSON.stringify(req)
							},
							{
								name:		'token'
								value:		window.user.get('token')
							},
							{
								name:		'sessid'
								value:		window.user.get('sessid')
							},
							{
								name:		'aid'
								value:		aid
							}
						]

						success: () =>

							this.getResultFromServer aid, id, (err, data) =>

								this.visible(id, 'send-finish')

								if err?	
									this.error(id, err)

								else								
									if data.success is true

										this.visible(id, 'blur')
										this.fetch() if !window.isSocketReady

									else 
										if data.notice?
											this.error(id, data.notice)
										else
											this.error(id)

						error: () =>
							this.visible(id, 'send-finish')
							this.error(id)


				else

					this.error(id, 'Сообщение не должно быть пустым!')


	deletePost: (id) ->
		this.state = 'ready'
		this.visible(id, 'blur')
		this.visible(id, 'hide')

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
						this.fetch() if !window.isSocketReady


	getResultFromServer: (aid, id, callback) ->

		$.ajax
			url:				window.sn.get('server').host + '/action/' + aid
			timeout: 			10000
			dataType:			'jsonp'
			
			success: (data) =>
				callback(null, data) if typeof callback is 'function'

			error: () =>
				callback('Превышено время ожидания ответа от сервера!') if typeof callback is 'function'


	visible: (id, command = 'blur') ->

		$post = 							this.$el.find("[data-post-id=\"#{id}\"]")
		textarea = 							$post.find('textarea')
		$text = 							$post.find('.post-text')
		$edit = 							$post.find('.post-edit')
		$files = 							$post.find('.post-files')
		$photos = 							$post.find('.post-photos')
		$footer = 							$post.find('.post-footer')
		$toolsEdit = 						$post.find('.post-tools-edit')
		$toolsRemove = 						$post.find('.post-tools-remove')
		$alert = 							$post.find('.alert')
		$alertSend = 						$post.find('.alert-send')

		post = 								this.posts.get(id)
		text = 								post.get('message').text

		switch command	

			when 'hide'
				$post.hide()
			
			when 'blur'
				$text.show()
				$files.show()
				$photos.show()
				$footer.show()
				$edit.hide()
				$toolsEdit.hide()
				$toolsRemove.hide()
				$alert.hide()

			when 'remove'
				$text.hide()
				$files.hide()
				$photos.hide()
				$toolsRemove.show()
				$footer.hide()

			when 'edit'
				$text.hide()
				$edit.show()
				$toolsEdit.show()
				$textarea.val(text)
				$textarea.focus()
				$footer.hide()

			when 'send-start'
				$edit.hide()
				$files.hide()
				$photos.hide()
				$footer.hide()
				$toolsEdit.hide()
				$alert.hide()
				$alertSend.show()

			when 'send-finish'
				$edit.show()
				$files.show()
				$photos.show()
				$footer.show()
				$toolsEdit.show()
				$alert.hide()


	error: (id, notice = 'Произошла ошибка!') ->
		mark = moment().unix()

		$post = 							this.$el.find("[data-post-id=\"#{id}\"]")
		$alert = 							$post.find('.alert')
		$alertError = 						$post.find('.alert-error')

		$alert.hide()
		$alertError.show().html 			notice
		$alertError.data 'mark',			mark

		setTimeout () =>
			if $alertError.data('mark') is mark
				$alertError.hide()
		, 3000



	checking: () ->
		this.state = 'ready'


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


