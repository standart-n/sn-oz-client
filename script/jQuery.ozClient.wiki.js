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
