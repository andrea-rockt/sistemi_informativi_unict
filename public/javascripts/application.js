// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


function resize_snowboarder(){
	snowboarder_height = $('span[data-name="user[height]"]').text();
	snowboarder_height /= 2.20;
	snowboarder_height *=100;
	$("#snowboarder").animate({"background-size":snowboarder_height+"%"},1000);
}

$(document).ready( function() {

	$("#flashes:has(#flash)").slideUp(0).slideDown(1000).delay(2000).slideUp(1000);

	$("#close_flash").click( function() {
		$("#flashes:has(#flash)").slideUp(1000);

	})
	
	//$("#")
	resize_snowboarder()
	
	
	$('#toggle_search').live('click',function(){
		alert("turi")
		search_form=$('#search_form')
		if (search_form.attr('visible')=='true'){
			search_form.animate({'top': '-350px'})
			search_form.attr('visible','false')
		}else if(search_form.attr('visible')=='false') {
			search_form.animate({'top': '164px'})
			search_form.attr('visible','true')
		}else{
			search_form.animate({'top': '164px'})
			search_form.attr('visible','true')
		}
	});
	/*$('input[name="user[height]"]').live('focus',function(){
		$(this).mask("9.99");
	})*/
	
	$('#user_avatar').fancybox({
		type: 'inline',
		href: '#form_avatar_upload',
		showCloseButton: true,
		onStart: function(){
			$('#form_avatar_upload').css({'display':'block'});
		},
		onClosed: function(){
			$('#form_avatar_upload').css({'display':'none'});
		}
	})
	
	
	
	//$("#flashes:has(#flash)").fadeOut(1000);

});

