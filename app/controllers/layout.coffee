
# CLayout

LayoutBar = 		require('LayoutBar')
LayoutMain = 		require('LayoutMain')
LayoutFooter = 		require('LayoutFooter')

module.exports = class CLayout

	constructor: () ->
		
		@layoutBar = 		new LayoutBar()
		@layoutMain = 		new LayoutMain()
		@layoutFooter = 	new LayoutFooter()