
require('_')

Template = 									require('Template')
Post = 										require('Post')
Complete = 									require('Complete')
FeedBoxFiles = 								require('FeedBoxFiles')
FeedBoxPhotos = 							require('FeedBoxPhotos')

module.exports = Template.extend

	el: 									'#feed-box'
	url: 									'view/feed/feedBox.html'

	events: () ->
		'submit form'						: 'submit'
		'keyup .feed-post-message'			: 'areaKeyup'
		'focus .feed-post-message'			: 'areaFocus'
		'blur .feed-post-message'			: 'areaBlur'

	initialize: () ->

		this.el = 							'#feed-box'

		this.status = 						'ready'

		this.post = 						new Post()

		this.boxFiles = 					new FeedBoxFiles()
		this.boxPhotos = 					new FeedBoxPhotos()

		this.render()

		this.$form = 						this.$el.find('form')
		this.$textarea = 					this.$el.find('textarea')

		this.$buttonSend = 					this.$el.find('.feed-post-send')
		this.$fileUpload = 					this.$el.find('.feed-post-upload')
		this.$fileInput = 					this.$el.find('.feed-post-input')
		this.$toolbar = 					this.$el.find('.feed-post-toolbar')
		this.$attachments = 				this.$el.find('.feed-post-attachments')

		this.$alert = 						this.$el.find('.alert')
		this.$alertError = 					this.$el.find('.alert-error')
		this.$alertUpload = 				this.$el.find('.alert-upload')
		this.$alertSend = 					this.$el.find('.alert-send')

		this.showFileUpload()

	
	render: () ->
		this.template()

		new Complete
			el: 			this.el
			icons:			on


	state: (status, message) ->

		if !status?
			return this.status
		else
			switch status

				when 'upload'
					this.$alertUpload.show()
					this.$toolbar.hide()
					this.status = 'upload'


				when 'send'
					this.$alertSend.show()
					this.$textarea.hide()
					this.$toolbar.hide()
					this.$attachments.hide()
					this.status = 'send'

				
				when 'error'			
					if this.status is 'upload'
						if message?
							switch message
								when 'File is too big'
									this.error('Размер файла не должен превышать <b>10mb</b>')
								when 'User not found'
									this.error('Вы не авторизованы')
								else 
									this.error(message.toString())
						else
							this.error('Ошибка при загрузке файла!')

						this.$alertUpload.hide()
						this.$toolbar.show()

					if this.status is 'send'

						this.$alertSend.hide()
						this.$textarea.show()
						this.$toolbar.show()
						this.$attachments.show()

						if message?
							this.error(message.toString())
						else
							this.error('Ошибка при отправке сообщения!')

					this.status = 'ready'


				when 'ready'
					if this.status is 'upload'

						this.$alertUpload.hide()
						this.$toolbar.show()

					if this.status is 'send'

						this.$alertSend.hide()
						this.$textarea.show()
						this.$toolbar.show()
						this.$attachments.show()

						this.$textarea.val('')
						this.boxFiles.files.reset()
						this.boxPhotos.files.reset()
						this.areaBlur()
						this.$el.trigger('send') if !window.isSocketReady


					this.status = 'ready'


	showFileUpload: () ->
		if window.user.get('signin') is true
			this.boxFiles.setElement 		'#feed-box-files'
			this.boxPhotos.setElement 		'#feed-box-photos'
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
			timeout: 						20000
			dataType:						'json'

			beforeSend: () =>
				this.state('upload')

			done: () =>

				this.getResultFromServer aid, (err, data) =>

					if err? 
						this.state('error', err) 

					else

						if data?.file?
							if data.file.error?
								this.state('error', data.file.error)

							else 

								this.state('ready')

								store = if data.file.type.match /^image/ then this.boxPhotos else this.boxFiles

								store.files.add
									id:				data.file.id
									name:			data.file.name
									originalName:	data.file.originalName
									type:			data.file.type
									size:			data.file.size
									thumbnail:		data.file.thumbnail
									preview:		data.file.preview
									url:			data.file.url

						else
							this.state('error')


			fail: () =>
				this.state('error')



	submit: (e) ->

		isUserCanSendMessage = true

		e.preventDefault()

		if window.user?

			if window.user.get('signin') isnt true
				this.$el.trigger 'not_signin'
				isUserCanSendMessage = false

			message = 
				text:				this.$textarea.val()
			
			attachments = 
				files:				this.getAttachments()			

			this.post.set
				message:			message
				attachments:		attachments
				region:				window.sn.get('region')


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
						this.state('send')

					success: (s) =>

						this.getResultFromServer aid, (err, data) =>

							if err?
								this.state('error', err)

							else

								if data? and data.success is true
									this.state('ready')
								else 
									if data.notice?
										this.state('error', data.notice)
									else
										this.state('error')

					error: () =>
						this.state('error')




	getResultFromServer: (aid, callback) ->

		$.ajax
			url:				window.sn.get('server').host + '/action/' + aid
			timeout: 			10000
			dataType:			'jsonp'
			
			success: (data) =>
				callback(null, data) if callback

			error: () =>
				callback('Превышено время ожидания ответа от сервера!') if callback



	getAttachments: () ->

		folder = []

		folder.push this.boxPhotos.files.toJSON() if this.boxPhotos?.files?

		folder.push this.boxFiles.files.toJSON() if this.boxFiles?.files?

		_.flatten folder, true


	areaKeyup: (e) ->
		if e.keyCode is 13 and e.ctrlKey
			this.$form.submit()

	areaFocus: () ->
		this.$textarea.attr 'rows', 10

	areaBlur: () ->
		if this.$textarea.val() is ''
			this.$textarea.attr 'rows', 5


	error: (notice = 'Произошла ошибка!') ->

		this.$alertError.show().html(notice)

		setTimeout () =>
			this.$alertError.hide()
		, 3000

