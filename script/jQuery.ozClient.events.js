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
					case "main":
						var l_two=href.replace(/(.*)#(.*?)\/(.*?)\/(.*)/,"$3");
						$("html,body").animate({scrollTop:0},0);
						if (l_one!=sn.part) {
							$(this).ozClientTriggers('switchBar',{'link':l_one});
							$(this).ozClientModels('side',{'file':l_one+'.html'});
							$(this).ozClientTriggers('linksSide');
							$(this).ozClientTriggers('switcherSide');
							sn.part="main";
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
					break;
					case "news":
						var l_two=href.replace(/(.*)#(.*?)\/(.*?)\/(.*)/,"$3");
						$("html,body").animate({scrollTop:0},0);
						if (l_one!=sn.part) {
							$(this).ozClientTriggers('switchBar',{'link':l_one});
							$(this).ozClientModels('side',{'file':l_one+'.html'});
							$(this).ozClientTriggers('linksSide');
							$(this).ozClientTriggers('switcherSide');
							sn.part="news";
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
					break;
				}
				$(this).data('ozClient',sn);
				var anchor=href.replace(/(.*)\:(.*?)\/(.*)/,"$2");
				if (anchor!="") {
					var height=$('#anchor-'+anchor).offset().top-73;
					if (height>0) {
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
