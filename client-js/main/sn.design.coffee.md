Дизайн
------

пока для отображения дизайна ничего особенного не требуется, поэтому, 
в этом плагине пока пусто

	$ ->

		methods =
			init: (options = {}) ->
				# nothing
				conlole.log 'design' if console?

инициализация

		$.fn.snDesign = (sn = {}) ->
			if methods[sn]
				methods[sn].apply @, Array.prototype.slice.call arguments, 1
			else 
				methods.init.apply @, arguments

