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
			var oz=$(this);
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
			$("#signin-form-enter").on("submit",function(e){
				e.preventDefault();
				oz.ozClientSignin('enter');
			});
			$("#signin-button-enter").on("click",function(e){
				e.preventDefault();
				oz.ozClientSignin('enter');
			});
			$("#signin-form-reg").on("submit",function(e){
				e.preventDefault();
				oz.ozClientSignin('reg');
			});
			$("#signin-button-reg").on("click",function(e){
				e.preventDefault();
				oz.ozClientSignin('reg');
			});
			$(".signin-type-reg").on("keyup",function(){
				var th=$(this);
				var check=oz.ozClientSignin('check',
						{
							'type':$(this).data("check-type"),
							'value':$(this).val(),
							'caption':$(this).data("def-value")
						}
				);
				$(".signin-form-check").each(function(){
					if ($(this).data("check-type")==th.data("check-type")) {
						if (check.error!=undefined) {
							if ($(this).hasClass("signin-form-check-clear")) { $(this).removeClass("signin-form-check-clear"); }
							if (check.error) {
								$(this).removeClass("signin-form-check-true").addClass("signin-form-check-false");
							} else {
								$(this).removeClass("signin-form-check-false").addClass("signin-form-check-true");
							}
						}
					}
				});
			});
		},
		check:function(options)
		{
			var def={
				'type':'post',
				'value':'',
				'caption':'',
				'error':true,
				'start':'В поле',
				'exp':''
			};
			$.extend(true,def,options);
			var value=def.value.toString();
			switch (def.type) {
				case "firstname":
					if ((value=="") || (value==def.caption)) { def.exp="ничего не указано!"; } else {
						if (value.length<3) { def.exp="слишком короткое значение!"; } else {
							if (value.length>28) { def.exp="слишком длинное значение!"; } else {
								if (!value.match(/^([а-я\-\.]+)$/gi)) { def.exp="некорректное значение!"; } else {
									def.error=false;
								}
							}
						}
					}
				break;
				case "lastname":
					if ((value=="") || (value==def.caption)) { def.exp="ничего не указано!"; } else {
						if (value.length<3) { def.exp="слишком короткое значение!"; } else {
							if (value.length>28) { def.exp="слишком длинное значение!"; } else {
								if (!value.match(/^([а-я\-\.]+)$/gi)) { def.exp="некорректное значение!"; } else {
									def.error=false;
								}
							}
						}
					}
				break;
				case "patronymic":
					if ((value=="") || (value==def.caption)) { def.exp="ничего не указано!"; } else {
						if (value.length<3) { def.exp="слишком короткое значение!"; } else {
							if (value.length>28) { def.exp="слишком длинное значение!"; } else {
								if (!value.match(/^([а-я\-\.]+)$/gi)) { def.exp="некорректное значение!"; } else {
									def.error=false;
								}
							}
						}
					}
				break;

				case "email":
					if ((value=="") || (value==def.caption)) { def.exp="ничего не указано!"; } else {
						if (value.length<3) { def.exp="слишком короткое значение!"; } else {
							if (value.length>28) { def.exp="слишком длинное значение!"; } else {
								if (!value.match(/\b[\w\.-]+@[\w\.-]+\.\w{2,4}\b/gi)) { def.exp="некорректное значение!"; } else {
									def.error=false;
								}
							}
						}
					}
				break;
				case "phone":
					if ((value=="") || (value==def.caption)) { def.exp="ничего не указано!"; } else {
						if (value.length<3) { def.exp="слишком короткое значение!"; } else {
							if (value.length>28) { def.exp="слишком длинное значение!"; } else {
								if (!value.match(/\+?\d{1,3}(?:\s*\(\d+\)\s*)?(?:(?:\-\d{1,3})+\d|[\d\-]{6,}|(?:\s\d{1,3})+\d)/gi)) { def.exp="некорректное значение!"; } else {
									def.error=false;
								}
							}
						}
					}
				break;

				case "company":
					if ((value=="") || (value==def.caption)) { def.exp="ничего не указано!"; } else {
						if (value.length<3) { def.exp="слишком короткое значение!"; } else {
							if (value.length>28) { def.exp="слишком длинное значение!"; } else {
								if (!value.match(/^([а-яa-z0-9\-\.\,\"\'\<\>\ ]+)$/gi)) { def.exp="некорректное значение!"; } else {
									def.error=false;
								}
							}
						}
					}
				break;
				case "post":
					if ((value=="") || (value==def.caption)) { def.exp="ничего не указано!"; } else {
						if (value.length<3) { def.exp="слишком короткое значение!"; } else {
							if (value.length>28) { def.exp="слишком длинное значение!"; } else {
								if (!value.match(/^([а-яa-z0-9\-\.\,\"\'\ ]+)$/gi)) { def.exp="некорректное значение!"; } else {
									def.error=false;
								}
							}
						}
					}
				break;				
			}
			return def;
		},
		enter:function(options)
		{			
			alert('enter');
			return false;
		},
		reg:function(options)
		{			
			var def={
				'error':false
			};
			var oz=$(this);
			$.extend(true,def,options);
			$(".signin-warning").hide();
			$(".signin-form-warning").hide();
			$(".signin-type-reg").each(function(){
				var th=$(this);
				var check=oz.ozClientSignin('check',
						{
							'type':$(this).data("check-type"),
							'value':$(this).val(),
							'caption':$(this).data("def-value")
						}
				);
				$(".signin-warning").each(function(){
					if ($(this).data("check-type")==th.data("check-type")) {
						if (check.error!=undefined) {
							if (check.error) {
								def.error=true;
								$(this).html(check.start+' "'+check.caption+'" '+check.exp).show();
							}
						}
					}
				});
				$(".signin-form-warning").each(function(){
					if ($(this).data("check-type")==th.data("check-type")) {
						if (check.error!=undefined) {
							if (check.error) {
								$(this).show();
							}
						}
					}
				});

				$(".signin-form-check").each(function(){
					if ($(this).data("check-type")==th.data("check-type")) {
						if (check.error!=undefined) {
							if ($(this).hasClass("signin-form-check-clear")) { $(this).removeClass("signin-form-check-clear"); }
							if (check.error) {
								$(this).removeClass("signin-form-check-true").addClass("signin-form-check-false");
							} else {
								$(this).removeClass("signin-form-check-false").addClass("signin-form-check-true");
							}
						}
					}
				});				
				
			});
			
			
			return false;
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
