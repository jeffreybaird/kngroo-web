$(document).ready(function() {
	styleButtons();

	// $("#filters input[type=submit]").live("click", function() {
	// 	document.location = $("#filters form").attr('action') + '?' + $("#filters form").serialize();
	// 	return false;
	// });
	// 
	// $("#filters a").live("click", function() {
	// 	if( $(this).next().is(":visible") ) {
	// 		$("#filters a + ul input").each(function() { this.value = null; });
	// 	}
	// 	$(this).next().toggle();
	// 	return false;
	// });
	
	initialLocation = new google.maps.LatLng(27.7657260197085,-82.63374998029151);
});

function button(el,klass) {
	el.button({icons:{primary:klass},text:el.hasClass('text')});
}

function styleButtons() {
	$(".control a, input[type=submit]").button();
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
	$(".radio").buttonset();
}

// map code

var map;
var initialLocation;
var markers = new Array();

function showMap() {
	var myOptions = {
		zoom: 10,
		minZoom: 6,
		maxZoom: 16,
		mapTypeId: google.maps.MapTypeId.ROADMAP
	};
	map = new google.maps.Map(document.getElementById("map"), myOptions);

	google.maps.event.addListener(map, "bounds_changed", function() {
		$('#sw').val(map.getBounds().getSouthWest().lat()+","+map.getBounds().getSouthWest().lng());
		$('#ne').val(map.getBounds().getNorthEast().lat()+","+map.getBounds().getNorthEast().lng());
	});

	if(false && navigator.geolocation) {
		browserSupportFlag = true;
		navigator.geolocation.getCurrentPosition(function(position) {
			initialLocation = new google.maps.LatLng(position.coords.latitude,position.coords.longitude);
			map.setCenter(initialLocation);
		}, function() {
			handleNoGeolocation(browserSupportFlag);
		});
	}else{
		handleNoGeolocation(false);
	}
}

function clearOverlays() {
	for(var k=0;k<markers.length;k++) {
		markers[k].setMap(null);
	}
	markers = new Array();
}

function handleNoGeolocation(errorFlag) {
	if( errorFlag ) {
		alert("Geolocation service failed");
	}
	map.setCenter(initialLocation);
}
