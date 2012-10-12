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
				cache:false,
				dataType:'html',
				success:function(text){
					text=$(this).ozClientWiki('formating',{'text':text});
					text=$(this).ozClientWiki('headings',{'text':text});
					text=$(this).ozClientWiki('externalLinks',{'text':text});
					text=$(this).ozClientWiki('internalLinks',{'text':text});
					text=$(this).ozClientWiki('indention',{'text':text});
					$('#primary-content').html(text);
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
				url:'layout/'+sn.region.name+'/side_'+def.file,
				async:false,
				cache:false,
				dataType:'html',
				success:function(text){
					$('#side-content').html(text);
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
