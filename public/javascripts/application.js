// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function(){
	
	$("#flashes:has(#flash)").slideUp(0).slideDown(1000).delay(2000).slideUp(1000);
	
	$("#close_flash").click(function(){
		$("#flashes:has(#flash)").slideUp(1000);
		
	})
	
	
	//$("#flashes:has(#flash)").fadeOut(1000);
	
});


