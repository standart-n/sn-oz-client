$ ->

	methods =
		init: (options = {}) ->

		switch: (type = '', link = '') ->
			switch type
				when 'side'
					$(this).snTriggers 'switchSide', link: link
				when 'bar'
					$(this).snTriggers 'switchBar', link: link

		plugins: (def = {}) ->

			if $.isFunction $.bootstrapIE6 then $.bootstrapIE6 def.elem
			$(def.elem+' .tooltip-toggle').tooltip()


		hover: (type = '') ->
			switch type
				when 'side'
					$(this).snTriggers 'switcherSide'
				when 'bar'
					$(this).snTriggers 'switcherBar'

		links: (type = '') ->
			switch type
				when 'side'
					$(this).snTriggers 'linksSide'
				when 'primary'
					$(this).snTriggers 'linksPrimary'
				when 'bar'
					$(this).snTriggers 'linksBar'

		linksSide: () ->

			console.log 'trigger: ' + 'linksSide' if console?

			_this = this
			$('#side a').on 'click', (e) ->
				e.preventDefault()
				if $(this).attr('href') isnt '#'
					$('#side li').removeClass('active')
					$(this).parent('li').addClass('active')
					$(_this).snEvents $(this).attr('href')

		linksPrimary: () ->

			console.log 'trigger: ' + 'linksPrimary' if console?

			_this = this
			$('#primary a').on 'click', (e) ->
				e.preventDefault()
				if $(this).attr('href') isnt '#'
					$(_this).snEvents $(this).attr('href')

		linksBar: () ->

			_this = this
			console.log 'trigger: ' + 'linksBar' if console?
			$('#bar a').on 'click', (e) ->
				e.preventDefault()
				if $(this).attr('href') isnt '#' and $(this).data('toggle') isnt 'dropdown'
					$('#bar li').removeClass('active')
					$(this).parent('li').addClass('active')
					$(_this).snEvents $(this).attr('href')

		switchBar: (options = {}) ->

			###
			console.log 'trigger: ' + 'switchBar' if console?

			def =
				link: 'main'

			$.extend def, options

			$('.bar-button')
				.removeClass('bar-button-active')
				.removeClass('bar-button-hover')
				.addClass('bar-button-normal')

			$('#bar-'+def.link)
				.removeClass('bar-button-normal')
				.removeClass('bar-button-hover')
				.addClass('bar-button-active')
				.blur()
			###

		switchSide: (options = {}) ->

			###
			console.log 'trigger: ' + 'switchSide' if console?

			def=
				link: 'above'

			$.extend(def,options)

			$('.side-box-link')
				.removeClass('side-box-link-active')
				.removeClass('side-box-link-hover')
				.addClass('side-box-link-normal')

			$('#side-'+def.link)
				.removeClass('side-box-link-normal')
				.removeClass('side-box-link-hover')
				.addClass('side-box-link-active')
				.blur()
			###

		switcherBar: () ->

			console.log 'trigger: ' + 'switcherBar' if console?

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

			console.log 'trigger: ' + 'switcherSide' if console?

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

		spoiler: () ->

			console.log 'trigger: ' + 'spoiler' if console?

			$('.spoiler-caption').on 'click', (e) ->

				e.preventDefault()

				if $(this).hasClass('spoiler-caption-open')
					$(this)
						.removeClass('spoiler-caption-open')
						.addClass('spoiler-caption-close')
				else
					$(this)
						.removeClass('spoiler-caption-close')
						.addClass('spoiler-caption-open')

				$(this).parent('.spoiler').children('.spoiler-body').each () ->
					if $(this).hasClass('spoiler-status-open')
						$(this)
							.removeClass('spoiler-status-open')
							.addClass('spoiler-status-close')
							.hide()
					else
						$(this)
							.removeClass('spoiler-status-close')
							.addClass('spoiler-status-open')
							.show()


	$.fn.snTriggers = (sn = {}) ->
		if methods[sn]
			methods[sn].apply @, Array.prototype.slice.call arguments, 1
		else 
			methods.init.apply @, arguments

