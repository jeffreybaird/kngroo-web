$(document).ready(function() {
	$(".control a, .control input[type=submit]").button();
	button($("a.pencil"), 'ui-icon-pencil');
	button($("a.trash"), 'ui-icon-trash');
	button($("a.plus"), 'ui-icon-plus');
	button($("a.circleplus"), 'ui-icon-circle-plus');
	button($("a.image"), 'ui-icon-image');
	button($("a.help"), 'ui-icon-help');
	button($("a.clipboard"), 'ui-icon-clipboard');
	button($("a.clock"), 'ui-icon-clock');
	button($("a.check"), 'ui-icon-check');
	button($("a.gear"), 'ui-icon-gear');
	$("a.text").button();
	$(".datepicker").datepicker({dateFormat:"yy-mm-dd"});
	$(".tabs").tabs();
	$(".accordion").accordion();

	$("#filters input[type=submit]").live("click", function() {
		document.location = $("#filters form").attr('action') + '?' + $("#filters form").serialize();
		return false;
	});
	
	$("#filters a").live("click", function() {
		if( $(this).next().is(":visible") ) {
			$("#filters a + ul input").each(function() { this.value = null; });
		}
		$(this).next().toggle();
		return false;
	});
});

function button(el,klass) {
	el.button({icons:{primary:klass},text:el.hasClass('text')});
}
