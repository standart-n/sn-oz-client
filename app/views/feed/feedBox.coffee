
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

		this.post = 						new Post()

		this.fileList = 					new FeedBoxFiles()

		this.render()

		this.$form = 						this.$el.find('form')
		this.$message = 					this.$el.find('textarea')
		this.$button = 						this.$el.find('button')
		this.$alertError = 					this.$el.find('.alert-error')
		this.$alertSuccess = 				this.$el.find('.alert-success')
		this.$fileInput = 					this.$el.find('.feed-post-file')
		this.$fileUpload = 					this.$el.find('.feed-post-upload')

		this.fileUpload()
		this.showFileInput()


	showFileInput: () ->
		if window.user.get('signin') is true
			this.$fileInput.show()
		else 
			this.$fileInput.hide()


	fileUpload: () ->

		this.$fileUpload.fileupload
			url: 		"#{window.sn.get('server').host}/upload/?id=#{window.user.get('id')}&key=#{window.user.get('key')}"
			dataType: 	'json'
			done: (e, data) =>
				this.afterFileUpload(data)


	afterFileUpload: (data) ->
		if data.error?
			switch data.error
				when 'File is too big'
					this.error('Размер файла не должен превышать <b>10mb</b>')
				when 'User not found'
					this.error('Вы не авторизованы')
				else 
					this.error data.error.toString()
		else 
			# alert data.result[0].name
			this.fileList.files.add
				name:		data.result[0].name
				original:	data.result[0].original
				type:		data.result[0].type
				size:		data.result[0].size
				url:		data.result[0].url



	render: () ->
		this.template()
		new Complete
			el: 			this.el
			icons:			on


	checking: () ->

		setTimeout () =>
			this.$button.button					'reset'
		, 400

		if !this.post.get('success')
			this.error()
		else
			this.$el.trigger					'send'
			this.$message.val					''

		this.post.reset()

	submit: (e) ->


		e.preventDefault()

		if window.user?

			if window.user.get('signin') is true

				author = 
					id:									window.user.get('id')
					key:								window.user.get('key')

				message = 
					text:								this.$message.val()


				if message.text isnt ''

					this.post.save
						author:							author
						message:						message
						region:							window.sn.get('region')
					,
						url: 							window.sn.get('server').host + '/feed/post/'
						timeout: 						3000
						dataType: 						'jsonp'

						beforeSend: () =>
							this.$button.button 		'loading'

						success: (s) => 
							this.checking()

						error: () =>
							this.$button.button			'reset'
							this.error 					'<b>Ошибка!</b> Сервер не отвечает!'

			else

				this.$el.trigger 'not_signin'


	keyup: (e) ->
		if e.keyCode is 13 and e.ctrlKey
			this.$form.submit()


	success: () ->
		this.$alertError.hide()


	error: (notice = '') ->

		this.$alertError.show().html(notice)

		setTimeout () =>
			this.$alertError.hide()
		, 2000

