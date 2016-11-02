var isMobile = false;
var isDesktop = false;
function screenSize(){
	//mobile detection
	if(Modernizr.mq('only all and(max-width: 767px)'))
		isMobile = true;
	else
		isMobile = false;
	
	//tablette and mobile detection
	if(Modernizr.mq('only all and(max-width: 1024px)'))
		isDesktop = false;
	else
		isDesktop = true;
}
/* =====================================================================
 * DOCUMENT READY
 * =====================================================================
 */
$(document).ready(function(){
	//RESIZE EVENTS
	$(window).resize(function(){
		screenSize();
		Modernizr.addTest('ipad', function(){
			return !!navigator.userAgent.match(/iPad/i);
		});
	});
	screenSize();
	'use strict';
    
    /* =================================================================
     * form placeholder for IE
     * =================================================================
     */
	if(!Modernizr.input.placeholder){
		$('[placeholder]').focus(function(){
			var input = $(this);
			if(input.val() == input.attr('placeholder')){
				input.val('');
				input.removeClass('placeholder');
			}
		}).blur(function(){
			var input = $(this);
			if(input.val() == '' || input.val() == input.attr('placeholder')){
				input.addClass('placeholder');
				input.val(input.attr('placeholder'));
			}
		}).blur();
		$('[placeholder]').parents('form').submit(function(){
			$(this).find('[placeholder]').each(function(){
				var input = $(this);
				if(input.val() == input.attr('placeholder')){
					input.val('');
				}
			})
		});
	}
    /* =================================================================
     * MAGNIFIC POPUP
     * =================================================================
     */
	if($('a.image-link').length){
        $('a.image-link').magnificPopup({
            type:'image',
            mainClass: 'mfp-with-zoom',
            gallery:{
                enabled: true 
            },
            zoom: {
                enabled: true
            }
        });
	}
    /* =================================================================
     * TOOLTIP
     * =================================================================
     */
	$('.tips').tooltip({placement:'auto'});
    
    /* =================================================================
     * ALERT
     * =================================================================
     */ 
	$('.alert').delegate('button', 'click', function(){
		$(this).parent().fadeOut('fast');
	});
});
