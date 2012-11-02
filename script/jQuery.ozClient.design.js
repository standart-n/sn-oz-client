(function($){

	var methods={
		init:function(options)
		{
			return this.each(function(){
			});
		},
		pie_all:function(options)
		{
			$('.side-box-outer').each(function(){
				if (PIE) {
					if (PIE!=undefined) {
						PIE.attach(this);
					}
				}
			});
			$('.primary-box-outer').each(function(){
				if (PIE) {
					if (PIE!=undefined) {
						PIE.attach(this);
					}
				}
			});
		},
		pie_side:function(options)
		{
			$('.side-box-outer').each(function(){
				if (PIE) {
					if (PIE!=undefined) {
						PIE.attach(this);
					}
				}
			});
		},
		pie_primary:function(options)
		{
			$('.primary-box-outer').each(function(){
				if (PIE) {
					if (PIE!=undefined) {
						PIE.attach(this);
					}
				}
			});
		}
	};		

	$.fn.ozClientDesign=function(sn){
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
