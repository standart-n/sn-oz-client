(function($){

	var methods={
		init:function(options)
		{
			return this.each(function(){
				$(this).data('ozClient',{});
				$(this).ozClientConf();
				$(this).ozClientLayout();
				$(this).ozClientTriggers();
				$(this).ozClientEvents({'href':'#autoload'});
				var sn=$(this).data('ozClient');
			});
		}
	};		

	$.fn.ozClient=function(sn){
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
