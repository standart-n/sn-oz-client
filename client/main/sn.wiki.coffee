$ ->

	methods =
		init: (options = {}) ->

		primary: (options = {}) ->

			_this = this
			def =
				text: ''
			$.extend true, def, options
			
			text = def.text
			text = $(_this).snWiki('tags', text: text)
			text = $(_this).snWiki('formating', text: text)
			text = $(_this).snWiki('headings', text: text)
			text = $(_this).snWiki('externalLinks', text: text)
			text = $(_this).snWiki('fileLinks', text: text)
			text = $(_this).snWiki('internalLinks', text: text)
			text = $(_this).snWiki('mailTo', text: text)
			text = $(_this).snWiki('photo', text: text)
			text = $(_this).snWiki('image', text: text)
			text = $(_this).snWiki('fonts', text: text)
			text = $(_this).snWiki('anchor', text: text)
			text = $(_this).snWiki('indPrimary', text: text)
			text = $(_this).snWiki('spoiler', text: text)
			text = $(_this).snWiki('spaces', text: text)
			text

		side: (options = {}) ->

			_this = this
			def =
				text: ''
			$.extend true, def, options
			
			text = def.text
			text = $(_this).snWiki('tags', text: text)
			text = $(_this).snWiki('formating', text: text)
			text = $(_this).snWiki('headings', text: text)
			text = $(_this).snWiki('externalLinks', text: text)
			text = $(_this).snWiki('fileLinks', text: text)
			text = $(_this).snWiki('internalLinks', text: text)
			text = $(_this).snWiki('mailTo', text: text)
			text = $(_this).snWiki('photo', text: text)
			text = $(_this).snWiki('image', text: text)
			text = $(_this).snWiki('fonts', text: text)
			text = $(_this).snWiki('anchor', text: text)
			text = $(_this).snWiki('gismeteo', text: text)
			text = $(_this).snWiki('indSide', text: text)
			text = $(_this).snWiki('sideMenu', text: text)
			text = $(_this).snWiki('spaces', text: text)
			text


		formating: (options = {}) ->

			def =
				text: ''

			$.extend def, options
			text = def.text
			text
				.replace(/'''''(.*?)'''''/mg, "<i><b>$1</b></i>")
				.replace(/'''(.*?)'''/mg, "<b>$1</b>")
				.replace(/''(.*?)''/mg, "<i>$1</i>")

		headings: (options = {}) ->

			def =
				text: ''

			$.extend def, options
			text = def.text
			text = `text.replace(/======(.*?)======\n/mg, "<h6>$1</h6>")`
			text = `text.replace(/=====(.*?)=====\n/mg, "<h5>$1</h5>")`
			text = `text.replace(/====(.*?)====\n/mg, "<h4>$1</h4>")`
			text = `text.replace(/===(.*?)===\n/mg, "<h3>$1</h3>")`
			text = `text.replace(/==(.*?)==\n/mg, "<h2>$1</h2>")`
			text = `text.replace(/======(.*?)======/mg, "<h6>$1</h6>")`
			text = `text.replace(/=====(.*?)=====/mg, "<h5>$1</h5>")`
			text = `text.replace(/====(.*?)====/mg, "<h4>$1</h4>")`
			text = `text.replace(/===(.*?)===/mg, "<h3>$1</h3>")`
			text = `text.replace(/==(.*?)==/mg, "<h2>$1</h2>")`

		externalLinks: (options = {}) ->

			def =
				text: ''

			$.extend def, options
			text = def.text
			text
				.replace(/\[(https?:\/\/[a-zA-Z0-9\-\.\/\?%\#_]+) (.*?)\]/mg, '<a class="wiki-link" href="$1" target="_blank">$2</a>')
				.replace(/\[(https?:\/\/[a-zA-Z0-9\-\.\/\?%\#_]+)\]/mg, '<a class="wiki-link" href="$1" target="_blank">$1</a>')

		fileLinks: (options = {}) ->

			sn = $(this).data 'sn'
			def =
				text: ''

			$.extend def, options
			text = def.text
			text
				.replace(/\[file:([a-zA-Z0-9\-\.\/\?%\#_]+) (.*?)\]/mg, '<a class="wiki-link" href="http://oz.st-n.ru/publish/files/' + sn.region.name + '/$1" target="_blank">$2</a>')
				.replace(/\[file:([a-zA-Z0-9\-\.\/\?%\#_]+)\]/mg, '<a class="wiki-link" href="http://oz.st-n.ru/publish/files/' + sn.region.name + '/$1" target="_blank">$1</a>')

		mailTo: (options = {}) ->

			def =
				text: ''

			$.extend def, options
			text = def.text
			text
				.replace(/\[email:([a-zA-Z0-9@\-\.\/\?%\#_]+) (.*?)\]/mg, '<a class="wiki-link" href="mailto:$1">$2</a>')
				.replace(/\[email:([a-zA-Z0-9@\-\.\/\?%\#_]+)\]/mg, '<a class="wiki-link" href="mailto:$1">$1</a>')

		photo: (options = {}) ->

			sn = $(this).data 'sn'
			def =
				text: ''

			$.extend def, options
			text = def.text
			text.replace(/\[photo:([a-zA-Z0-9\-\.\/\?%\#_]+)\]/mg, '<img align="center" width="100%" src="http://oz.st-n.ru/publish/photo/' + sn.region.name + '/$1">')

		image: (options = {}) ->

			sn = $(this).data 'sn'
			def =
				text: ''

			$.extend def, options
			text = def.text
			text
				.replace(/\[image:([a-zA-Z0-9\-\.\/\?%\#_]+) left\]/mg,'<img align="center" class="wiki-image-left" src="http://oz.st-n.ru/publish/photo/' + sn.region.name + '/$1">')
				.replace(/\[image:([a-zA-Z0-9\-\.\/\?%\#_]+) right\]/mg,'<img align="center" class="wiki-image-right" src="http://oz.st-n.ru/publish/photo/' + sn.region.name + '/$1">')
				.replace(/\[image:([a-zA-Z0-9\-\.\/\?%\#_]+)\]/mg,'<img align="center" src="http://oz.st-n.ru/publish/photo/' + sn.region.name + '/$1">')

		fonts: (options = {}) ->

			sn = $(this).data 'sn'
			def =
				text: ''

			$.extend def, options
			text = def.text
			text
				.replace(/\[\[color:([a-zA-Z0-9\-\.\/\?%\#_]+)\](.*?)\]/mg, '<font style="color:$1">$2</font>')
				.replace(/\[\[color:red\](.*?)\]/mg, '<font style="color:#ff0000">$1</font>')
				.replace(/\[\[color:silver\](.*?)\]/mg, '<font style="color:#666">$1</font>')

		internalLinks: (options = {}) ->

			def =
				text: ''

			$.extend def, options
			text = def.text
			text
				.replace(/\[#([a-zA-Z0-9\-\.\/\?%\#_\:]+) (.*?)\]/mg, '<a class="wiki-link" href="#$1">$2</a>')
				.replace(/\[#([a-zA-Z0-9\-\.\/\?%\#_\:]+)\]/mg, '<a class="wiki-link" href="#$1">$1</a>')

		indPrimary: (options = {}) ->

			def =
				text: ''

			$.extend def, options
			text = def.text
			text
				.replace(/<<<\n/g, '<div class="primary-box-outer"><div class="primary-box wiki-text">')
				.replace(/>>>\n/g, '</div></div>')
				.replace(/<<</g, '<div class="primary-box-outer"><div class="primary-box wiki-text">')
				.replace(/>>>/g, '</div></div>')

		indSide: (options = {}) ->

			def =
				text: ''

			$.extend def, options
			text = def.text
			text
				.replace(/<<<\n/g, '<div class="side-box-outer"><div class="side-box wiki-text">')
				.replace(/>>>\n/g, '</div></div>')
				.replace(/<<</g, '<div class="side-box-outer"><div class="side-box wiki-text">')
				.replace(/>>>/g, '</div></div>')

		tags: (options = {}) ->

			def =
				text: ''

			$.extend def, options
			text = def.text
			text
				.replace(/<(.*?)>\n/g, '<$1>')
				.replace(/<(.*?)>\r/g, '<$1>')
				.replace(/<(.*?)>\r\n/g, '<$1>')
				.replace(/<\/(.*?)>\n/g, '</$1>')
				.replace(/<\/(.*?)>\r/g, '</$1>')
				.replace(/<\/(.*?)>\r\n/g, '</$1>')
				.replace(/<(.*?)>\n/g, '<$1>')
				.replace(/<(.*?)>\r/g, '<$1>')
				.replace(/<(.*?)>\r\n/g, '<$1>')
				.replace(/<\/(.*?)>\n/g, '</$1>')
				.replace(/<\/(.*?)>\r/g, '</$1>')
				.replace(/<\/(.*?)>\r\n/g, '</$1>')

		anchor: (options = {}) ->

			def =
				text: ''

			$.extend def, options
			text = def.text
			text
				.replace(/\[anchor:([a-zA-Z0-9\-\.\/\?%\#_]+)\]\n/g, '<a id="anchor-$1"></a>')
				.replace(/\[anchor:([a-zA-Z0-9\-\.\/\?%\#_]+)\]/g, '<a id="anchor-$1"></a>')

		sideMenu: (options = {}) ->

			def =
				text: ''

			$.extend def, options
			text = def.text
			text.replace(/\[menu:#([a-zA-Z0-9\-\.\/\?%\#_\:]+) ([a-zA-Z0-9\-\.\/\?%\#_]+) (.*?)\]/mg, '<a class="side-box-link side-box-link-normal" href="#$1" id="side-$2">$3</a>')

		gismeteo: (options = {}) ->

			def =
				text: ''

			$.extend def, options
			sn = $(this).data 'sn'
			text = def.text
			text.replace(/\[gismeteo\]/mg, '<iframe src="http://oz.st-n.ru/gismeteo/' + sn.region.name + '/" width="98%" height="160" scrolling="no" marginheight="0" marginwidth="0" frameborder="0"></iframe>')

		spoiler: (options = {}) ->

			def =
				text: ''

			$.extend def, options
			text = def.text
			text
				.replace(/<<\[(.+)\]\n/g,'<div class="primary-box-spoiler">'+
											'<a href="#spoiler" class="wiki-link primary-box-spoiler-caption">$1</a>'+
											'<div class="primary-box-spoiler-body">')
				.replace(/>>\n/g,'</div></div>')
				.replace(/<<\[(.+)\]/g,'<div class="primary-box-spoiler">'+
											'<a href="#spoiler" class="wiki-link primary-box-spoiler-caption">$1</a>'+
											'<div class="primary-box-spoiler-body">')
				.replace(/>>/g,'</div></div>')

		spaces: (options = {}) ->

			def =
				text: ''

			$.extend def, options
			text = def.text
			text
				.replace(/\]\n/g, "]")
				.replace(/\n\n/g, "<br><br>")
				.replace(/\n/g, "<br>")
				.replace(/<br>\n<div class=\"primary-box-outer\">/g, "<div class=\"primary-box-outer\">")
				.replace(/<br><div class=\"primary-box-outer\">/g, "<div class=\"primary-box-outer\">")


	$.fn.snWiki = (sn = {}) ->
		if methods[sn]
			methods[sn].apply @, Array.prototype.slice.call arguments, 1
		else 
			if typeof sn == 'object' || !sn
				methods.init.apply @, arguments
			else 
				$.error 'Метод ' + sn + ' не существует'
