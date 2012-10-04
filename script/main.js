
$(function(){
	var conf={};
});

$(function(){
	$.ajax({
		url:"conf/main.json",
		dataType:"json",
		success:function(s){
			window.conf.main=s;
		}
	});
});

$(function(){
	
});


$(function(){
	$(".bar-button").on("click",function(){
		//alert("go!");
		
			alert(window.conf.main.packet.region);
	});

});
