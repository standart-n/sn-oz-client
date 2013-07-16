
# Шаблон

require('jquery')

$ ->

	class window.snLayout

		constructor: (@options = {}) ->

			# загрузка верхей панели, она фиксированная, поэтому ее див должен идти
			# непосредственно после body

			window.models.get '#bar', layout: 'bar.html', wiki: off


			# загрузка остального шаблона, который изначально хранится в jade формате и 
			# генерируется в html спомощью make'файла

			window.models.get '#main', layout: 'main.html', wiki: off


