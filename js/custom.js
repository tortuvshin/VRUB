/* =====================================================================
 * DOCUMENT READY
 * =====================================================================
 */
$(document).ready(function(){
    $(window).resize(function(){
		Modernizr.addTest('ipad', function(){
			return !!navigator.userAgent.match(/iPad/i);
		});
		if(!Modernizr.ipad){	
			initializeMainMenu(); 
		}
	});
    'use strict';
	initializeMainMenu();
    $('a[href^="#"]:not(a[href$="#"])').on('click', function(e){
        e.defaultPrevented;
        var target = $(this).attr('href');
        $('html, body').animate({
            scrollTop: $(target).offset().top - parseInt($('body').css('padding-top'))
        }, 1400, 'easeInOutCirc');
        return false;
    });
    $('a#toTop').on('click', function(e){
        e.defaultPrevented;
        $('html, body').animate({scrollTop: '0px'});
    });
    $('body').bind('touchmove', function(e){
        $(window).trigger('scroll');
    });
    $(window).on('onscroll scrollstart touchmove', function(){
        $(window).trigger('scroll');
    });
    $(window).scroll(function(){
        var scroll_1 = $('html, body').scrollTop();
        var scroll_2 = $('body').scrollTop();
        var scrolltop = scroll_1;
        if(scroll_1 == 0) scrolltop = scroll_2;
        
        if(scrolltop >= 200) $('a#toTop').css({bottom: '30px'});
        else $('a#toTop').css({bottom: '-40px'});
        if(scrolltop > 0) $('.navbar-fixed-top').addClass('fixed');
        else $('.navbar-fixed-top').removeClass('fixed');
    });
    $(window).trigger('scroll');

    /* =================================================================
     * AJAX
     * =================================================================
     */
     if($('form.ajax-form').length){
         function sendAjaxForm(form, action, targetCont){
            $.ajax({
                url: action,
                type: form.attr('method'),
                data: form.serialize(),
                success: function(response){
                    $('.field-notice',form).html('').hide().parent().removeClass('alert alert-danger');
                    $('.alert.alert-danger').html('').hide();
                    $('.alert.alert-success').html('').hide();
                    
                    var response = $.parseJSON(response);
                    
                    if(targetCont != '') $(targetCont).removeClass('loading-ajax');
                    
                    if(response.error != '') $('.alert.alert-danger').html(response.error).slideDown();
                    if(response.success != '') $('.alert.alert-success').html(response.success).slideDown();
                    
                    if(!$.isEmptyObject(response.notices)){
                        if(targetCont != "") $(targetCont).hide();
                        $.each(response.notices, function(field,notice){
                            var elm = $('.field-notice[rel="'+field+'"]');
                            if(elm.get(0) !== undefined) elm.html(notice).fadeIn('slow').parent().addClass('alert alert-danger');
                        });
                        $('.captcha_refresh',form).trigger('click');
                    }else{
                        if(targetCont != ""){
                            $(targetCont).html(response.html);
                            $('.open-popup-link').magnificPopup({
                                type:'inline',
                                midClick: true
                            });
                        }
                    }
                } 
            });
        }
        $('form.ajax-form').on('change', '.sendAjaxForm', function(){
            var elm = $(this);
            var targetCont = elm.data('target');
            if(targetCont != "") $(targetCont).html('...').addClass('loading-ajax').show();
            sendAjaxForm(elm.parents('form'), elm.data('action'), targetCont);
            if(elm.prop('tagName') == 'A') return false;
        });
        $('.submitOnClick').on('click', function(e){
            e.defaultPrevented;
            $(this).parents('form').submit();
            return false;
        });
    }
    if($('a.ajax-link').length){
        $('a.ajax-link').on('click', function(e){
            e.defaultPrevented;
            var elm = $(this);
            var href = elm.attr('href');
            $.ajax({
                url: elm.data('action'),
                type: 'get',
                success: function(response){
                    if(href != '' && href != '#') $(location).attr('href', href);
                } 
            });
            return false;
        });
    }
    
    /* =================================================================
     * DATEPICKER
     * =================================================================
     */
    if($('#from_picker').length && $('#to_picker').length){
        $('#from_picker').datepicker({
            dateFormat: 'dd/mm/yy',
            minDate: 0,
            onClose: function(selectedDate){
                var a = selectedDate.split('/');
                var d = new Date(a[2]+'/'+a[1]+'/'+a[0]);
                var t = new Date(d.getTime()+86400000);
                var date = t.getDate()+'/'+(t.getMonth()+1)+'/'+t.getFullYear();
                $('#to_picker').datepicker('option', 'minDate', date);
            }
        });
        $('#to_picker').datepicker({
            dateFormat: 'dd/mm/yy',
            defaultDate: '+1w'
        });
    }

    /* =================================================================
     * CALENDAR
     * =================================================================
     */
    if($('.hb-calendar').length > 0){
        $('.hb-calendar').each(function(){
            var obj = $(this);
            obj.eCalendar({
                ajaxDayLoader : obj.data('day_loader'),
                customVar : obj.data('custom_var'),
                currentMonth : obj.data('cur_month'),
                currentYear : obj.data('cur_year')
            });
        });
    }

    /* =================================================================
     * BOOTSTRAP MINUS AND PLUS
     * =================================================================
     */
    $('.btn-number').on('click', function(e){
        e.defaultPrevented;
        fieldName = $(this).attr('data-field');
        type = $(this).attr('data-type');
        var input = $('input[name="'+fieldName+'"]');
        var currentVal = parseInt(input.val());
        if(!isNaN(currentVal)){
            if(type == 'minus'){
                if(currentVal > input.attr('min'))
                    input.val(currentVal - 1).change();
                if(parseInt(input.val()) == input.attr('min'))
                    $(this).attr('disabled', true);
            }else if(type == 'plus'){
                if(currentVal < input.attr('max'))
                    input.val(currentVal + 1).change();
                if(parseInt(input.val()) == input.attr('max'))
                    $(this).attr('disabled', true);
            }
        }else
            input.val(0);
    });
    $('.input-number').focusin(function(){
       $(this).data('oldValue', $(this).val());
    });
    $('.input-number').change(function(){
        minValue =  parseInt($(this).attr('min'));
        maxValue =  parseInt($(this).attr('max'));
        valueCurrent = parseInt($(this).val());
        name = $(this).attr('name');
        if(valueCurrent >= minValue)
            $('.btn-number[data-type="minus"][data-field="'+name+'"]').removeAttr('disabled');
        else{
            alert('Sorry, the minimum value was reached');
            $(this).val($(this).data('oldValue'));
        }
        if(valueCurrent <= maxValue)
            $('.btn-number[data-type="plus"][data-field="'+name+'"]').removeAttr('disabled');
        else{
            alert('Sorry, the maximum value was reached');
            $(this).val($(this).data('oldValue'));
        } 
    });
    $('.input-number').keydown(function(e){
        if($.inArray(e.keyCode, [46, 8, 9, 27, 13, 190]) !== -1 ||
            (e.keyCode == 65 && e.ctrlKey === true) || 
            (e.keyCode >= 35 && e.keyCode <= 39))
                 return;
                 
        if((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105))
            e.preventDefault();
    });

    /* =================================================================
     * ISOTOPE
     * =================================================================
     */
    if($('.isotopeWrapper').length){
        var $container = $('.isotopeWrapper');
        var $resize = $('.isotopeWrapper').attr('id');
        setTimeout(function(){
            $container.addClass('loaded').isotope({
                layoutMode: 'sloppyMasonry',
                itemSelector: '.isotopeItem',
                resizable: false,
                masonry: {
                    columnWidth: $container.width() / $resize
                }
            });
        }, 800);
        $('#filter a').on('click', function(e){
            e.defaultPrevented;
            $('#filter a').removeClass('current');
            $(this).addClass('current');
            var selector = $(this).attr('data-filter');
            $container.isotope({
                filter: selector,
                animationOptions: {
                    duration: 300,
                    easing: 'easeOutQuart'
                }
            });
            return false;
        });
        $(window).smartresize(function(){
            $container.isotope({
                masonry: {
                    columnWidth: $container.width() / $resize
                }
            });
        });
    }
    /* =================================================================
     * IMAGE FILL
     * =================================================================
     */
	if($('.img-container').length){
		$('.img-container').imagefill();
	}
    /* =================================================================
     * SHARRRE
     * =================================================================
     */
    if($('#twitter').length){
        $('#twitter').sharrre({
            share: {
                twitter: true
            },
            enableHover: false,
            enableTracking: false,
            buttons: { twitter: {}},
            click: function(api, options){
                api.simulateClick();
                api.openPopup('twitter');
            }
        });
    }
    if($('#facebook').length){
        $('#facebook').sharrre({
            share: {
                facebook: true
            },
            enableHover: false,
            enableTracking: false,
            click: function(api, options){
                api.simulateClick();
                api.openPopup('facebook');
            }
        });
    }
    if($('#googleplus').length){
        $('#googleplus').sharrre({
            share: {
                googlePlus: true
            },
            enableHover: false,
            enableTracking: true,
            urlCurl: $('#googleplus').attr('data-curl'),
            click: function(api, options){
                api.simulateClick();
                api.openPopup('googlePlus');
            }
        });
    }
    /* =================================================================
     * ROYAL SLIDER
     * =================================================================
     */
    if($('.royalSlider').length){
        var height = $(window).height()-parseInt($('body').css('padding-top'));
        $('.royalSlider').royalSlider({
            arrowsNav: true,
            loop: true,
            keyboardNavEnabled: true,
            controlsInside: false,
            imageScaleMode: 'fill',
            arrowsNavAutoHide: false,
            autoHeight: false,
            autoScaleSlider: false,
            autoScaleSliderWidth: 960,     
            autoScaleSliderHeight: height,
            controlNavigation: 'bullets',
            thumbsFitInViewport: false,
            navigateByClick: true,
            startSlideId: 0,
            autoPlay: {
                enabled: true,
                pauseOnHover: true,
                delay: 4000
            },
            transitionType:'fade',
            globalCaption: false,
            deeplinking: {
                enabled: true,
                change: false
            }
        });
    }
    /* =================================================================
     * LAZY LOADER
     * =================================================================
     */
    if($('.lazy-wrapper').length){
        $('.lazy-wrapper').each(function(){
            $(this).lazyLoader({
                loader: $(this).data('loader'),
                mode: $(this).data('mode'),
                limit: $(this).data('limit'),
                pages: $(this).data('pages'),
                variables: $(this).data('variables'),
                isIsotope: $(this).data('is_isotope')
            });
        });
    }
    /* =================================================================
     * OWL CAROUSEL
     * =================================================================
     */
    if($('.owlWrapper').length){
        $('.owlWrapper').each(function(){
            $(this).owlCarousel({
                items: $(this).data('items'),
                nav: $(this).data('nav'),
                dots: $(this).data('dots'),
                autoplay: $(this).data('autoplay'),
                mouseDrag: $(this).data('mousedrag'),
                rtl: $(this).data('rtl'),
                responsive: true
            });
        });
    }
    /*==================================================================
     * GOOGLE MAP
     * =================================================================
     */
	if($('#mapWrapper').length){
		var script = document.createElement('script');
		script.type = 'text/javascript';
		script.src = '//maps.google.com/maps/api/js?sensor=false&callback=initialize';
		document.body.appendChild(script);
	}
});
function initialize(id){
	'use strict';
	var overlayTitle = 'Agencies';
	/*var locations = [
		['Big Ben', 'London SW1A 0AA','51.500729','-0.124625']
	];*/
	id =(id === undefined) ? 'mapWrapper' : id;
    
    var image = $('#'+id).attr('data-marker');
	var map = new google.maps.Map(document.getElementById(id),{
		mapTypeId: google.maps.MapTypeId.ROADMAP,
		scrollwheel: false,
		zoomControl: true,
		zoomControlOptions:{
			style: google.maps.ZoomControlStyle.LARGE,
			position: google.maps.ControlPosition.LEFT_CENTER
		},
		streetViewControl:true,
		scaleControl:false,
		zoom: 12,
		styles:[
			{
				'featureType': 'water',
				'stylers': [
				{
					'color': '#CEE4ED'
				},
				]
			},
			{
				'featureType': 'road',
				'elementType': 'geometry.fill',
				'stylers': [
				{
					'color': '#FCFFF5'
				},
				]
			},
			{
				'featureType': 'road',
				'elementType': 'geometry.stroke',
				'stylers': [
				{
					'color': '#808080'
				},
				{
					'lightness': 54
				}
				]
			},
			{
				'featureType': 'landscape.man_made',
				'elementType': 'geometry.fill',
				'stylers': [
				{
					'color': '#D5D8E0'
				}
				]
			},
			{
				'featureType': 'poi.park',
				'elementType': 'geometry.fill',
				'stylers': [
				{
					'color': '#CBDFAB'
				}
				]
			},
			{
				'featureType': 'road',
				'elementType': 'labels.text.fill',
				'stylers': [
				{
					'color': '#767676'
				}
				]
			},
			{
				'featureType': 'road',
				'elementType': 'labels.text.stroke',
				'stylers': [
				{
					'color': '#ffffff'
				}
				]
			},
			{
				'featureType': 'road.highway',
				'elementType': 'geometry.fill',
				'stylers': [
				{
					'color': '#888888'
				}
				]
			},
			{
				'featureType': 'landscape.natural',
				'elementType': 'geometry.fill',
				'stylers': [
				{
					'visibility': 'on'
				},
				{
					'color': '#efefef'
				}
				]
			},
			{
				'featureType': 'poi.park',
				'stylers': [
				{
					'visibility': 'on'
				}
				]
			},
			{
				'featureType': 'poi.sports_complex',
				'stylers': [
				{
					'visibility': 'on'
				}
				]
			},
			{
				'featureType': 'poi.medical',
				'stylers': [
				{
					'visibility': 'on'
				}
				]
			},
			{
				'featureType': 'poi.business',
				'stylers': [
				{
					'visibility': 'simplified'
				}
				]
			}
		]
	});
	var myLatlng;
	var marker, i;
	var bounds = new google.maps.LatLngBounds();
	var infowindow = new google.maps.InfoWindow({ content: 'loading...' });
	for(i = 0; i < locations.length; i++){ 
		if(locations[i][2] !== undefined && locations[i][3] !== undefined){
			var content = '<div class="infoWindow">'+locations[i][0]+'<br>'+locations[i][1]+'</div>';
			(function(content){
				myLatlng = new google.maps.LatLng(locations[i][2], locations[i][3]);
				marker = new google.maps.Marker({
					position: myLatlng,
					icon:image,	
					title: overlayTitle,
					map: map
				});
				google.maps.event.addListener(marker, 'click',(function(){
					return function(){
						infowindow.setContent(content);
						infowindow.open(map, this);
					};
				})(this, i));
				if(locations.length > 1){
					bounds.extend(myLatlng);
					map.fitBounds(bounds);
				}else{
					map.setCenter(myLatlng);
				}
			})(content);
		}else{
			var geocoder	= new google.maps.Geocoder();
			var info	= locations[i][0];
			var addr	= locations[i][1];
			var latLng = locations[i][1];
			(function(info, addr){
				geocoder.geocode({
					'address': latLng
				}, function(results){
					myLatlng = results[0].geometry.location;
					marker = new google.maps.Marker({
						position: myLatlng,
						icon:image,	
						title: overlayTitle,
						map: map
					});
					var $content = '<div class="infoWindow">'+info+'<br>'+addr+'</div>';
					google.maps.event.addListener(marker, 'click',(function(){
						return function(){
							infowindow.setContent($content);
							infowindow.open(map, this);
						};
					})(this, i));
					if(locations.length > 1){
						bounds.extend(myLatlng);
						map.fitBounds(bounds);
					}else{
						map.setCenter(myLatlng);
					}
				});
			})(info, addr);
		}
	}
}
/* =====================================================================
 * MAIN MENU
 * =====================================================================
 */
