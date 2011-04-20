$('form input[data-mask]').live('focus', function() {
	element= $(this)
	element.mask(element.attr("data-mask"));
});
