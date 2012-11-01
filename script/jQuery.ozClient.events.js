(function($){

	var methods={
		init:function(options)
		{
			return this.each(function(){
				var def={
					'href':"none"
				};
				$.extend(def,options);
				var sn=$(this).data('ozClient');
				var href=def.href+"/:";
				var l_one=href.replace(/(.*)#(.*?)\/(.*)/,"$2");
				switch (l_one){
					case "autoload":
						$(this).ozClientModels('primary',{'file':'main.html'});
						$(this).ozClientModels('side',{'file':'main.html'});						
						$(this).ozClientTriggers('switchSide',{'link':'main'});
						$(this).ozClientTriggers('linksBar');
						$(this).ozClientTriggers('linksSide');
						$(this).ozClientTriggers('linksPrimary');
						$(this).ozClientTriggers('switcherBar');
						$(this).ozClientTriggers('switcherSide');
						sn.part="main";
						setTimeout('$(this).ozClientDesign("pie_all");',1);
					break;
					default:
						var l_two=href.replace(/(.*)#(.*?)\/(.*?)\/(.*)/,"$3");
						$("html,body").animate({scrollTop:0},0);
						if (l_one!=sn.part) {
							$(this).ozClientTriggers('switchBar',{'link':l_one});
							$(this).ozClientModels('side',{'file':l_one+'.html'});
							$(this).ozClientTriggers('linksSide');
							$(this).ozClientTriggers('switcherSide');
							sn.part=l_one;
							setTimeout('$(this).ozClientDesign("pie_side");',1);
						}						
						switch (l_two) {
							case "text":
								var l_three=href.replace(/(.*)#(.*?)\/(.*?)\/(.*?)\/(.*)/,"$4");
								$(this).ozClientTriggers('switchSide',{'link':l_three});
								$(this).ozClientModels('primary',{'file':l_three+'.html'});
								setTimeout('$(this).ozClientDesign("pie_primary");',1);
							break;
						}
				}
				$(this).data('ozClient',sn);
				var anchor=href.replace(/(.*)\:(.*?)\/(.*)/,"$2");
				if (anchor!="") {
					var height=$('#anchor-'+anchor).offset().top-87;
					if (height) {
						//alert(anchor);
						if ($("#side-"+anchor).length) {
							$(this).ozClientTriggers('switchSide',{'link':anchor});
						}
						$("html,body").animate({scrollTop:height},"slow");
					}
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
