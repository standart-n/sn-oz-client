(function($){

	var methods={
		init:function(options)
		{
			return this.each(function(){
				
			});
		},
		primary:function(options)
		{
			var sn=$(this).data('ozClient');
			var def={
				'file':'main.html'
			};
			$.extend(def,options);
			$.ajax({
				url:'content/'+sn.region.name+'/'+def.file,
				async:false,
				dataType:'html',
				success:function(s){
					$('#primary-content').html(s);
				}
			});			
		},
		side:function(options)
		{
			var sn=$(this).data('ozClient');
			var def={
				'file':'main.html'
			};
			$.extend(def,options);
			$.ajax({
				url:'layout/'+sn.region.name+'/'+def.file,
				async:false,
				dataType:'html',
				success:function(s){
					$('#side-content').html(s);
				}
			});			
		}
	};

	$.fn.ozClientModels=function(sn){
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
