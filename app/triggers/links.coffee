
require('_')
require('jquery')

module.exports = class Links


	constructor: (@options = {}) ->

		defaults =
			auto: on

		_.defaults(this.options,this.defaults)

		$ () =>
			if this.options.auto is on
				$(document).on 'click', 'a', (e) =>
					this.switch()

	switch: () ->
		href = window.location.href.replace(/.*(?=#[^\s]+$)/, '')

		$(document).find('.nav-links')?.each () ->
			$(this).find('li')?.each () ->
				if $(this).find('a')?.attr('href')?.match(href)
					$(this).addClass('active')
				else
					$(this).removeClass('active')
