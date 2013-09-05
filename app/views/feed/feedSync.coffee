

Sync = 										require('Sync')

module.exports = Sync.extend

	urls:
		post:
			header :						'view/feed/feedNewsHeader.html'
			footer :
				date:						'view/feed/feedNewsFooterDate.html'

	startSync: () ->

		if this.posts?

			this.adding()

			this.removing()



	adding: () ->

		this.posts.on 'add', (post) =>

			if this.isFirst(this.posts,post) 
				this.prepend(post) 

			else 
				this.append(post)


			post.on 'change:formatting', () =>

				$post = 					this.$el.find("[data-post-id=\"#{post.get('id')}\"]")
				$text = 					$post.find('.post-text')

				$text.html post.get 'formatting'


			post.on 'change:author', () =>

				$post = 					this.$el.find("[data-post-id=\"#{post.get('id')}\"]")
				$header = 					$post.find('.media-heading')

				header = 					this.ejs post.toJSON(), this.urls.post.header

				$header.html header

	
			post.on 'change:message', () => 

				post.checkFormatting()

			
			setInterval () =>

				$post = 					this.$el.find("[data-post-id=\"#{post.get('id')}\"]")
				$footerDate = 				$post.find('.post-footer-date')

				footerDate = 				this.ejs post.toJSON(), this.urls.post.footer.date

				$footerDate.html footerDate

			, 60000




	removing: () ->

		this.posts.on 'remove', (post) =>

			$post = 	this.$el.find("[data-post-id=\"#{post.get('id')}\"]")

			$post.remove()





