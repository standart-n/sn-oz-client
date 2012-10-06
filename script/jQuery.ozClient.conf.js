(function($){

	var methods={
		init:function(options)
		{
			return this.each(function(){
				$(this).ozClientConf('main');
				$(this).ozClientConf('theme');
				$(this).ozClientConf('css');
				$(this).ozClientConf('js');
				$(this).ozClientConf('settings');
			});
		},
		main:function()
		{
			var sn=$(this).data('ozClient');
			$.ajax({
				url:'conf/main.json',
				async:false,
				dataType:"json",
				success:function(s){
					$.extend(sn,s);
					$(this).data('ozClient',sn);
				}
			});
		},
		theme:function()
		{
			var sn=$(this).data('ozClient');
			$.ajax({
				url:'conf/themes.json',
				async:false,
				dataType:"json",
				success:function(s){
					if (s[sn.theme.name]) {
						$.extend(sn.theme,s[sn.theme.name]);
						sn.theme.enable=true;
					} else {
						sn.theme.enable=false;
					}
					$(this).data('ozClient',sn);					
				}
			});
		},
		css:function()
		{
			var sn=$(this).data('ozClient');
			if (sn.theme.css) {
				$.each(sn.theme.css,function(i){
					//document.write('<link rel="stylesheet" type="text/css" href="'+this+'">'); 
					var head=document.getElementsByTagName('head')[0];
					var link=document.createElement('link');
					link.rel='stylesheet';
					link.type='text/css';
					link.href=this;
					head.appendChild(link);
				});
			}			
		},
		js:function()
		{
			var sn=$(this).data('ozClient');
			if (sn.theme.js) {
				$.each(sn.theme.js,function(i){
					$.getScript(this,function(){});      
				});
			}			
		},
		settings:function()
		{
			$(this).ozClientConf('design');
		},
		design:function()
		{
			var sn=$(this).data('ozClient');
			sn.design={};
			$.ajax({
				url:'settings/'+sn.region.name+'/design.json',
				async:false,
				dataType:"json",
				success:function(s){
					$.extend(sn.design,s);
					$(this).data('ozClient',sn);
				}
			});
		}
	};

	$.fn.ozClientConf=function(sn){
		if (!sn) { var sn={}; }
		if (methods[sn]) {
			return methods[sn].apply(this,Array.prototype.slice.call(arguments,1));
		} else if (typeof sn==='object' || !method) {
			return methods.init.apply(this,arguments);
		} else {
			$.error('Метод '+sn+' не существует');
		}    
		
	};		
})(jQuery);
