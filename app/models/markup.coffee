
# Markup

require('_')

module.exports = class Markup

	constructor: (@options = {}) ->

		this.defaults = 
			images:
				url: ''
			files:
				url: ''
			gismeteo:
				url: ''

		_.defaults(this.options,this.defaults)


	render: (text) ->

		#text = text.toString()
		text = @before(text)					# предоработка
		text = @formating(text)					# жирный и курсив
		text = @headings(text)					# заголовки
		text = @icons(text)						# иконки
		text = @externalLinks(text)				# внешние ссылки
		text = @fileLinks(text)					# ссылки на файлы
		text = @internalLinks(text)				# внутренние ссылки
		text = @mailTo(text)					# ссылки на email-адреса
		text = @image(text)						# изображения
		text = @fonts(text)						# шрифты
		text = @anchor(text)					# якоря
		text = @ind(text)						# абзацы
		text = @weather(text)					# погода
		text = @spoiler(text)					# спойлеры
		text = @header(text)					# заголовки с подчеркиванием
		text = @spaces(text)					# переносы строк
		text = @noevent(text)					# пустые ссылки ( href="#" )
		text


	before: (text) ->

		text
			.replace(/\|\n/g, '')
			.replace(/\]\n\n/g, ']<br><br>')
			.replace(/\]\n/g, ']<br>')
			.replace(/>\n\n/g, '>\n')

	formating: (text) ->

		text
			# ''''' bold and italic '''''
			.replace(/'''''(.*?)'''''/g, "<i><b>$1</b></i>")
			# ''' bold '''
			.replace(/'''(.*?)'''/g, "<b>$1</b>")
			# '' italic ''
			.replace(/''(.*?)''/g, "<i>$1</i>")

	headings: (text) ->

		# ======h6======
		text = `text.replace(/======(.*?)======\n?/g, "<h6>$1</h6>")`
		# =====h5=====
		text = `text.replace(/=====(.*?)=====\n?/g, "<h5>$1</h5>")`
		# ====h4====
		text = `text.replace(/====(.*?)====\n?/g, "<h4>$1</h4>")`
		# ===h3===
		text = `text.replace(/===(.*?)===\n?/g, "<h3>$1</h3>")`
		# ==h2==
		text = `text.replace(/==(.*?)==\n?/g, "<h2>$1</h2>")`

	icons: (text) ->

		text
			# [i:icon-refresh white]
			.replace(/\[(i|ico|icon|icons):icon-([a-zA-Z0-9\_\-]+)[\s]+(inverse|white)\]/g, '<i class="icon-$2 icon-white"></i> ')
			# [i:refresh white]
			.replace(/\[(i|ico|icon|icons):([a-zA-Z0-9\_\-]+)[\s]+(inverse|white)\]/g, '<i class="icon-$2 icon-white"></i> ')
			# [i:icon-refresh]
			.replace(/\[(i|ico|icon|icons):icon-([a-zA-Z0-9\_\-]+)\]/g, '<i class="icon-$2"></i> ')
			# [i:refresh]
			.replace(/\[(i|ico|icon|icons):([a-zA-Z0-9\_\-]+)\]/g, '<i class="icon-$2"></i> ')

			# i:icon-refresh white
			.replace(/([\s]+)(i|ico|icon|icons):icon-([a-zA-Z0-9\_\-]+)[\s]+(inverse|white)([\s]+)/g, '$1<i class="icon-$3 icon-white"></i>$4')
			# i:refresh white
			.replace(/([\s]+)(i|ico|icon|icons):([a-zA-Z0-9\_\-]+)[\s]+(inverse|white)([\s]+)/g, '$1<i class="icon-$3 icon-white"></i>$4')
			# i:icon-refresh
			.replace(/([\s]+)(i|ico|icon|icons):icon-([a-zA-Z0-9\_\-]+)([\s]+)/g, '$1<i class="icon-$3"></i>$4')
			# i:refresh
			.replace(/([\s]+)(i|ico|icon|icons):([a-zA-Z0-9\_\-]+)([\s]+)/g, '$1<i class="icon-$3"></i>$4')

	internalLinks: (text) ->

		text
			# [buttom primary #main/text/main На главную | Подсказка bottom]
			.replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+(left|top|right|bottom)\]/g, '<a href="#$3" class="btn btn-$2 tooltip-toggle" data-placement="$6" rel="tooltip" title="$5">$4</a>')
			# [buttom primary #main/text/main На главную | Подсказка]
			.replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="#$3" class="btn btn-$2 tooltip-toggle" rel="tooltip" title="$5">$4</a>')
			# [buttom primary #main/text/main | Подсказка bottom]
			.replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+(left|top|right|bottom)\]/g, '<a href="#$3" class="btn btn-$2 tooltip-toggle" data-placement="$5" rel="tooltip" title="$4">$3</a>')
			# [buttom primary #main/text/main | Подсказка]
			.replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="#$3" class="btn btn-$2 tooltip-toggle" rel="tooltip" title="$4">$3</a>')
			# [buttom primary #main/text/main На главную]
			.replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a class="btn btn-$2" href="#$3">$4</a>')
			# [buttom primary #main/text/main]
			.replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+#([a-zA-Z0-9\-\.\/\?%\#_\:]+)\]/g, '<a class="btn btn-$2" href="#$1">$1</a>')

			# [buttom #main/text/main На главную | Подсказка bottom]
			.replace(/\[b(tn|utton)[\s]+#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+(left|top|right|bottom)\]/g, '<a href="#$2" class="btn tooltip-toggle" data-placement="$5" rel="tooltip" title="$4">$3</a>')
			# [buttom #main/text/main На главную | Подсказка]
			.replace(/\[b(tn|utton)[\s]+#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g,'<a href="#$2" class="btn tooltip-toggle" rel="tooltip" title="$4">$3</a>')
			# [buttom #main/text/main | Подсказка bottom]
			.replace(/\[b(tn|utton)[\s]+#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+(left|top|right|bottom)\]/g, '<a href="#$2" class="btn tooltip-toggle" data-placement="$4" rel="tooltip" title="$3">$2</a>')
			# [buttom #main/text/main | Подсказка]
			.replace(/\[b(tn|utton)[\s]+#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="#$2" class="btn tooltip-toggle" rel="tooltip" title="$3">$2</a>')
			# [buttom #main/text/main На главную]
			.replace(/\[b(tn|utton)[\s]+#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a class="btn" href="#$2">$3</a>')
			# [buttom #main/text/main]
			.replace(/\[b(tn|utton)[\s]+#([a-zA-Z0-9\-\.\/\?%\#_\:]+)\]/g, '<a href="#$1">$1</a>')

			# [#main/text/main На главную | Подсказка bottom]
			.replace(/\[#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+(left|top|right|bottom)\]/g, '<a href="#$1" class="tooltip-toggle" data-placement="$4" rel="tooltip" title="$3">$2</a>')
			# [#main/text/main На главную | Подсказка]
			.replace(/\[#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="#$1" class="tooltip-toggle" rel="tooltip" title="$3">$2</a>')
			# [#main/text/main | Подсказка bottom]
			.replace(/\[#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+(left|top|right|bottom)\]/g, '<a href="#$1" class="tooltip-toggle" data-placement="$3" rel="tooltip" title="$2">$1</a>')
			# [#main/text/main | Подсказка]
			.replace(/\[#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="#$1" class="tooltip-toggle" rel="tooltip" title="$2">$1</a>')
			# [#main/text/main На главную]
			.replace(/\[#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="#$1">$2</a>')
			# [#main/text/main]
			.replace(/\[#([a-zA-Z0-9\-\.\/\?%\#_\:]+)\]/g, '<a href="#$1">$1</a>')
			# #main/text/main
			.replace(/([\s+])#([a-zA-Z0-9\-\.\/\?%\#_\:]+)([\s]+)/g, '$1<a href="#$2">$2</a>$3')

	externalLinks: (text) ->

		text
			# [buttom primary http://yandex.ru Яндекс | Подсказка bottom]
			.replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+) (left|top|right|bottom)\]/g, '<a href="http://$3" class="btn btn-$2 tooltip-toggle" data-placement="$6" rel="tooltip" title="$5" target="_blank">$4</a>')				
			# [buttom primary http://yandex.ru Яндекс | Подсказка]
			.replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="http://$3" class="btn btn-$2 tooltip-toggle" rel="tooltip" title="$5" target="_blank">$4</a>')				
			# [buttom primary http://yandex.ru | Подсказка bottom]
			.replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+(left|top|right|bottom)\]/g, '<a href="http://$3" class="btn btn-$2 tooltip-toggle" data-placement="$5" rel="tooltip" title="$4" target="_blank">$3</a>')				
			# [buttom primary http://yandex.ru | Подсказка]
			.replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="http://$3" class="btn btn-$2 tooltip-toggle" rel="tooltip" title="$4" target="_blank">$3</a>')				
			# [buttom primary http://yandex.ru Яндекс]
			.replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="http://$3" class="btn btn-$2" target="_blank">$4</a>')				
			# [buttom primary http://yandex.ru]
			.replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)\]/g, '<a class="btn btn-$2" href="http://$2" target="_blank">$2</a>')

			# [buttom http://yandex.ru Яндекс | Подсказка bottom]
			.replace(/\[b(tn|utton)[\s]+https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+) (left|top|right|bottom)\]/g, '<a href="http://$2" class="btn tooltip-toggle" data-placement="$5" rel="tooltip" title="$4" target="_blank">$3</a>')
			# [buttom http://yandex.ru Яндекс | Подсказка]
			.replace(/\[b(tn|utton)[\s]+https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="http://$2" class="btn tooltip-toggle" rel="tooltip" title="$4" target="_blank">$3</a>')
			# [buttom http://yandex.ru | Подсказка bottom]
			.replace(/\[b(tn|utton)[\s]+https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+(left|top|right|bottom)\]/g, '<a href="http://$2" class="btn tooltip-toggle" data-placement="$4" rel="tooltip" title="$3" target="_blank">$2</a>')
			# [buttom http://yandex.ru | Подсказка]
			.replace(/\[b(tn|utton)[\s]+https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="http://$2" class="tooltip-toggle" rel="tooltip" title="$3" target="_blank">$2</a>')
			# [buttom http://yandex.ru Яндекс]
			.replace(/\[b(tn|utton)[\s]+https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a class="btn" href="http://$2" target="_blank">$3</a>')
			# [buttom http://yandex.ru]
			.replace(/\[b(tn|utton)[\s]+https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)\]/g, '<a class="btn" href="http://$2" target="_blank">$2</a>')

			# [http://yandex.ru Яндекс | Подсказка bottom]
			.replace(/\[https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+(left|top|right|bottom)\]/g, '<a href="http://$1" class="tooltip-toggle" data-placement="$4" rel="tooltip" title="$3" target="_blank">$2</a>')
			# [http://yandex.ru Яндекс | Подсказка]
			.replace(/\[https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="http://$1" class="tooltip-toggle" rel="tooltip" title="$3" target="_blank">$2</a>')
			# [http://yandex.ru | Подсказка bottom]
			.replace(/\[https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+(left|top|right|bottom)\]/g, '<a href="http://$1" class="tooltip-toggle" data-placement="$3" rel="tooltip" title="$2" target="_blank">$1</a>')
			# [http://yandex.ru | Подсказка]
			.replace(/\[https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="http://$1" class="tooltip-toggle" rel="tooltip" title="$2" target="_blank">$1</a>')
			# [http://yandex.ru Яндекс]
			.replace(/\[https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="http://$1" target="_blank">$2</a>')
			# [http://yandex.ru]
			.replace(/\[https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)\]/g, '<a href="http://$1" target="_blank">$1</a>')				
			# http://yandex.ru
			.replace(/([\s]+)https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)([\s]+)/g, '$1<a href="http://$2" target="_blank">$2</a>$3')

	fileLinks: (text) ->

		text
			# [buttom primary file:20120322/download.zip Скачать | Подсказка bottom]
			.replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+(left|top|right|bottom)\]/g, '<a href="' + @options.files.url + '$3" class="btn btn-$2 tooltip-toggle" rel="tooltip" data-placement="$6" title="$5" target="_blank">$4</a>')
			# [buttom primary file:20120322/download.zip Скачать | Подсказка]
			.replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="' + @options.files.url + '$3" class="btn btn-$2 tooltip-toggle" rel="tooltip" title="$5" target="_blank">$4</a>')
			# [buttom primary file:20120322/download.zip Скачатьа bottom]
			.replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+(left|top|right|bottom)\]/g, '<a href="' + @options.files.url + '$3" class="btn btn-$2 tooltip-toggle" rel="tooltip" data-placement="$5" title="$4" target="_blank">$3</a>')
			# [buttom primary file:20120322/download.zip Скачать | Подсказка]
			.replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="' + @options.files.url + '$3" class="btn btn-$2 tooltip-toggle" rel="tooltip" title="$4" target="_blank">$3</a>')
			# [buttom primary file:20120322/download.zip Скачать]
			.replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a class="btn btn-$2" href="' + @options.files.url + '$3" target="_blank">$4</a>')
			# [buttom primary file:20120322/download.zip]
			.replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)\]/g, '<a class="btn btn-$2" href="' + @options.files.url + '$3" target="_blank">$3</a>')

			# [buttom file:20120322/download.zip Скачать | Подсказка bottom]
			.replace(/\[b(tn|utton)[\s]+files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+(left|top|right|bottom)\]/g, '<a href="' + @options.files.url + '$2" class="btn tooltip-toggle" rel="tooltip" data-placement="$5" title="$4" target="_blank">$3</a>')
			# [buttom file:20120322/download.zip Скачать | Подсказка]
			.replace(/\[b(tn|utton)[\s]+files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="' + @options.files.url + '$2" class="btn tooltip-toggle" rel="tooltip" title="$4" target="_blank">$3</a>')
			# [buttom file:20120322/download.zip Скачатьа bottom]
			.replace(/\[b(tn|utton)[\s]+files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+(left|top|right|bottom)\]/g, '<a href="' + @options.files.url + '$2" class="btn tooltip-toggle" rel="tooltip" data-placement="$4" title="$3" target="_blank">$2</a>')
			# [buttom file:20120322/download.zip Скачатьа | Подсказка]
			.replace(/\[b(tn|utton)[\s]+files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="' + @options.files.url + '$2" class="btn tooltip-toggle" rel="tooltip" title="$3" target="_blank">$2</a>')
			# [buttom file:20120322/download.zip Скачать]
			.replace(/\[b(tn|utton)[\s]+files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a class="btn" href="' + @options.files.url + '$2" target="_blank">$3</a>')
			# [buttom file:20120322/download.zip]
			.replace(/\[b(tn|utton)[\s]+files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)\]/g, '<a class="btn" href="' + @options.files.url + '$2" target="_blank">$2</a>')

			# [file:20120322/download.zip Скачать | Подсказка bottom]
			.replace(/\[files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+(left|top|right|bottom)\]/g, '<a href="' + @options.files.url + '$1" class="tooltip-toggle" rel="tooltip" data-placement="$4" title="$3" target="_blank">$2</a>')
			# [file:20120322/download.zip Скачать | Подсказка]
			.replace(/\[files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="' + @options.files.url + '$1" class="tooltip-toggle" rel="tooltip" title="$3" target="_blank">$2</a>')
			# [file:20120322/download.zip Скачатьа bottom]
			.replace(/\[files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+(left|top|right|bottom)\]/g, '<a href="' + @options.files.url + '$1" class="tooltip-toggle" rel="tooltip" data-placement="$3" title="$2" target="_blank">$1</a>')
			# [file:20120322/download.zip Скачатьа | Подсказка]
			.replace(/\[files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="' + @options.files.url + '$1" class="tooltip-toggle" rel="tooltip" title="$2" target="_blank">$1</a>')
			# [file:20120322/download.zip Скачать]
			.replace(/\[files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="' + @options.files.url + '$1" target="_blank">$2</a>')
			# [file:20120322/download.zip]
			.replace(/\[files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)\]/g, '<a href="' + @options.files.url + '$1" target="_blank">$1</a>')				
			# file:20120322/download.zip
			.replace(/([\s]+)files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)([\s]+)/g, '$1<a href="' + @options.files.url + '$2" target="_blank">$2</a>$3')

	mailTo: (text) ->

		text
			# [email:aleksnick@list.ru Отправить письмо]
			.replace(/\[e\-?mail:([a-zA-Z0-9@\-\.\/\?%\#_]+)[\s]+(.*?)\]/g, '<a href="mailto:$1">$2</a>')
			# [email:aleksnick@list.ru]
			.replace(/\[e\-?mail:([a-zA-Z0-9@\-\.\/\?%\#_]+)\]/g, '<a href="mailto:$1">$1</a>')

	image: (text, options) ->

		text
			# [image:20130523/image.png left]
			.replace(/\[(img|image|picture|photo):([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+(right|left)\]/g,'<img class="pull-$3" src="' + @options.images.url + '$2">')
			# [image:20130523/image.png]
			.replace(/\[(img|image|picture|photo):([a-zA-Z0-9\-\.\/\?\%\#\_]+)\]/g,'<img src="' + @options.images.url + '$2">')
			
			# image:20130523/image.png left
			.replace(/([\s]+)(img|image|picture|photo):([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+(right|left)([\s]+)/g,'$1<img class="pull-$4" src="' + @options.images.url + '$3">$5')
			# image:20130523/image.png
			.replace(/([\s]+)(img|image|picture|photo):([a-zA-Z0-9\-\.\/\?\%\#\_]+)([\s]+)/g,'$1<img src="' + @options.images.url + '$3">$4')

	fonts: (text) ->

		text
			# [badge success Бэйдж]
			.replace(/\[badge[\s]+(success|warning|important|info|inverse)\][\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)/g, '<span class="badge badge-$1">$2</span>')
			# [badge Бэйдж success]
			.replace(/\[badge[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+(success|warning|important|info|inverse)\]/g, '<span class="badge badge-$2">$1</span>')
			# [badge Бэйдж]
			.replace(/\[badge[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<span class="badge">$1</span>')

			# [label success Лэйбл]
			.replace(/\[label[\s]+(success|warning|important|info|inverse)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<span class="label label-$1">$2</span>')
			# [label Лэйбл success]
			.replace(/\[label[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+(success|warning|important|info|inverse)\]/g, '<span class="label label-$2">$1</span>')
			# [label Лэйбл]
			.replace(/\[label[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<span class="label">$1</span>')

			# [color:#ff0000 Текст]
			.replace(/\[color:\#([a-zA-Z0-9]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<font style="color:#$1">$2</font>')
			# [color:red Текст]
			.replace(/\[color:([a-zA-Z0-9]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<span class="$1">$2</span>')
			# [[color:#ff0000] Текст]
			.replace(/\[\[color:\#([a-zA-Z0-9]+)\](.*?)\]/g, '<font style="color:#$1">$2</font>')
			# [[color:red] Текст]
			.replace(/\[\[color:([a-zA-Z0-9]+)\](.*?)\]/g, '<span class="$1">$2</span>')


	ind: (text) ->

		text
			# <<<reestr
			.replace(/<<<\#?\:?([a-zA-Z0-9\-\.\/\?\_]+)\n?/g, '<div class="well well-small"><a id="anchor-$1"></a>')
			# <<<
			.replace(/<<<\n?/g, '<div class="well well-small">')
			# >>>
			.replace(/>>>\n?/g, '</div>')

	anchor: (text) ->

		text
			# [anchor:reestr] -> <a id="anchor-reestr"></a> Якорь
			.replace(/\[anchor:([a-zA-Z0-9\-\.\/\?\%\#\_]+)\]\n?/g, '<a id="anchor-$1"></a>')

	weather: (text) ->

		# [gismeteo]
		text.replace(/\[gismeteo\]\n?/g, '<iframe src="' + @options.gismeteo.url + '" width="96%" height="160" scrolling="no" marginheight="0" marginwidth="0" frameborder="0"></iframe>&nbsp;')

	spoiler: (text) ->

		text
			# <<[button primary Заголовок спойлера]
			# текст спойлера
			# >>
			.replace(/<<\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]\n?/g,'<div class="spoiler">'+
										'<a href="#spoiler" class="btn btn-$2 spoiler-caption spoiler-close">'+
										'<span class="caret"></span>&nbsp;$3</a><p>'+
										'<div class="hide spoiler-body spoiler-close"><pre>')
			# <<[button Заголовок спойлера]
			# текст спойлера
			# >>
			.replace(/<<\[b(tn|utton)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]\n?/g,'<div class="spoiler">'+
										'<a href="#spoiler" class="btn spoiler-caption spoiler-close">'+
										'<span class="caret"></span>&nbsp;$2</a><p>'+
										'<div class="hide spoiler-body spoiler-close"><pre>')
			# <<[Заголовок спойлера]
			# текст спойлера
			# >>
			.replace(/<<\[([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]\n?/g,'<div class="spoiler">'+
										'<a href="#spoiler" class="spoiler-caption spoiler-close">'+
										'$1</a><p>'+
										'<div class="hide spoiler-body spoiler-close"><pre>')
			.replace(/>>\n?/g,'</pre></div></p></div>')

	header: (text) ->

		text
			# <[
			# Заголовок с нижним подчеркиванием
			# ]>
			.replace(/<\[\n?/g,'<div class="page-header">')
			.replace(/\]>\n?/g,'</div>')

	spaces: (text) ->

		text
			.replace(/^\n/, "")
			.replace(/\n\n/g, "<br><br>")
			.replace(/>\n?/g, '>')
			.replace(/<pre><br>/g, '<pre>')
			.replace(/\n/g, "<br>")

	noevent: (text) ->

		text
			# <a href="#">Ссылка</a> -> <a href="#" data-noevent="true">Ссылка</a>
			.replace(/(href="#")/g,'$1 data-noevent="true"')



