
# spoiler

require('_')

module.exports = class Spoiler

	constructor: () ->

		$ () ->

			$(document).on 'click', '.spoiler-caption', (e) ->

				e.preventDefault()

				if $(this).hasClass('spoiler-open')
					$(this)
						.removeClass('spoiler-open')
						.addClass('spoiler-close')
				else
					$(this)
						.removeClass('spoiler-close')
						.addClass('spoiler-open')

				$(this).parent('.spoiler').children('.spoiler-body').each () ->
					if $(this).hasClass('spoiler-open')
						$(this)
							.removeClass('spoiler-open')
							.addClass('spoiler-close')
							.hide()
					else
						$(this)
							.removeClass('spoiler-close')
							.addClass('spoiler-open')
							.show()

