(function($){

	var methods={
		init:function(options)
		{
			return this.each(function(){
			});
		},
		parse:function()
		{
			//$text = preg_replace("#\[\[(https?://[a-zA-Z0-9\-\./\?%\#_]+)\|(.+)\]\]#", '<a href="$1">$2</a>', $text);
    
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
