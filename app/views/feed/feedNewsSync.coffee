
Sync = 										require('Sync')
Complete = 									require('Complete')

module.exports = Sync.extend

	urls:
		post:
			header :						'view/feed/feedNewsHeader.html'
			footer :
				date:						'view/feed/feedNewsFooterDate.html'
				tools:						'view/feed/feedNewsFooterTools.html'

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


			$post = 						this.$el.find("[data-post-id=\"#{post.get('id')}\"]")
			$header = 						$post.find('.media-heading')
			$text = 						$post.find('.post-text')
			$photos = 						$post.find('.post-photos')
			$footerTools = 					$post.find('.post-footer-tools')
			$footerDate = 					$post.find('.post-footer-date')


			post.on 'change:formatting', () =>

				$text.html post.get 'formatting'


			post.on 'change:author', () =>

				header = 					this.ejs post.toJSON(), this.urls.post.header

				$header.html header


			post.on 'change:our', () =>

				footerTools = 				this.ejs post.toJSON(), this.urls.post.footer.tools

				$footerTools.html footerTools


			setTimeout () =>
				$photos.isotope
					layoutMode:					'masonry'
			, 10


			new Complete
				el: 		$post
				icons:		on
				tooltips:	off
	
			
			setInterval () =>

				footerDate = 				this.ejs post.toJSON(), this.urls.post.footer.date

				$footerDate.html footerDate

			, 60000




	removing: () ->

		this.posts.on 'remove', (post) =>

			$post = 	this.$el.find("[data-post-id=\"#{post.get('id')}\"]")

			$post.remove()





