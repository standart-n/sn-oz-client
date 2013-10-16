
FeedBoxSync = 								require('FeedBoxSync')
Files = 									require('Files')

module.exports = FeedBoxSync.extend

	el: 									'#feed-box-photos'
	url: 									'view/feed/feedBoxPhotos.html'

	initialize: () ->

		this.files = 						new Files()

		this.startSync()


