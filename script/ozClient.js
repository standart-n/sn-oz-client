var ozClient=jQuery.Class.create({
init:function(sn){
	
	$(function(){ 
		ozClientInit(); 
		alert(sn.region);
	
		$(".bar-button").on("click",function(){
			alert("go!");
		});

	});
	
	function ozClientInit(){
		if (sn==undefined)					{sn={};}
		if (sn.region==undefined) 			{sn.region="kirov";}
	}

	return sn;
}});
