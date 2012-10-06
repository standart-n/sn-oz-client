(function($){

	var methods={
		init:function(options)
		{
			return this.each(function(){
				$(this).data('ozClient',{});
				$(this).ozClientConf();
				$(this).ozClientDesign();
				$(this).ozClientTriggers();
				var sn=$(this).data('ozClient');
				
				//$(window).hashChange(function(){
				//	var link=window.location.hash.replace("#","");
				//	$(this).ozClientEvents({'link':link});
				//});

			});
		}
	};		

	$.fn.ozClient=function(sn){
		if (!sn) { var sn={}; }
		if ( methods[sn]) {
			return methods[sn].apply(this,Array.prototype.slice.call(arguments,1));
		} else if (typeof sn==='object' || !method) {
			return methods.init.apply(this,arguments);
		} else {
			$.error('Метод '+sn+' не существует');
		}    
		
	};		
})(jQuery);
