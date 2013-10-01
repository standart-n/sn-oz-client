
require('_')

Template = 									require('Template')
Post = 										require('Post')
Complete = 									require('Complete')
FeedBoxFiles = 								require('FeedBoxFiles')

module.exports = Template.extend

	el: 									'#feed-box'
	url: 									'view/feed/feedBox.html'

	events: () ->
		'submit form'						: 'submit'
		'keyup .feed-post-message'			: 'keyup'

	initialize: () ->

		this.el = 							'#feed-box'

		this.post = 						new Post()

		this.boxFiles = 					new FeedBoxFiles()

		this.render()

		this.$form = 						this.$el.find('form')
		this.$message = 					this.$el.find('textarea')
		this.$button = 						this.$el.find('button')
		this.$alertError = 					this.$el.find('.alert-error')
		this.$fileUpload = 					this.$el.find('.feed-post-upload')
		this.$fileInput = 					this.$el.find('.feed-post-input')

		this.showFileUpload()

	
	render: () ->
		this.template()
		new Complete
			el: 			this.el
			icons:			on


	showFileUpload: () ->
		if window.user.get('signin') is true
			this.boxFiles.setElement 		'#feed-box-files'
			this.$fileUpload.show()
			this.fileUpload()
		else
			this.$fileUpload.hide()		


	fileUpload: () ->
		aid = 								window.aid()

		this.$fileInput.fileupload
			url: 							"#{window.sn.get('server').host}/feed/post/upload
											?id=#{window.user.get('id')}
											&key=#{window.user.get('key')}
											&aid=#{aid}"
			timeout: 						10000
			dataType:						'json'
			done: () =>

				this.getResultFromServer aid, (data) =>

					if data.file?
						if data.file.error?
							switch data.file.error
								when 'File is too big'
									this.error('Размер файла не должен превышать <b>10mb</b>')
								when 'User not found'
									this.error('Вы не авторизованы')
								else 
									this.error(data.file.error.toString())
						else 
							this.boxFiles.files.add
								id:				data.file.id
								name:			data.file.name
								originalName:	data.file.originalName
								type:			data.file.type
								size:			data.file.size
								url:			data.file.url

					else
						this.error('Ошибка при загрузке файла!')

			error: () =>
				this.error()



	submit: (e) ->

		isUserCanSendMessage = true

		e.preventDefault()

		if window.user?

			if window.user.get('signin') isnt true
				this.$el.trigger 'not_signin'
				isUserCanSendMessage = false


			message = 
				text:								this.$message.val()

			attachments = 
				files:								if this.boxFiles?.files? then this.boxFiles.files.toJSON() else []

			this.post.set
				message:							message
				attachments:						attachments
				region:								window.sn.get('region')


			if message.text.length < 3 and isUserCanSendMessage is true
				this.error('<b>Ошибка!</b> Сообщение не должно быть пустым!')
				isUserCanSendMessage = false

			if isUserCanSendMessage is true

				req = 								_.pick(this.post.toJSON(), 'message', 'region', 'attachments')

				aid = 								window.aid()

				this.post.reset()

				$.ajax
					url: 							window.sn.get('server').host + '/feed/post/'
					timeout: 						10000
					type:							'POST'

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
						},
						{
							name:					'aid'
							value:					aid
						}
					]

					beforeSend: () =>
						this.$button.button('loading')
						setTimeout () =>
							this.$button.button('reset')
						, 400

					success: (s) =>

						this.getResultFromServer aid, (data) =>

							if data.success is true
								this.$message.val('')
								this.boxFiles.files.reset()
								if !window.isSocketReady
									this.$el.trigger('send')

							else 
								if data.notice?
									this.error(data.notice)
								else
									this.error()

					error: () =>
						this.error()




	getResultFromServer: (aid, callback) ->

		$.ajax
			url:				window.sn.get('server').host + '/action/' + aid
			timeout: 			10000
			dataType:			'jsonp'
			
			success: (data) =>
				callback(data) if callback				

			error: () =>
				this.error()



	keyup: (e) ->
		if e.keyCode is 13 and e.ctrlKey
			this.$form.submit()


	success: () ->
		this.$alertError.hide()


	error: (notice = 'Произошла ошибка!') ->

		this.$alertError.show().html(notice)

		setTimeout () =>
			this.$alertError.hide()
		, 3000

