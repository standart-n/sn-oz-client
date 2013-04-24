$ ->

	methods =
		init: (options = {}) ->

		primary: (options = {}) ->

			console.log 'wiki: ' + 'primary'

			_this = this
			def =
				text: ''
			$.extend true, def, options
			
			text = def.text
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

			console.log 'wiki: ' + 'side'

			_this = this
			def =
				text: ''
			$.extend true, def, options
			
			text = def.text
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

		externalLinks: (options = {}) ->

			def =
				text: ''

			$.extend def, options
			text = def.text
			text
				.replace(/\[(https?:\/\/[a-zA-Z0-9\-\.\/\?%\#_]+) (.*?)\]/g, '<a class="wiki-link" href="$1" target="_blank">$2</a>')
				.replace(/\[(https?:\/\/[a-zA-Z0-9\-\.\/\?%\#_]+)\]/g, '<a class="wiki-link" href="$1" target="_blank">$1</a>')

		fileLinks: (options = {}) ->

			sn = $(this).data 'sn'
			def =
				text: ''

			$.extend def, options
			text = def.text
			text
				.replace(/\[file:([a-zA-Z0-9\-\.\/\?%\#_]+) (.*?)\]/g, '<a class="wiki-link" href="http://oz.st-n.ru/publish/files/' + sn.region.name + '/$1" target="_blank">$2</a>')
				.replace(/\[file:([a-zA-Z0-9\-\.\/\?%\#_]+)\]/g, '<a class="wiki-link" href="http://oz.st-n.ru/publish/files/' + sn.region.name + '/$1" target="_blank">$1</a>')

		mailTo: (options = {}) ->

			def =
				text: ''

			$.extend def, options
			text = def.text
			text
				.replace(/\[email:([a-zA-Z0-9@\-\.\/\?%\#_]+) (.*?)\]/g, '<a class="wiki-link" href="mailto:$1">$2</a>')
				.replace(/\[email:([a-zA-Z0-9@\-\.\/\?%\#_]+)\]/g, '<a class="wiki-link" href="mailto:$1">$1</a>')

		photo: (options = {}) ->

			sn = $(this).data 'sn'
			def =
				text: ''

			$.extend def, options
			text = def.text
			text.replace(/\[photo:([a-zA-Z0-9\-\.\/\?%\#_]+)\]/g, '<img align="center" width="100%" src="http://oz.st-n.ru/publish/photo/' + sn.region.name + '/$1">')

		image: (options = {}) ->

			sn = $(this).data 'sn'
			def =
				text: ''

			$.extend def, options
			text = def.text
			text
				.replace(/\[image:([a-zA-Z0-9\-\.\/\?%\#_]+) left\]/g,'<img align="center" class="wiki-image-left" src="http://oz.st-n.ru/publish/photo/' + sn.region.name + '/$1">')
				.replace(/\[image:([a-zA-Z0-9\-\.\/\?%\#_]+) right\]/g,'<img align="center" class="wiki-image-right" src="http://oz.st-n.ru/publish/photo/' + sn.region.name + '/$1">')
				.replace(/\[image:([a-zA-Z0-9\-\.\/\?%\#_]+)\]/g,'<img align="center" src="http://oz.st-n.ru/publish/photo/' + sn.region.name + '/$1">')

		fonts: (options = {}) ->

			sn = $(this).data 'sn'
			def =
				text: ''

			$.extend def, options
			text = def.text
			text
				.replace(/\[\[color:\#([a-zA-Z0-9\-\.\/\?%\#_]+)\](.*?)\]/g, '<font style="color:#$1">$2</font>')
				.replace(/\[\[color:([a-zA-Z0-9\-\.\/\?%\#_]+)\](.*?)\]/g, '<span class="$1">$2</span>')

		internalLinks: (options = {}) ->

			def =
				text: ''

			$.extend def, options
			text = def.text
			text
				.replace(/\[#([a-zA-Z0-9\-\.\/\?%\#_\:]+) (.*?)\]/g, '<a class="wiki-link" href="#$1">$2</a>')
				.replace(/\[#([a-zA-Z0-9\-\.\/\?%\#_\:]+)\]/g, '<a class="wiki-link" href="#$1">$1</a>')

		indPrimary: (options = {}) ->

			def =
				text: ''

			$.extend def, options
			text = def.text
			text
				.replace(/<<<\n?/g, '<div class="primary-box-outer"><div class="primary-box wiki-text">')
				.replace(/>>>\n?/g, '</div></div>')

		indSide: (options = {}) ->

			def =
				text: ''

			$.extend def, options
			text = def.text
			text
				.replace(/<<<\n?/g, '<div class="side-box-outer"><div class="side-box wiki-text">')
				.replace(/>>>\n?/g, '</div></div>')

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

			def =
				text: ''

			$.extend def, options
			sn = $(this).data 'sn'
			text = def.text
			text.replace(/\[gismeteo\]\n?/g, '<iframe src="http://oz.st-n.ru/gismeteo/' + sn.region.name + '/" width="98%" height="160" scrolling="no" marginheight="0" marginwidth="0" frameborder="0"></iframe>')

		spoiler: (options = {}) ->

			def =
				text: ''

			$.extend def, options
			text = def.text
			text
				.replace(/<<\[(.+)\]\n?/g,'<div class="primary-box-spoiler">'+
											'<a href="#spoiler" class="wiki-link primary-box-spoiler-caption">$1</a>'+
											'<div class="primary-box-spoiler-body">')
				.replace(/>>\n?/g,'</div></div>')

		spaces: (options = {}) ->

			def =
				text: ''

			$.extend def, options
			text = def.text
			text
				.replace(/^\n/, "")
				.replace(/\n\n/g, "<br><br>")
				.replace(/>\n?/g, '>')
				.replace(/\]\n/g, "]")
				.replace(/\n/g, "<br>")
				.replace(/<br>\n?(<div class=\"primary-box-outer\">)/g, "$1")


	$.fn.snWiki = (sn = {}) ->
		if methods[sn]
			methods[sn].apply @, Array.prototype.slice.call arguments, 1
		else 
			methods.init.apply @, arguments
