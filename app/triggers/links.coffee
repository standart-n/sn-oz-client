
require('_')
require('jquery')

module.exports = class Links


	constructor: (@options = {}) ->

		this.defaults =
			auto: on

		_.defaults(this.options,this.defaults)

		$ () =>
			if this.options.auto is on
				$(document).on 'click', 'a', (e) =>
					this.switch()

	switch: (href) ->
		
		href = window.location.href.replace(/.*(?=#[^\s]+$)/, '') if !href?

		$(document).find('.nav-links')?.each () ->
			$(this).find('li')?.each () ->
				if $(this).find('a')?.attr('href')?.match(href)
					$(this).addClass('active')
					$(this).find('i').addClass('icon-white')
				else
					$(this).removeClass('active')
					$(this).find('i').removeClass('icon-white')
