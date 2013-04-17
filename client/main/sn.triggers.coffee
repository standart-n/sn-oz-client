$ ->

	methods =
		init: (options = {}) ->

		linksSide: () ->

			_this = this
			$('.side-box a').on 'click', () ->
				$(_this).snEvents href: $(this).attr('href')

		linksPrimary: () ->

			_this = this
			$('.primary-box a').on 'click', () ->
				$(_this).snEvents href: $(this).attr('href')

		linksBar: () ->

			_this = this
			$('a').on 'click', () ->
				$(_this).snEvents href: $(this).attr('href')

		switchBar: (options = {}) ->

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

			$('.primary-box-spoiler-caption').on 'click', () ->
				if $(this).hasClass('primary-box-spoiler-caption-open')
					$(this)
						.removeClass('primary-box-spoiler-caption-open')
						.addClass('primary-box-spoiler-caption-close')
				else
					$(this)
						.removeClass('primary-box-spoiler-caption-close')
						.addClass('primary-box-spoiler-caption-open')

				$(this).parent('.primary-box-spoiler').children('.primary-box-spoiler-body').each () ->
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
			if typeof sn == 'object' || !sn
				methods.init.apply @, arguments
			else 
				$.error 'Метод ' + sn + ' не существует'

