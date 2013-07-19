
require('jquery')
require('bootstrap')

module.exports = class snTriggers

	constructor: (@options = {}) ->

	switch: (type = '', link = '') ->
		switch type
			when 'side'
				@switchSide link
			when 'bar'
				@switchBar link

	plugins: (elem = '#main') ->

		_this = this
		setTimeout () ->
			if $(elem + ' .tooltip-toggle').length then $(elem + ' .tooltip-toggle').tooltip()
			if $.isFunction($.bootstrapIE6) then $.bootstrapIE6(elem)
			if $(elem + ' .spoiler').length then _this.spoiler(elem)
		, 1


	hover: (type = '') ->
		switch type
			when 'side'
				@switcherSide()
			when 'bar'
				@switcherBar()

	links: (type = '') ->
		switch type
			when 'side'
				@linksSide()
			when 'primary'
				@linksPrimary()
			when 'bar'
				@linksBar()

	linksSide: () ->

		console.log 'trigger: ' + 'linksSide'

		if $('#side a').length
			$('#side a').on 'click.nothing', (e) ->
				#e.preventDefault()
				if $(this).attr('href') isnt '#' and not $(this).data('noevent')
					$('#side li').removeClass('active')
					$(this).parent('li').addClass('active')
					window.events.get $(this).attr('href')
				else
					e.preventDefault()

	linksPrimary: () ->

		console.log 'trigger: ' + 'linksPrimary'

		if $('#primary a').length
			$('#primary a').on 'click', (e) ->
				#e.preventDefault()
				if $(this).attr('href') isnt '#' and not $(this).data('noevent')
					window.events.get $(this).attr('href')
				else
					e.preventDefault()

	linksBar: () ->

		console.log 'trigger: ' + 'linksBar'
		if $('#bar a').length and $('#bar li').length
			$('#bar a').on 'click', (e) ->
				#e.preventDefault()
				if $(this).attr('href') isnt '#' and $(this).data('toggle') isnt 'dropdown' and not $(this).data('noevent')
					$('#bar li').removeClass('active')
					$(this).parent('li').addClass('active')
					window.events.get $(this).attr('href')
				else
					e.preventDefault()

	switchBar: (link = 'main') ->

		###
		console.log 'trigger: ' + 'switchBar'

		$('.bar-button')
			.removeClass('bar-button-active')
			.removeClass('bar-button-hover')
			.addClass('bar-button-normal')

		$('#bar-' + link)
			.removeClass('bar-button-normal')
			.removeClass('bar-button-hover')
			.addClass('bar-button-active')
			.blur()
		###

	switchSide: (link = 'above') ->

		###
		console.log 'trigger: ' + 'switchSide'

		$('.side-box-link')
			.removeClass('side-box-link-active')
			.removeClass('side-box-link-hover')
			.addClass('side-box-link-normal')

		$('#side-' + link)
			.removeClass('side-box-link-normal')
			.removeClass('side-box-link-hover')
			.addClass('side-box-link-active')
			.blur()
		###

	switcherBar: () ->

		console.log 'trigger: ' + 'switcherBar'

		$('.bar-link').on 'mouseover', () ->
			if !$(this).parent('li').hasClass('active')
				$(this).parent('li')
					.removeClass('normal')
					.addClass('hover')

		$('.bar-link').on 'mouseleave', () ->
			if !$(this).parent('li').hasClass('active')
				$(this).parent('li')
					.removeClass('hover')
					.addClass('normal')

	switcherSide: () ->

		console.log 'trigger: ' + 'switcherSide'

		$('.side-link').on 'mouseover', () ->
			if !$(this).parent('li').hasClass('active')
				$(this).parent('li')
					.removeClass('normal')
					.addClass('hover')

		$('.side-link').on 'mouseleave', () ->
			if !$(this).parent('li').hasClass('active')
				$(this).parent('li')
					.removeClass('hover')
					.addClass('normal')

	spoiler: (elem = 'body') ->

		console.log 'trigger: ' + 'spoiler'

		$(elem).find('.spoiler-caption').on 'click', (e) ->

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


