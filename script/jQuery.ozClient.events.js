(function($){

	var methods={
		init:function(options)
		{
			return this.each(function(){
				var def={
					'href':"none"
				};
				$.extend(def,options);
				var href=def.href;
				switch (href.replace(/(.*)#(.*)/,"$2")){
					case "autoload":
						$(this).ozClientModels('primary',{'file':'main.html'});
						$(this).ozClientModels('side',{'file':'main.html'});
						$(this).ozClientTriggers();
					break;
					case "main":
						$(this).ozClientModels('primary',{'file':'main.html'});
						$(this).ozClientModels('side',{'file':'main.html'});
						$(this).ozClientTriggers('linksSide');
						$(this).ozClientTriggers('linksPrimary');
						$(this).ozClientTriggers('switcherSide');
					break;
					case "news":
						$(this).ozClientModels('primary',{'file':'news.html'});
						$(this).ozClientModels('side',{'file':'news.html'});
						$(this).ozClientTriggers('linksSide');
						$(this).ozClientTriggers('linksPrimary');
						$(this).ozClientTriggers('switcherSide');
					break;
					case "above":
						$(this).ozClientModels('primary',{'file':'main.html'});						
						$(this).ozClientTriggers('linksPrimary');
					break;
					case "apteki":
						$(this).ozClientModels('primary',{'file':'apteki.html'});
						$(this).ozClientTriggers('linksPrimary');
					break;
					case "dealers":
						$(this).ozClientModels('primary',{'file':'dealers.html'});
						$(this).ozClientTriggers('linksPrimary');
					break;
					case "orders":
						$(this).ozClientModels('primary',{'file':'orders.html'});
						$(this).ozClientTriggers('linksPrimary');
					break;
					case "contacts":
						$(this).ozClientModels('primary',{'file':'contacts.html'});
						$(this).ozClientTriggers('linksPrimary');
					break;
					//case ""
				}
			});
		}
	};

	$.fn.ozClientEvents=function(sn){
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
