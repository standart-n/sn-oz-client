(function($){

	var methods={
		init:function(options)
		{
			return this.each(function(){
				//alert('go!');
				var sn=$(this).data('ozClient');				
				$(this).ozClientLayout('load',{'div':'main','file':'main.html'});
				$(this).ozClientLayout('load',{'div':'header','file':'header.html'});
				$(this).ozClientLayout('load',{'div':'content','file':'content.html'});
				$(".bar-caption").html(sn.region.caption);
			});
		},
		load:function(options)
		{
			var sn=$(this).data('ozClient');
			var def={
				'div':'main',
				'file':'main.html'
			};
			$.extend(def,options);
			$.ajax({
				url:'layout/'+sn.region.name+'/'+def.file,
				async:false,
				dataType:"html",
				success:function(s){
					$('#'+def.div).html(s);
				}
			});			
		}
	};		

	$.fn.ozClientLayout=function(sn){
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
