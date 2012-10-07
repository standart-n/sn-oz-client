(function($){

	var methods={
		init:function(options)
		{
			return this.each(function(){
				var sn=$(this).data('ozClient');
				if (sn.design){
					$(this).ozClientDesign('side');
				}
			});
		},
		side:function()
		{
			var s="";
			var sn=$(this).data('ozClient');
			if (sn.design.main) {
				if (sn.design.main.side) {
					$.each(sn.design.main.side,function(i){
						if ((this.type=="box") && (!this.hidden)) {
							s+='<div class="side-box-outer">';
							s+='<div class="side-box">';
							$.each(this.links,function(i){
								if ((this.type=="simple-link") && (!this.hidden)) {
									this.cl="side-box-link";
									if (!this.active) { this.active=false; }
									if (!this.underline) { this.underline=false; }
									if (this.active) { this.cl+=" side-box-link-active"; } else { this.cl+=" side-box-link-normal"; }
									s+='<a href="'+this.href+'" class="'+this.cl+'">'+this.caption+'</a>';
									if (this.underline) {
										s+='<div class="side-box-line"></div>';
									}
								}
							});						
							s+='</div>';
							s+='</div>';
						}
					});
				}
			}
			if (s!="") {
				$("#side-content").html(s);
			}
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
