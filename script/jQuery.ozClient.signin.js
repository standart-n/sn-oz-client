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
				oz.ozClientSignin('checkEnterForm');
			});
			$("#signin-button-enter").on("click",function(e){
				e.preventDefault();
				oz.ozClientSignin('checkEnterForm');
			});
			$("#signin-form-reg").on("submit",function(e){
				e.preventDefault();
				oz.ozClientSignin('checkRegForm');
			});
			$("#signin-button-reg").on("click",function(e){
				e.preventDefault();
				oz.ozClientSignin('checkRegForm');
			});
			$(".signin-type-reg").on("keyup",function(){
				var th=$(this);
				var check=oz.ozClientSignin('checkField',
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
		checkField:function(options)
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
		checkEnterForm:function(options)
		{			
			alert('enter');
			return false;
		},
		checkRegForm:function(options)
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
				var check=oz.ozClientSignin('checkField',
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
			alert('error?');
			$(this).ozClientSignin('afterCheckRegForm',def);
			return false;
		},
		afterCheckRegForm:function(options)
		{
			var def={
				'error':false
			};
			$.extend(true,def,options);
			if (def.error) {
				$(this).ozClientSignin('regOnServer');
			} else {
				alert('bez oshibok');
			}
		},		
		regOnServer:function(options)
		{
			var def={
				'debug':false,
				'type':'jsonp',
				'firstname':$("#signin-input-firstname").val(),
				'lastname':$("#signin-input-lastname").val(),
				'patronymic':$("#signin-input-patronymic").val(),
				'email':$("#signin-input-email").val(),
				'phone':$("#signin-input-phone").val(),
				'company':$("#signin-input-company").val(),
				'post':$("#signin-input-post").val(),
				'error':false
			};
			var oz=$(this);
			$.extend(true,def,options);
			if (def.debug) { def.type='text'; }
			var sn=$(this).data('ozClient');			

			$.ajax({
				url:'http://oz.st-n.ru/server-dev/?callback=?',
				async:true,
				type:'POST',
				data:{
					action:'registration',
					region:sn.region.name,
					theme:sn.theme.name,
					firstname:def.firstname,
					lastname:def.lastname,
					patronymic:def.patronymic,
					email:def.email,
					phone:def.phone,
					company:def.company,
					post:def.post
				},
				dataType:def.type,
				timeout:10000,
				success:function(s){
					$.extend(true,sn.result,s);
					if (def.debug) { alert("["+s+"]"); }
					$(this).data('ozClient',sn);
					if (sn.result.alert) { alert(sn.result.alert); }
					if (!s.reg) {						
						if (s.valid) {
							oz.ozClientSignin('afterCheckRegFormOnServer',s);
						}
					}
				},
				error:function(XMLHttpRequest,textStatus,error){ alert(error); }
			});			
			
		},
		afterCheckRegFormOnServer:function(options){
			var def={
				'error':false
			};
			var oz=$(this);
			alert('response from server');
			$.extend(true,def,options);
			if (!s.reg) {
				if (s.valid) {
					$.each(s.valid,function(field,val) {
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
				}
			}
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
