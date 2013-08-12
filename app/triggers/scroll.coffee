
require('jquery')

module.exports = class Spoiler

	constructor: () ->

		$ () ->


			$(window).on 'scroll', () =>

				scrollTop = 					$(document).scrollTop()
				documentHeight = 				$(document).height()
				windowHeight = 					$(window).height()

				if (documentHeight - windowHeight) <= scrollTop
					$(document).trigger 		'scrollDown'

