
module.exports = class Links

	constructor: () ->

		$ () ->

			$(document).on 'click', 'a', (e) ->

				href = $(this).attr('href')

				$(document).find('.nav-links')?.each () ->
					$(this).find('li')?.each () ->
						if $(this).find('a')?.attr('href')?.match(href)
							$(this).addClass('active')
						else
							$(this).removeClass('active')
