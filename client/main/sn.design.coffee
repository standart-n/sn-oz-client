
###
Дизайн
------
###

# пока для отображения дизайна ничего особенного не требуется, поэтому, 
# в этом плагине пока пусто

$ ->

	$this =
		init: (options = {}) ->
			# nothing
			conlole.log 'design'

# инициализация

	$.fn.snDesign = (sn = {}) ->
		if $this[sn]
			$this[sn].apply @, Array.prototype.slice.call arguments, 1
		else 
			$this.init.apply @, arguments

