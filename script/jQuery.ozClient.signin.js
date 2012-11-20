(function($){

	var methods={
		init:function(options)
		{
			return this.each(function(){
				var def={
					'el':'#primary-content'
				};
				$.extend(true,def,options);
				$(this).ozClientSignin('triggers',def);
				var sn=$(this).data('ozClient');
			});
		},
		triggers:function(def)
		{
			$(".signin-input").on("focus",function(){
				if (($(this).val()==$(this).data("def-value")) || ($(this).val()=="")) {
					$(this).removeClass("signin-input-blur").addClass("signin-input-focus").val("").select();
				}
			});
			$(".signin-input").on("blur",function(){
				if (($(this).val()==$(this).data("def-value")) || ($(this).val()=="")) {
					$(this).removeClass("signin-input-focus").addClass("signin-input-blur").val($(this).data("def-value"));
				}
			});
		}
	};

	$.fn.ozClientSignin=function(sn){
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
