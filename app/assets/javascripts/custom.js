
$(function () {
	"use strict";
	$('.conversation').not('.conversation .respond').click(function () {
		//if $(document.elementFromPoint(event.pageX, event.pageY)).
		$(this).find('.respond').slideToggle(200);
	});
	$('.respond').click(function(e){
		e.stopPropagation();
		//e.preventDefault();

	});
	$('.msg_submit').click(function () {
		var $this = $(this);
		$this.parent().parent().parent().parent().fadeOut(200, function ($this) {
			//$this.remove();
		});
	});
	
	if  ($("div#flash").length < 2) {
		$("div#flash").hide();
	}
	else {
		$("div#flash").delay(2500).slideUp(400);
	}

	$('#new-message').submit(function(){
		console.log(this);

	});
});