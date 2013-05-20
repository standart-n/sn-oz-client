
Старт приложения

	$ ->
		methods =
			init: (options = {}) ->

начальное состояние объекта sn

				sn =
					levels:{} // адрес, по которому был сделан последний переход
					users:{}
					content:{}
					result:{}

				$.extend true, sn, options
				$(this).data 'sn', sn

загрузка конфигов

				console.log 'configuration...' if console?
				$(this).snConf()

загрузка оболочки и дизайна

				console.log 'layout...' if console?
				$(this).snLayout()

отображение начальной страницы по событию #autoload

				console.log 'autoload...' if console?
				$(this).snEvents '#autoload'

инициализация
```coffeescript

		$.fn.sn = (sn = {}) ->
			if methods[sn]
				methods[sn].apply @, Array.prototype.slice.call arguments, 1
			else 
				methods.init.apply @, arguments
```
