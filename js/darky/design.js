
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

$(function(){
	$(".side-box-link").on("click",function(){
		$(".side-box-link").removeClass("side-box-link-active").removeClass("side-box-link-hover").addClass("side-box-link-normal");
		$(this).removeClass("side-box-link-normal").removeClass("side-box-link-hover").addClass("side-box-link-active");
		$(this).blur();
	});
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
});
