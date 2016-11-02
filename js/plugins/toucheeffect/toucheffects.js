/** Used Only For Touch Devices **/
$(document).ready(function() { 
	// for touch devices: add class cs-hover to the figures when touching the items
	if(Modernizr.touch) {
		$( '.imgHover article:not(.generatedMoreLink)  figure').on( 'touchstart', function(e) {
			$(this).find( '.iconLinks > a' ).on( 'touchstart', function(e) {
				e.stopPropagation();
			});
			$(this).toggleClass('cs-hover');
		});
	}
});
