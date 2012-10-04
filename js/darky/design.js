
$(function(){
	$(".bar-button").on("click",function(){
		$(".bar-button").removeClass("bar-button-active").removeClass("bar-button-hover").addClass("bar-button-normal");
		$(this).removeClass("bar-button-normal").removeClass("bar-button-hover").addClass("bar-button-active");
		$(this).blur();
	});
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
});
