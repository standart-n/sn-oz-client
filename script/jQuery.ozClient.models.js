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
			var oz=$(this);
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
					text=oz.ozClientWiki('formating',{'text':text});
					text=oz.ozClientWiki('headings',{'text':text});
					text=oz.ozClientWiki('externalLinks',{'text':text});
					text=oz.ozClientWiki('fileLinks',{'text':text});
					text=oz.ozClientWiki('internalLinks',{'text':text});
					text=oz.ozClientWiki('mailTo',{'text':text});
					text=oz.ozClientWiki('photo',{'text':text});
					text=oz.ozClientWiki('indention',{'text':text});
					text=oz.ozClientWiki('spoiler',{'text':text});
					text=oz.ozClientWiki('spaces',{'text':text});
					$('#primary-content').html(text);
					oz.ozClientTriggers('spoiler');
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
