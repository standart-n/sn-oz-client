
require('widget')
require('iframeTransport')
require('fileUpload')

Template = 									require('Template')
FeedBox = 									require('FeedBox')
FeedNews = 									require('FeedNews')
AboutView = 								require('AboutView')

module.exports = Template.extend

	el: 									'#feed'
	url: 									'view/feed/feed.html'

	initialize: () ->

		_this = this

		this.aboutView = 					new AboutView()


		if window.user?
			window.user.on 'change:signin', () =>
				if window.user.get('signin') is true
					if this.news?
						this.news.fetch()
					if this.box?
						this.box.showFileUpload()


		$(document).on 'scrollDown', () ->	
			if _this.news?
				_this.news.down()


		$(document).on 'click', '[data-action="delete file"]', (e) ->

			e.preventDefault()

			if $(this).data('file') and _this.box?.boxFiles?.files?
				_this.box.boxFiles.files.remove $(this).data('file')


		$(document).on 'click', '[data-action="edit post"]', (e) ->

			e.preventDefault()

			if $(this).data('post') and _this.news?
				_this.news.editPost $(this).data('post')


		$(document).on 'click', '[data-action="save post"]', (e) ->

			e.preventDefault()

			if $(this).data('post') and _this.news?
				_this.news.savePost $(this).data('post')


		$(document).on 'keyup', '.feed-post-edit', (e) ->

			if e.keyCode is 13 and e.ctrlKey

				if $(this).data('post') and _this.news?
					_this.news.savePost $(this).data('post')


			if e.keyCode is 27

				if $(this).data('post') and _this.news?
					_this.news.visible $(this).data('post'), 'blur'



		$(document).on 'click', '[data-action="blur post"]', (e) ->

			e.preventDefault()

			if $(this).data('post') and _this.news?
				_this.news.visible $(this).data('post'), 'blur'



		$(document).on 'click', '[data-action="remove post"]', (e) ->

			e.preventDefault()

			if $(this).data('post') and _this.news?
				_this.news.removePost $(this).data('post')


		$(document).on 'click', '[data-action="delete post"]', (e) ->

			e.preventDefault()

			if $(this).data('post')
				_this.news.deletePost $(this).data('post')


		if window.sockets?
			window.sockets.on 'feed.update', () =>
				this.news.fetch() if this.news?


		setInterval () =>

			if this.news? and !window.isSocketReady
				this.news.updating()

		, 60000


	render: (el = '#feed') ->

		if el?
			this.setElement(el)

		this.template()
		this.box.remove()					if this.box?
		this.news.remove()					if this.news?
		this.box = 							new FeedBox()
		this.news = 						new FeedNews()

		this.box.$el.on 'send', () =>
			if this.news?
				this.news.fetch()

		this.box.$el.on 'not_signin', () =>
			if this.aboutView?
				this.aboutView.show()


