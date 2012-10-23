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
			text=text.replace(/======(.*?)======\r\n/mg,"<h6>$1</h6>");
			text=text.replace(/=====(.*?)=====\r\n/mg,"<h5>$1</h5>");
			text=text.replace(/====(.*?)====\r\n/mg,"<h4>$1</h4>");
			text=text.replace(/===(.*?)===\r\n/mg,"<h3>$1</h3>");
			text=text.replace(/==(.*?)==\r\n/mg,"<h2>$1</h2>");
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
		internalLinks:function(options)
		{
			var def={
				'text':''
			};
			$.extend(def,options);
			var text=def.text;
			text=text.replace(/\[([a-zA-Z0-9\-\.\/\?%\#_]+) (.+)\]/mg,'<a href="#$1">$2</a>');
			text=text.replace(/\[([a-zA-Z0-9\-\.\/\?%\#_]+)\]/mg,'<a href="#$1">$1</a>');
			return text;
		},
		indention:function(options)
		{
			var def={
				'text':''
			};
			$.extend(def,options);
			var text=def.text;
			text=text.replace(/<<<\r\n/g,'<div class="primary-box-outer"><div class="primary-box wiki-text">');
			text=text.replace(/>>>\r\n/g,'</div></div>');
			text=text.replace(/<<</g,'<div class="primary-box-outer"><div class="primary-box wiki-text">');
			text=text.replace(/>>>/g,'</div></div>');
			return text;
		},
		spaces:function(options)
		{
			var def={
				'text':''
			};
			$.extend(def,options);
			var text=def.text;
			text=text.replace(/\r\n\r\n/g,"<br><br>");
			text=text.replace(/\r\r/g,"<br><br>");
			text=text.replace(/\n\n/g,"<br><br>");
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
