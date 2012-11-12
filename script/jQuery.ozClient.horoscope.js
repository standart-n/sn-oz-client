(function($){

	var methods={
		init:function(options)
		{
			return this.each(function(){
				var def={
					'el':'#primary-content'
				};
				$.extend(true,def,options);
				var sn=$(this).data('ozClient');
				$.ajax({
					url:'http://oz.st-n.ru/horoscope/',
					dataType:"json",
					success:function(s){
						if (s.hscope) {
							$.each(s.hscope,function(key,value){
								if (value.description) {
									$("#hscope-description-"+key).html(value.description);
								}
							});							
						}
					}
				});			
			});
		}
	};		

	$.fn.ozClientHoroscope=function(sn){
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
