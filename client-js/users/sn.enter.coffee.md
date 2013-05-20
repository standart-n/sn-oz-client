	$ ->

		methods =
			init: (options = {}) ->


			checkEnterForm: (options = {}) ->

				sn = $(this).data 'sn'
				console.log 'enter: ' + 'checkEnterForm' if console?

				alert 'enter'
				console.info 'sn', sn
				false


		$.fn.snEnter = (sn = {}) ->
			if methods[sn]
				methods[sn].apply @, Array.prototype.slice.call arguments, 1
			else 
				methods.init.apply @, arguments


