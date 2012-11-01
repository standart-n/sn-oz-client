(function($){

	var methods={
		init:function(options)
		{
			return this.each(function(){
				//$(this).ozClientWiki('formatting')
			});
		},
		formating:function(options)
		{
			var def={
				'text':''
			};
			$.extend(def,options);
			var text=def.text;
			//text=text.replace(/\r\n/g,"<br>");
			text=text.replace(/'''''(.*?)'''''/mg,"<i><b>$1</b></i>");
			text=text.replace(/'''(.*?)'''/mg,"<b>$1</b>");
			text=text.replace(/''(.*?)''/mg,"<i>$1</i>");
			return text;
		},
		headings:function(options)
		{
			var def={
				'text':''
			};
			$.extend(def,options);
			var text=def.text;
			text=text.replace(/======(.*?)======\n/mg,"<h6>$1</h6>");
			text=text.replace(/=====(.*?)=====\n/mg,"<h5>$1</h5>");
			text=text.replace(/====(.*?)====\n/mg,"<h4>$1</h4>");
			text=text.replace(/===(.*?)===\n/mg,"<h3>$1</h3>");
			text=text.replace(/==(.*?)==\n/mg,"<h2>$1</h2>");
			text=text.replace(/======(.*?)======/mg,"<h6>$1</h6>");
			text=text.replace(/=====(.*?)=====/mg,"<h5>$1</h5>");
			text=text.replace(/====(.*?)====/mg,"<h4>$1</h4>");
			text=text.replace(/===(.*?)===/mg,"<h3>$1</h3>");
			text=text.replace(/==(.*?)==/mg,"<h2>$1</h2>");
			return text;
		},
		externalLinks:function(options)
		{
			var def={
				'text':''
			};
			$.extend(def,options);
			var text=def.text;
			text=text.replace(/\[(https?:\/\/[a-zA-Z0-9\-\.\/\?%\#_]+) (.+)\]/mg,'<a href="$1" target="_blank">$2</a>');
			text=text.replace(/\[(https?:\/\/[a-zA-Z0-9\-\.\/\?%\#_]+)\]/mg,'<a href="$1" target="_blank">$1</a>');
			return text;
		},
		fileLinks:function(options)
		{
			var sn=$(this).data('ozClient');
			var def={
				'text':''
			};
			$.extend(def,options);			
			var text=def.text;
			text=text.replace(/\[file:([a-zA-Z0-9\-\.\/\?%\#_]+) (.+)\]/mg,'<a href="http://oz.st-n.ru/publish/files/'+sn.region.name+'/$1" target="_blank">$2</a>');
			text=text.replace(/\[file:([a-zA-Z0-9\-\.\/\?%\#_]+)\]/mg,'<a href="http://oz.st-n.ru/publish/files/'+sn.region.name+'/$1" target="_blank">$1</a>');
			return text;
		},
		mailTo:function(options)
		{
			var def={
				'text':''
			};
			$.extend(def,options);
			var text=def.text;
			text=text.replace(/\[email:([a-zA-Z0-9@\-\.\/\?%\#_]+) (.+)\]/mg,'<a href="mailto:$1">$2</a>');
			text=text.replace(/\[email:([a-zA-Z0-9@\-\.\/\?%\#_]+)\]/mg,'<a href="mailto:$1">$1</a>');
			return text;
		},
		photo:function(options)
		{
			var sn=$(this).data('ozClient');
			var def={
				'text':''
			};
			$.extend(def,options);			
			var text=def.text;
			text=text.replace(/\[photo:([a-zA-Z0-9\-\.\/\?%\#_]+)\]/mg,'<img align="center" width="100%" src="http://oz.st-n.ru/publish/photo/'+sn.region.name+'/$1">');
			return text;
		},
		image:function(options)
		{
			var sn=$(this).data('ozClient');
			var def={
				'text':''
			};
			$.extend(def,options);			
			var text=def.text;
			text=text.replace(/\[image:([a-zA-Z0-9\-\.\/\?%\#_]+)\]/mg,'<img align="center" src="http://oz.st-n.ru/publish/photo/'+sn.region.name+'/$1">');
			return text;
		},
		internalLinks:function(options)
		{
			var def={
				'text':''
			};
			$.extend(def,options);
			var text=def.text;
			text=text.replace(/\[#([a-zA-Z0-9\-\.\/\?%\#_]+) (.+)\]/mg,'<a href="#$1">$2</a>');
			text=text.replace(/\[#([a-zA-Z0-9\-\.\/\?%\#_]+)\]/mg,'<a href="#$1">$1</a>');
			return text;
		},
		indPrimary:function(options)
		{
			var def={
				'text':''
			};
			$.extend(def,options);
			var text=def.text;
			text=text.replace(/<<<\n/g,'<div class="primary-box-outer"><div class="primary-box wiki-text">');
			text=text.replace(/<<<\r\n/g,'<div class="primary-box-outer"><div class="primary-box wiki-text">');
			text=text.replace(/>>>\n/g,'</div></div>');
			text=text.replace(/<<</g,'<div class="primary-box-outer"><div class="primary-box wiki-text">');
			text=text.replace(/>>>/g,'</div></div>');
			return text;
		},
		indSide:function(options)
		{
			var def={
				'text':''
			};
			$.extend(def,options);
			var text=def.text;
			text=text.replace(/<<<\n/g,'<div class="side-box-outer"><div class="side-box wiki-text">');
			text=text.replace(/<<<\r\n/g,'<div class="side-box-outer"><div class="side-box wiki-text">');
			text=text.replace(/>>>\n/g,'</div></div>');
			text=text.replace(/<<</g,'<div class="side-box-outer"><div class="side-box wiki-text">');
			text=text.replace(/>>>/g,'</div></div>');
			return text;
		},
		hr:function(options)
		{
			var def={
				'text':''
			};
			$.extend(def,options);
			var text=def.text;
			text=text.replace(/<hr>\n/g,'<hr>');
			text=text.replace(/<hr>\r\n/g,'<hr>');
			return text;
		},
		sideMenu:function(options)
		{
			var def={
				'text':''
			};
			$.extend(def,options);
			var text=def.text;
			text=text.replace(/\[menu:#([a-zA-Z0-9\-\.\/\?%\#_]+) (.+) (.+)\]/mg,'<a class="side-box-link side-box-link-normal" href="#$1" id="side-$2">$3</a>');
			return text;
		},
		gismeteo:function(options)
		{
			var def={
				'text':''
			};
			$.extend(def,options);
			var sn=$(this).data('ozClient');
			var text=def.text;
			text=text.replace(/\[gismeteo\]/mg,'<iframe src="http://oz.st-n.ru/gismeteo/'+sn.region.name+'/" width="98%" height="160" scrolling="no" marginheight="0" marginwidth="0" frameborder="0"></iframe>');
			return text;
		},		
		spoiler:function(options)
		{
			var def={
				'text':''
			};
			$.extend(def,options);
			var text=def.text;
			text=text.replace(/<<\[(.+)\]\n/g,'<div class="primary-box-spoiler">'+
												'<a href="#spoiler" class="primary-box-spoiler-caption primary-box-spoiler-caption-close">$1</a>'+
												'<div class="primary-box-spoiler-body">');
			text=text.replace(/>>\n/g,'</div></div>');
			text=text.replace(/<<\[(.+)\]/g,'<div class="primary-box-spoiler">'+
											'<a href="#spoiler" class="primary-box-spoiler-caption">$1</a>'+
											'<div class="primary-box-spoiler-body">');
			text=text.replace(/>>/g,'</div></div>');
			return text;
		},
		spaces:function(options)
		{
			var def={
				'text':''
			};
			$.extend(def,options);
			var text=def.text;
			text=text.replace(/\n\n/g,"<br><br>");
			text=text.replace(/\n/g,"<br>");
			text=text.replace(/<br>\n<div class=\"primary-box-outer\">/g,"<div class=\"primary-box-outer\">");
			text=text.replace(/<br><div class=\"primary-box-outer\">/g,"<div class=\"primary-box-outer\">");
			return text;
		}
	};		

	$.fn.ozClientWiki=function(sn){
		if (!sn) { var sn={}; }
		if ( methods[sn]) {
			return methods[sn].apply(this,Array.prototype.slice.call(arguments,1));
		} else if (typeof sn==='object' || !sn) {
			return methods.init.apply(this,arguments);
		} else {
			$.error('Метод '+sn+' не существует');
		}    
		
	};		
})(jQuery);