function initializeMainMenu(){
	'use strict';
	var $mainMenu = $('#mainMenu').children('ul');
	if(Modernizr.mq('only all and(max-width: 767px)')){
		// Responsive Menu Events
		var addActiveClass = false;
		$('a.hasSubMenu').unbind('click');
		$('li',$mainMenu).unbind('mouseenter mouseleave');
		$('a.hasSubMenu').on('click', function(e){
			e.defaultPrevented;
			addActiveClass = $(this).parent('li').hasClass('Nactive');
			if($(this).parent('li').hasClass('primary'))
				$('li', $mainMenu).removeClass('Nactive');
			else
				$('li:not(.primary)', $mainMenu).removeClass('Nactive');
			
			if(!addActiveClass)
				$(this).parents('li').addClass('Nactive');
			else
				$(this).parent().parent('li').addClass('Nactive');
			
			return;
			
		});
	}else if(Modernizr.mq('only all and(max-width: 1024px)') && Modernizr.touch){	
		$('a.hasSubMenu').attr('href', '');
		$('a.hasSubMenu').on('touchend',function(e){
			e.defaultPrevented;
			var $li = $(this).parent(),
			$subMenu = $li.children('.subMenu');
			if($(this).data('clicked_once')){
				if($li.parent().is($(':gt(1)', $mainMenu))){
					if($subMenu.css('display') == 'block'){
						$li.removeClass('hover');
						$subMenu.css('display', 'none');
					}else{
						$('.subMenu').css('display', 'none');
						$subMenu.css('display', 'block'); 
					}
				}else
					$('.subMenu').css('display', 'none');
				$(this).data('clicked_once', false);	
			}else{
				$li.parent().find('li').removeClass('hover');	
				$li.addClass('hover');
				if($li.parent().is($(':gt(1)', $mainMenu))){
					$li.parent().find('.subMenu').css('display', 'none');
					$subMenu.css('left', $subMenu.parent().outerWidth(true));
					$subMenu.css('display', 'block');
				}else{
					$('.subMenu').css('display', 'none');
					$subMenu.css('display', 'block');
				}
				$('a.hasSubMenu').data('clicked_once', false);
				$(this).data('clicked_once', true);
				
			}
			return false;
		});
		window.addEventListener('orientationchange', function(){
			$('a.hasSubMenu').parent().removeClass('hover');
			$('.subMenu').css('display', 'none');
			$('a.hasSubMenu').data('clicked_once', false);
		}, true);
	}else{
		$('li', $mainMenu).removeClass('Nactive');
		$('a', $mainMenu).unbind('click');
		$('li',$mainMenu).hover(
			function(){
				var $this = $(this),
				$subMenu = $this.children('.subMenu');
				if($subMenu.length ){
					$this.addClass('hover').stop();
				}else{
					if($this.parent().is($(':gt(1)', $mainMenu))){
						$this.stop(false, true).fadeIn('slow');
					}
				}
				if($this.parent().is($(':gt(1)', $mainMenu))){
					$subMenu.stop(true, true).fadeIn(200,'easeInOutQuad'); 
					$subMenu.css('left', $subMenu.parent().outerWidth(true));
				}else
					$subMenu.stop(true, true).delay(300).fadeIn(200,'easeInOutQuad');
                    
			},
            function(){
				var $nthis = $(this),
				$subMenu = $nthis.children('ul');
				if($nthis.parent().is($(':gt(1)', $mainMenu))){
					$nthis.children('ul').hide();
					$nthis.children('ul').css('left', 0);
				}else{
					$nthis.removeClass('hover');
					$('.subMenu').stop(true, true).delay(300).fadeOut();
				}
				if($subMenu.length ){$nthis.removeClass('hover');}
            }
        );
	}
}
