$ ->

	methods =
		init: (options = {}) ->

		primary: (options = {}) ->

			console.log 'wiki: ' + 'primary' if console?

			_this = this
			def =
				text: ''
			$.extend true, def, options
			
			text = def.text
			text = $(_this).snWiki('before', text: text)
			text = $(_this).snWiki('formating', text: text)
			text = $(_this).snWiki('headings', text: text)
			text = $(_this).snWiki('icons', text: text)
			text = $(_this).snWiki('externalLinks', text: text)
			text = $(_this).snWiki('fileLinks', text: text)
			text = $(_this).snWiki('internalLinks', text: text)
			text = $(_this).snWiki('mailTo', text: text)
			text = $(_this).snWiki('image', text: text)
			text = $(_this).snWiki('fonts', text: text)
			text = $(_this).snWiki('anchor', text: text)
			text = $(_this).snWiki('ind', text: text)
			text = $(_this).snWiki('spoiler', text: text)
			text = $(_this).snWiki('header', text: text)
			text = $(_this).snWiki('spaces', text: text)
			text

		side: (options = {}) ->

			console.log 'wiki: ' + 'side' if console?

			_this = this
			def =
				text: ''
			$.extend true, def, options
			
			text = def.text
			text = $(_this).snWiki('before', text: text)
			text = $(_this).snWiki('formating', text: text)
			text = $(_this).snWiki('headings', text: text)
			text = $(_this).snWiki('icons', text: text)
			text = $(_this).snWiki('externalLinks', text: text)
			text = $(_this).snWiki('fileLinks', text: text)
			text = $(_this).snWiki('internalLinks', text: text)
			text = $(_this).snWiki('mailTo', text: text)
			text = $(_this).snWiki('image', text: text)
			text = $(_this).snWiki('fonts', text: text)
			text = $(_this).snWiki('anchor', text: text)
			text = $(_this).snWiki('gismeteo', text: text)
			text = $(_this).snWiki('ind', text: text)
			text = $(_this).snWiki('sideMenu', text: text)
			text = $(_this).snWiki('spaces', text: text)
			text


		before: (options = {}) ->

			def =
				text: ''

			$.extend def, options
			text = def.text
			text
				.replace(/\|\n/g, '')
				.replace(/\]\n\n/g, ']<br><br>')
				.replace(/\]\n/g, ']<br>')
				.replace(/>\n\n/g, '>\n')

		formating: (options = {}) ->

			def =
				text: ''

			$.extend def, options
			text = def.text
			text
				.replace(/'''''(.*?)'''''/g, "<i><b>$1</b></i>")
				.replace(/'''(.*?)'''/g, "<b>$1</b>")
				.replace(/''(.*?)''/g, "<i>$1</i>")

		headings: (options = {}) ->

			def =
				text: ''

			$.extend def, options
			text = def.text
			text = `text.replace(/======(.*?)======\n?/g, "<h6>$1</h6>")`
			text = `text.replace(/=====(.*?)=====\n?/g, "<h5>$1</h5>")`
			text = `text.replace(/====(.*?)====\n?/g, "<h4>$1</h4>")`
			text = `text.replace(/===(.*?)===\n?/g, "<h3>$1</h3>")`
			text = `text.replace(/==(.*?)==\n?/g, "<h2>$1</h2>")`

		icons: (options = {}) ->

			def =
				text: ''

			$.extend def, options
			text = def.text
			.replace(/\[(i|ico|icon|icons):icon-([a-zA-Z0-9\_\-]+)[\s]+(inverse|white)\]/g, '<i class="icon-$2 icon-white"></i>')
			.replace(/\[(i|ico|icon|icons):([a-zA-Z0-9\_\-]+)[\s]+(inverse|white)\]/g, '<i class="icon-$2 icon-white"></i>')
			.replace(/\[(i|ico|icon|icons):icon-([a-zA-Z0-9\_\-]+)\]/g, '<i class="icon-$2"></i>')
			.replace(/\[(i|ico|icon|icons):([a-zA-Z0-9\_\-]+)\]/g, '<i class="icon-$2"></i>')

		internalLinks: (options = {}) ->

			def =
				text: ''

			$.extend def, options
			text = def.text
			text
				.replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)[\s]+(left|top|right|bottom)\]/g, '<a href="#$3" class="btn btn-$2 tooltip-toggle" data-placement="$6" rel="tooltip" title="$5">$4</a>')
				.replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)\]/g, '<a href="#$3" class="btn btn-$2 tooltip-toggle" rel="tooltip" title="$5">$4</a>')
				.replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)[\s]+(left|top|right|bottom)\]/g, '<a href="#$3" class="btn btn-$2 tooltip-toggle" data-placement="$5" rel="tooltip" title="$4">$3</a>')
				.replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)\]/g, '<a href="#$3" class="btn btn-$2 tooltip-toggle" rel="tooltip" title="$4">$3</a>')
				.replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)\]/g, '<a class="btn btn-$2" href="#$3">$4</a>')
				.replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+#([a-zA-Z0-9\-\.\/\?%\#_\:]+)\]/g, '<a class="btn btn-$2" href="#$1">$1</a>')

				.replace(/\[b(tn|utton)[\s]+#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)[\s]+(left|top|right|bottom)\]/g, '<a href="#$2" class="btn tooltip-toggle" data-placement="$5" rel="tooltip" title="$4">$3</a>')
				.replace(/\[b(tn|utton)[\s]+#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)\]/g,'<a href="#$2" class="btn tooltip-toggle" rel="tooltip" title="$4">$3</a>')
				.replace(/\[b(tn|utton)[\s]+#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)[\s]+(left|top|right|bottom)\]/g, '<a href="#$2" class="btn tooltip-toggle" data-placement="$4" rel="tooltip" title="$3">$2</a>')
				.replace(/\[b(tn|utton)[\s]+#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)\]/g, '<a href="#$2" class="btn tooltip-toggle" rel="tooltip" title="$3">$2</a>')
				.replace(/\[b(tn|utton)[\s]+#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)\]/g, '<a class="btn" href="#$2">$3</a>')
				.replace(/\[b(tn|utton)[\s]+#([a-zA-Z0-9\-\.\/\?%\#_\:]+)\]/g, '<a href="#$1">$1</a>')

				.replace(/\[#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)[\s]+(left|top|right|bottom)\]/g, '<a href="#$1" class="tooltip-toggle" data-placement="$4" rel="tooltip" title="$3">$2</a>')
				.replace(/\[#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)\]/g, '<a href="#$1" class="tooltip-toggle" rel="tooltip" title="$3">$2</a>')
				.replace(/\[#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)[\s]+(left|top|right|bottom)\]/g, '<a href="#$1" class="tooltip-toggle" data-placement="$3" rel="tooltip" title="$2">$1</a>')
				.replace(/\[#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)\]/g, '<a href="#$1" class="tooltip-toggle" rel="tooltip" title="$2">$1</a>')
				.replace(/\[#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)\]/g, '<a href="#$1">$2</a>')
				.replace(/\[#([a-zA-Z0-9\-\.\/\?%\#_\:]+)\]/g, '<a href="#$1">$1</a>')
				.replace(/([\s+])#([a-zA-Z0-9\-\.\/\?%\#_\:]+)([\s]+)/g, '$1<a href="#$2">$2</a>$3')

		externalLinks: (options = {}) ->

			def =
				text: ''

			$.extend def, options
			text = def.text
			text
				.replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+https?:\/\/([a-zA-Z0-9\-\.\/\?%\#_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+) (left|top|right|bottom)\]/g, '<a href="$3" class="btn btn-$2 tooltip-toggle" data-placement="$6" rel="tooltip" title="$5" target="_blank">$4</a>')
				.replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+https?:\/\/([a-zA-Z0-9\-\.\/\?%\#_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)\]/g, '<a href="$3" class="btn btn-$2 tooltip-toggle" rel="tooltip" title="$5" target="_blank">$4</a>')
				.replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+https?:\/\/([a-zA-Z0-9\-\.\/\?%\#_]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)[\s]+(left|top|right|bottom)\]/g, '<a href="$3" class="btn btn-$2 tooltip-toggle" data-placement="$5" rel="tooltip" title="$4" target="_blank">$3</a>')
				.replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+https?:\/\/([a-zA-Z0-9\-\.\/\?%\#_]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)\]/g, '<a href="$3" class="btn btn-$2 tooltip-toggle" rel="tooltip" title="$4" target="_blank">$3</a>')
				.replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+https?:\/\/([a-zA-Z0-9\-\.\/\?%\#_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)\]/g, '<a href="$3" class="btn btn-$2" target="_blank">$4</a>')
				.replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+https?:\/\/([a-zA-Z0-9\-\.\/\?%\#_]+)\]/g, '<a class="btn btn-$2" href="$2" target="_blank">$2</a>')

				.replace(/\[b(tn|utton)[\s]+https?:\/\/([a-zA-Z0-9\-\.\/\?%\#_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+) (left|top|right|bottom)\]/g, '<a href="$2" class="btn tooltip-toggle" data-placement="$5" rel="tooltip" title="$4" target="_blank">$3</a>')
				.replace(/\[b(tn|utton)[\s]+https?:\/\/([a-zA-Z0-9\-\.\/\?%\#_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)\]/g, '<a href="$2" class="btn tooltip-toggle" rel="tooltip" title="$4" target="_blank">$3</a>')
				.replace(/\[b(tn|utton)[\s]+https?:\/\/([a-zA-Z0-9\-\.\/\?%\#_]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)[\s]+(left|top|right|bottom)\]/g, '<a href="$2" class="btn tooltip-toggle" data-placement="$4" rel="tooltip" title="$3" target="_blank">$2</a>')
				.replace(/\[b(tn|utton)[\s]+https?:\/\/([a-zA-Z0-9\-\.\/\?%\#_]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)\]/g, '<a href="$2" class="tooltip-toggle" rel="tooltip" title="$3" target="_blank">$2</a>')
				.replace(/\[b(tn|utton)[\s]+https?:\/\/([a-zA-Z0-9\-\.\/\?%\#_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)\]/g, '<a class="btn" href="$2" target="_blank">$3</a>')
				.replace(/\[b(tn|utton)[\s]+https?:\/\/([a-zA-Z0-9\-\.\/\?%\#_]+)\]/g, '<a class="btn" href="$2" target="_blank">$2</a>')

				.replace(/\[https?:\/\/([a-zA-Z0-9\-\.\/\?%\#_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)[\s]+(left|top|right|bottom)\]/g, '<a href="$1" class="tooltip-toggle" data-placement="$4" rel="tooltip" title="$3" target="_blank">$2</a>')
				.replace(/\[https?:\/\/([a-zA-Z0-9\-\.\/\?%\#_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)\]/g, '<a href="$1" class="tooltip-toggle" rel="tooltip" title="$3" target="_blank">$2</a>')
				.replace(/\[https?:\/\/([a-zA-Z0-9\-\.\/\?%\#_]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)[\s]+(left|top|right|bottom)\]/g, '<a href="$1" class="tooltip-toggle" data-placement="$3" rel="tooltip" title="$2" target="_blank">$1</a>')
				.replace(/\[https?:\/\/([a-zA-Z0-9\-\.\/\?%\#_]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)\]/g, '<a href="$1" class="tooltip-toggle" rel="tooltip" title="$2" target="_blank">$1</a>')
				.replace(/\[https?:\/\/([a-zA-Z0-9\-\.\/\?%\#_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)\]/g, '<a href="$1" target="_blank">$2</a>')
				.replace(/\[https?:\/\/([a-zA-Z0-9\-\.\/\?%\#_]+)\]/g, '<a href="$1" target="_blank">$1</a>')
				.replace(/([\s]+)https?:\/\/([a-zA-Z0-9\-\.\/\?%\#_]+)([\s]+)/g, '$1<a href="$2" target="_blank">$2</a>$3')

		fileLinks: (options = {}) ->

			sn = $(this).data 'sn'
			def =
				text: ''

			$.extend def, options
			text = def.text
			text
				.replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+files?:([a-zA-Z0-9\-\.\/\?%\#_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)[\s]+(left|top|right|bottom)\]/g, '<a href="http://oz.st-n.ru/publish/files/' + sn.region.name + '/$3" class="btn btn-$2 tooltip-toggle" rel="tooltip" data-placement="$6" title="$5" target="_blank">$4</a>')
				.replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+files?:([a-zA-Z0-9\-\.\/\?%\#_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)\]/g, '<a href="http://oz.st-n.ru/publish/files/' + sn.region.name + '/$3" class="btn btn-$2 tooltip-toggle" rel="tooltip" title="$5" target="_blank">$4</a>')
				.replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+files?:([a-zA-Z0-9\-\.\/\?%\#_]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)[\s]+(left|top|right|bottom)\]/g, '<a href="http://oz.st-n.ru/publish/files/' + sn.region.name + '/$3" class="btn btn-$2 tooltip-toggle" rel="tooltip" data-placement="$5" title="$4" target="_blank">$3</a>')
				.replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+files?:([a-zA-Z0-9\-\.\/\?%\#_]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)\]/g, '<a href="http://oz.st-n.ru/publish/files/' + sn.region.name + '/$3" class="btn btn-$2 tooltip-toggle" rel="tooltip" title="$4" target="_blank">$3</a>')
				.replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+files?:([a-zA-Z0-9\-\.\/\?%\#_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)\]/g, '<a class="btn btn-$2" href="http://oz.st-n.ru/publish/files/' + sn.region.name + '/$3" target="_blank">$4</a>')
				.replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+files?:([a-zA-Z0-9\-\.\/\?%\#_]+)\]/g, '<a class="btn btn-$2" href="http://oz.st-n.ru/publish/files/' + sn.region.name + '/$3" target="_blank">$3</a>')

				.replace(/\[b(tn|utton)[\s]+files?:([a-zA-Z0-9\-\.\/\?%\#_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)[\s]+(left|top|right|bottom)\]/g, '<a href="http://oz.st-n.ru/publish/files/' + sn.region.name + '/$2" class="btn tooltip-toggle" rel="tooltip" data-placement="$5" title="$4" target="_blank">$3</a>')
				.replace(/\[b(tn|utton)[\s]+files?:([a-zA-Z0-9\-\.\/\?%\#_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)\]/g, '<a href="http://oz.st-n.ru/publish/files/' + sn.region.name + '/$2" class="btn tooltip-toggle" rel="tooltip" title="$4" target="_blank">$3</a>')
				.replace(/\[b(tn|utton)[\s]+files?:([a-zA-Z0-9\-\.\/\?%\#_]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)[\s]+(left|top|right|bottom)\]/g, '<a href="http://oz.st-n.ru/publish/files/' + sn.region.name + '/$2" class="btn tooltip-toggle" rel="tooltip" data-placement="$4" title="$3" target="_blank">$2</a>')
				.replace(/\[b(tn|utton)[\s]+files?:([a-zA-Z0-9\-\.\/\?%\#_]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)\]/g, '<a href="http://oz.st-n.ru/publish/files/' + sn.region.name + '/$2" class="btn tooltip-toggle" rel="tooltip" title="$3" target="_blank">$2</a>')
				.replace(/\[b(tn|utton)[\s]+files?:([a-zA-Z0-9\-\.\/\?%\#_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)\]/g, '<a class="btn" href="http://oz.st-n.ru/publish/files/' + sn.region.name + '/$2" target="_blank">$3</a>')
				.replace(/\[b(tn|utton)[\s]+files?:([a-zA-Z0-9\-\.\/\?%\#_]+)\]/g, '<a class="btn" href="http://oz.st-n.ru/publish/files/' + sn.region.name + '/$2" target="_blank">$2</a>')

				.replace(/\[files?:([a-zA-Z0-9\-\.\/\?%\#_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)[\s]+(left|top|right|bottom)\]/g, '<a href="http://oz.st-n.ru/publish/files/' + sn.region.name + '/$1" class="tooltip-toggle" rel="tooltip" data-placement="$4" title="$3" target="_blank">$2</a>')
				.replace(/\[files?:([a-zA-Z0-9\-\.\/\?%\#_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)\]/g, '<a href="http://oz.st-n.ru/publish/files/' + sn.region.name + '/$1" class="tooltip-toggle" rel="tooltip" title="$3" target="_blank">$2</a>')
				.replace(/\[files?:([a-zA-Z0-9\-\.\/\?%\#_]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)[\s]+(left|top|right|bottom)\]/g, '<a href="http://oz.st-n.ru/publish/files/' + sn.region.name + '/$1" class="tooltip-toggle" rel="tooltip" data-placement="$3" title="$2" target="_blank">$1</a>')
				.replace(/\[files?:([a-zA-Z0-9\-\.\/\?%\#_]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)\]/g, '<a href="http://oz.st-n.ru/publish/files/' + sn.region.name + '/$1" class="tooltip-toggle" rel="tooltip" title="$2" target="_blank">$1</a>')
				.replace(/\[files?:([a-zA-Z0-9\-\.\/\?%\#_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)\]/g, '<a href="http://oz.st-n.ru/publish/files/' + sn.region.name + '/$1" target="_blank">$2</a>')
				.replace(/\[files?:([a-zA-Z0-9\-\.\/\?%\#_]+)\]/g, '<a href="http://oz.st-n.ru/publish/files/' + sn.region.name + '/$1" target="_blank">$1</a>')
				.replace(/([\s]+)files?:([a-zA-Z0-9\-\.\/\?%\#_]+)([\s]+)/g, '$1<a href="http://oz.st-n.ru/publish/files/' + sn.region.name + '/$2" target="_blank">$2</a>$3')

		mailTo: (options = {}) ->

			def =
				text: ''

			$.extend def, options
			text = def.text
			text
				.replace(/\[e\-?mail:([a-zA-Z0-9@\-\.\/\?%\#_]+)[\s]+(.*?)\]/g, '<a href="mailto:$1">$2</a>')
				.replace(/\[e\-?mail:([a-zA-Z0-9@\-\.\/\?%\#_]+)\]/g, '<a href="mailto:$1">$1</a>')

		photo: (options = {}) ->

			sn = $(this).data 'sn'
			def =
				text: ''

			$.extend def, options
			text = def.text
			text.replace(/\[photo:([a-zA-Z0-9\-\.\/\?%\#_]+)\]/g, '<img align="center" style="width:99%;margin:auto;" src="http://oz.st-n.ru/publish/photo/' + sn.region.name + '/$1">')

		image: (options = {}) ->

			sn = $(this).data 'sn'
			def =
				text: ''

			$.extend def, options
			text = def.text
			text
				.replace(/\[(img|image|picture|photo):([a-zA-Z0-9\-\.\/\?%\#_]+)[\s]+(right|left)\]/g,'<img class="pull-$3" src="http://oz.st-n.ru/publish/photo/' + sn.region.name + '/$2">')
				.replace(/\[(img|image|picture|photo):([a-zA-Z0-9\-\.\/\?%\#_]+)\]/g,'<img src="http://oz.st-n.ru/publish/photo/' + sn.region.name + '/$2">')

		fonts: (options = {}) ->

			def =
				text: ''

			$.extend def, options
			text = def.text
			text
				.replace(/\[badge[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)[\s]+(success|warning|important|info|inverse)\]/g, '<span class="badge badge-$2">$1</span>')
				.replace(/\[badge[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)\]/g, '<span class="badge">$1</span>')

				.replace(/\[label[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)[\s]+(success|warning|important|info|inverse)\]/g, '<span class="label label-$2">$1</span>')
				.replace(/\[label[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)\]/g, '<span class="label">$1</span>')

				.replace(/\[color:\#([a-zA-Z0-9]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)\]/g, '<font style="color:#$1">$2</font>')
				.replace(/\[color:([a-zA-Z0-9]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)]+)\]/g, '<span class="$1">$2</span>')
				.replace(/\[\[color:\#([a-zA-Z0-9]+)\](.*?)\]/g, '<font style="color:#$1">$2</font>')
				.replace(/\[\[color:([a-zA-Z0-9]+)\](.*?)\]/g, '<span class="$1">$2</span>')


		ind: (options = {}) ->

			def =
				text: ''

			$.extend def, options
			text = def.text
			text
				.replace(/<<<\n?/g, '<div class="well well-small">')
				.replace(/>>>\n?/g, '</div>')

		anchor: (options = {}) ->

			def =
				text: ''

			$.extend def, options
			text = def.text
			text
				.replace(/\[anchor:([a-zA-Z0-9\-\.\/\?%\#_]+)\]\n?/g, '<a id="anchor-$1"></a>')

		sideMenu: (options = {}) ->

			def =
				text: ''

			$.extend def, options
			text = def.text
			text.replace(/\[menu:#([a-zA-Z0-9\-\.\/\?%\#_\:]+) ([a-zA-Z0-9\-\.\/\?%\#_]+) (.*?)\]\n?/g, '<a class="side-box-link side-box-link-normal" href="#$1" id="side-$2">$3</a>')

		gismeteo: (options = {}) ->

			sn = $(this).data 'sn'
			def =
				text: ''

			$.extend def, options
			text = def.text
			text.replace(/\[gismeteo\]\n?/g, '<iframe src="http://oz.st-n.ru/gismeteo/' + sn.region.name + '/" width="96%" height="160" scrolling="no" marginheight="0" marginwidth="0" frameborder="0"></iframe>&nbsp;')

		spoiler: (options = {}) ->

			def =
				text: ''

			$.extend def, options
			text = def.text
			text
				.replace(/<<\[(.+)\]\n?/g,'<div class="spoiler">'+
											'<a href="#spoiler" class="wiki-link spoiler-caption">$1</a>'+
											'<div class="spoiler-body">')
				.replace(/>>\n?/g,'</div></div>')

		header: (options = {}) ->

			def =
				text: ''

			$.extend def, options
			text = def.text
			text
				.replace(/<\[\n?/g,'<div class="page-header">')
				.replace(/\]>\n?/g,'</div>')


		spaces: (options = {}) ->

			def =
				text: ''

			$.extend def, options
			text = def.text
			text
				.replace(/^\n/, "")
				.replace(/\n\n/g, "<br><br>")
				.replace(/>\n?/g, '>')
				.replace(/\n/g, "<br>")


	$.fn.snWiki = (sn = {}) ->
		if methods[sn]
			methods[sn].apply @, Array.prototype.slice.call arguments, 1
		else 
			methods.init.apply @, arguments
