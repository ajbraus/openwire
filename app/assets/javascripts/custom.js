
$(function () {
	"use strict";
	$('.conversation').not('.conversation .respond').click(function () {
		//if $(document.elementFromPoint(event.pageX, event.pageY)).
		$(this).find('.respond').slideToggle(200);
	});
	$('.respond').click(function(e){
		e.stopPropagation();
		e.preventDefault();

	});
	$('.msg_submit').click(function () {
		var $this = $(this);
		$this.parent().parent().parent().parent().fadeOut(200, function () {
			$this.remove();
		}, $this);
	});
	$("div#flash").delay(2500).slideUp(400);
});