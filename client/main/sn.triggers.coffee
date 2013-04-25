$ ->

	methods =
		init: (options = {}) ->

		switch: (type = '', link = '') ->
			switch type
				when 'side'
					$(this).snTriggers 'switchSide', link: link
				when 'bar'
					$(this).snTriggers 'switchBar', link: link

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
			$('#side a').on 'click', () ->
				$(_this).snEvents $(this).attr('href')

		linksPrimary: () ->

			console.log 'trigger: ' + 'linksPrimary' if console?

			_this = this
			$('#primary a').on 'click', () ->
				$(_this).snEvents $(this).attr('href')

		linksBar: () ->

			_this = this
			console.log 'trigger: ' + 'linksBar' if console?
			$('a').on 'click', () ->
				$(_this).snEvents $(this).attr('href')

		switchBar: (options = {}) ->

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

		switchSide: (options = {}) ->

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

		switcherBar: () ->

			console.log 'trigger: ' + 'switcherBar' if console?

			$('.bar-button').on 'mouseover', () ->
				if !$(this).hasClass('bar-button-active')
					$(this)
						.removeClass('bar-button-normal')
						.addClass('bar-button-hover')

			$('.bar-button').on 'mouseleave', () ->
				if !$(this).hasClass('bar-button-active')
					$(this)
						.removeClass('bar-button-hover')
						.addClass('bar-button-normal')

		switcherSide: () ->

			console.log 'trigger: ' + 'switcherSide' if console?

			$('.side-box-link').on 'mouseover', () ->
				if !$(this).hasClass('side-box-link-active')
					$(this)
						.removeClass('side-box-link-normal')
						.addClass('side-box-link-hover')

			$('.side-box-link').on 'mouseleave', () ->
				if !$(this).hasClass('side-box-link-active')
					$(this)
						.removeClass('side-box-link-hover')
						.addClass('side-box-link-normal')

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

