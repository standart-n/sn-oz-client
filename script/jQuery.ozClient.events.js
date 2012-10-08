(function($){

	var methods={
		init:function(options)
		{
			return this.each(function(){
				var def={
					'href':"#none"
				};
				$.extend(def,options);
				switch (def.href){
					case "#main":
						$(this).ozClientModels('primary',{'file':'main.html'});
						$(this).ozClientModels('side',{'file':'side_main.html'});
						$(this).ozClientTriggers();
					break;
					case "#above":
						$(this).ozClientModels('primary',{'file':'main.html'});
					break;
					case "#apteki":
						$(this).ozClientModels('primary',{'file':'apteki.html'});
					break;
					case "#dealers":
						$(this).ozClientModels('primary',{'file':'dealers.html'});
					break;
					case "#orders":
						$(this).ozClientModels('primary',{'file':'orders.html'});
					break;
					case "#contacts":
						$(this).ozClientModels('primary',{'file':'contacts.html'});
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
