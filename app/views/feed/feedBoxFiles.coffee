
FeedBoxSync = 								require('FeedBoxSync')
Files = 									require('Files')

module.exports = FeedBoxSync.extend

	el: 									'#feed-box-files'
	url: 									'view/feed/feedBoxFiles.html'

	initialize: () ->

		this.files = 						new Files()

		this.startSync()


