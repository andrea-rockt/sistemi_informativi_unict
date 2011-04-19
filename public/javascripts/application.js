// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


function resize_snowboarder(){
	snowboarder_height = $('span[data-name="user[height]"]').text();
	snowboarder_height /= 1.90;
	snowboarder_height *=362;
	$("#turi").css({height:snowboarder_height});
}

$(document).ready( function() {

	$("#flashes:has(#flash)").slideUp(0).slideDown(1000).delay(2000).slideUp(1000);

	$("#close_flash").click( function() {
		$("#flashes:has(#flash)").slideUp(1000);

	})
	
	resize_snowboarder()

	
	
	//$("#flashes:has(#flash)").fadeOut(1000);

});

