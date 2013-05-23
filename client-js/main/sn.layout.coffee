
###
Шаблон
------
###

$ ->

	methods = 
		init: (options = {}) ->

			# загрузка верхей панели, она фиксированная, поэтому ее див должен идти
			# непосредственно после body

			$(this).snModels '#bar', layout: 'bar.html', wiki: off


			# загрузка остального шаблона, который изначально хранится в jade формате и 
			# генерируется в html спомощью make'файла

			$(this).snModels '#main', layout: 'main.html', wiki: off


	# инициализиация

	$.fn.snLayout = (sn = {}) ->
		if methods[sn]
			methods[sn].apply @, Array.prototype.slice.call arguments, 1
		else 
			methods.init.apply @, arguments

