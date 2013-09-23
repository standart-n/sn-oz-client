
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

		this.state = 						'ready'

		this.post = 						new Post()

		this.boxFiles = 					new FeedBoxFiles()

		this.render()

		this.$form = 						this.$el.find('form')
		this.$message = 					this.$el.find('textarea')
		this.$button = 						this.$el.find('button')
		this.$alertError = 					this.$el.find('.alert-error')
		this.$fileInput = 					this.$el.find('.feed-post-file')
		this.$fileUpload = 					this.$el.find('.feed-post-upload')

		this.showFileInput()

	
	showFileInput: () ->
		# if window.user.get('signin') is true
		# 	this.$fileInput.show()
		# 	this.fileUpload()
		# 	this.boxFiles.setElement 		'#feed-box-files'
		# else 
		# 	this.$fileInput.hide()
		this.$fileInput.hide()


	fileUpload: () ->

		# this.$fileUpload.fileupload
		# 	url: 		"#{window.sn.get('server').host}/upload/?id=#{window.user.get('id')}&key=#{window.user.get('key')}"
		# 	dataType: 	'json'
		# 	# done: (e, data) =>
		# 	# 	this.afterFileUpload(data)
		# 	done: (e, data) =>
		# 		this.afterFileUpload(data)
		# 	fail: (e, data) =>
		# 		this.error('Произошла ошибка при загрузке файла')
		# 		# alert e


	afterFileUpload: (data) ->
		# jalert(data)
		# alert data
		# console.log data

		# $('#feed').html JSON.stringify(data.toJSON())

		# $('#body').html JSON.stringify(data)

		# alert data.dataType

		if data.result?[0]
			if data.result[0].error?
				switch data.result[0].error
					when 'File is too big'
						this.error('Размер файла не должен превышать <b>10mb</b>')
					when 'User not found'
						this.error('Вы не авторизованы')
					else 
						this.error(data.error.toString())
			else 
				this.boxFiles.files.add
					name:		data.result[0].name
					original:	data.result[0].original
					type:		data.result[0].type
					size:		data.result[0].size
					url:		data.result[0].url

		else
			this.error('Ошибка при загрузке файла!')



	render: () ->
		this.template()
		new Complete
			el: 			this.el
			icons:			on


	waitSocketResponse: () ->

		if window.sockets?
			window.sockets.once 'feed.post', (data) =>
				if this.state is 'posting'
					if data.success? and data.success is true

						this.state = 			'ready'
						this.$button.button		'reset'
						this.$message.val 	 	''
						this.$el.trigger 		'send'

					else 
						if data.notice?
							this.error(data.notice)
						else
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

			this.post.set
				message:							message
				region:								window.sn.get('region')



			if message.text.length < 3
				this.error('<b>Ошибка!</b> Сообщение не должно быть пустым!')
				isUserCanSendMessage = false

			if isUserCanSendMessage is true

				req = 								_.pick(this.post.toJSON(),'message','region')

				jalert req

				this.state = 						'posting'

				this.waitSocketResponse()

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
							value:					if window.user?.get('token') then window.user.get('token') else ''
						}
					]

					beforeSend: () =>
						this.$button.button 		'loading'

					complete: (s) =>

						if s.statusText? and s.statusText is 'success'

							if window.isSocketReady

								setTimeout () =>
									if this.state isnt 'ready'
										this.$button.button		'reset'
										this.error 				'<b>Ошибка!</b> Превышен лимит ожидания!'
										this.$el.trigger 		'send'
								, 3000

							else 
									
								this.$button.button		'reset'
								this.$el.trigger 		'send'
								this.$message.val 		''


							this.post.reset()

						else
							this.error()

						# this.checking s

					error: () =>
						this.$button.button			'reset'
						this.error 					'<b>Ошибка!</b> Сервер не отвечает!'



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

