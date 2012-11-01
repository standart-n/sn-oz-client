(function($){

	var methods={
		init:function(options)
		{
			return this.each(function(){
			});
		},
		linksSide:function()
		{
			var oz=$(this);
			/*$(".side-box-link").on("click",function(){
				oz.ozClientEvents({'href':$(this).attr("href")});
			});*/
			$(".side-box a").on("click",function(){
				oz.ozClientEvents({'href':$(this).attr("href")});
			});
		},
		linksPrimary:function()
		{
			var oz=$(this);
			$(".primary-box a").on("click",function(){
				oz.ozClientEvents({'href':$(this).attr("href")});
			});
		},
		linksBar:function()
		{
			var oz=$(this);
			$(".bar-logo").on("click",function(){
				oz.ozClientEvents({'href':$(this).attr("href")});
			});
			$(".bar-button").on("click",function(){
				oz.ozClientEvents({'href':$(this).attr("href")});
			});
		},
		switchBar:function(options)
		{
			var def={
				'link':'main'
			};
			$.extend(def,options);
			$(".bar-button").removeClass("bar-button-active").removeClass("bar-button-hover").addClass("bar-button-normal");
			$("#bar-"+def.link+"").removeClass("bar-button-normal").removeClass("bar-button-hover").addClass("bar-button-active").blur();
		},
		switchSide:function(options)
		{
			var def={
				'link':'above'
			};
			$.extend(def,options);
			$(".side-box-link").removeClass("side-box-link-active").removeClass("side-box-link-hover").addClass("side-box-link-normal");
			$("#side-"+def.link+"").removeClass("side-box-link-normal").removeClass("side-box-link-hover").addClass("side-box-link-active").blur();
		},
		switcherBar:function()
		{
			$(".bar-button").on("mouseover",function(){
				if (!$(this).hasClass("bar-button-active")) {
					$(this).removeClass("bar-button-normal");
					$(this).addClass("bar-button-hover");
				}
			});
			$(".bar-button").on("mouseleave",function(){
				if (!$(this).hasClass("bar-button-active")) {
					$(this).removeClass("bar-button-hover");
					$(this).addClass("bar-button-normal");
				}
			});
		},
		switcherSide:function()
		{
			$(".side-box-link").on("mouseover",function(){
				if (!$(this).hasClass("side-box-link-active")) {
					$(this).removeClass("side-box-link-normal");
					$(this).addClass("side-box-link-hover");
				}
			});
			$(".side-box-link").on("mouseleave",function(){
				if (!$(this).hasClass("side-box-link-active")) {
					$(this).removeClass("side-box-link-hover");
					$(this).addClass("side-box-link-normal");
				}
			});
		},
		spoiler:function()
		{
			$(".primary-box-spoiler-caption").on("click",function(){
				if ($(this).hasClass("primary-box-spoiler-caption-open")){
					$(this).removeClass("primary-box-spoiler-caption-open").addClass("primary-box-spoiler-caption-close");
				} else {						
					$(this).removeClass("primary-box-spoiler-caption-close").addClass("primary-box-spoiler-caption-open");
				}
				$(this).parent(".primary-box-spoiler").children(".primary-box-spoiler-body").each(function(){
					if ($(this).hasClass("spoiler-status-open")){
						$(this).removeClass("spoiler-status-open").addClass("spoiler-status-close").hide();
					} else {						
						$(this).removeClass("spoiler-status-close").addClass("spoiler-status-open").show();
					}
				});
			});
		}
	};

	$.fn.ozClientTriggers=function(sn){
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
