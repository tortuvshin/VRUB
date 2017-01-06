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
    /*$('a[href^="#"]:not(a[href$="#"])').on('click', function(e){
        e.defaultPrevented;
        var target = $(this).attr('href');
        $('html, body').animate({
            scrollTop: $(target).offset().top - parseInt($('body').css('padding-top'))
        }, 1400, 'easeInOutCirc');
        return false;
    });*/
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
        
        //var scrolltop = isDesktop ? $('html, body').scrollTop() : $('body').scrollTop();
        
        if(scrolltop >= 200) $('a#toTop').css({bottom: '30px'});
        else $('a#toTop').css({bottom: '-40px'});
        if(scrolltop > 0) $('.navbar-fixed-top').addClass('fixed');
        else $('.navbar-fixed-top').removeClass('fixed');
    });
    $(window).trigger('scroll');

    /* =================================================================
     * COOKIES
     * =================================================================
     */
    if($('#cookies-notice').length){
        $('#cookies-notice button').on('click', function(){
            $.cookie('cookies_enabled', '1', {expires: 7});
            $('#cookies-notice').fadeOut();
        });
     }
    /* =================================================================
     * LIVE SEARCH
     * =================================================================
     */
    if($('.liveSearch').length){
        $('.liveSearch').each(function(){
            var elm = $(this);
            var scriptUrl = elm.data('url');
            var wrapperID = elm.data('wrapper');
            var targetID = elm.data('target');
            if(scriptUrl != ''){
                $('.liveSearch').liveSearch({
                    url: scriptUrl+'?q=',
                    id: wrapperID
                });
                $('#'+wrapperID).on('click', '.live-search-result', function(){
                    elm.val($(this).data('descr'));
                    $('#'+targetID).val($(this).data('id'));
                });
            }
        });
    }
    /* =================================================================
     * AJAX
     * =================================================================
     */
    if($('form.ajax-form').length){
         function sendAjaxForm(form, action, targetCont, refresh){
            var posQuery = action.indexOf('?');
            var extraData = '';
            if(posQuery != -1){
                extraData = action.substr(posQuery+1);
                if(extraData != '') extraData = '&'+extraData;
                action = action.substr(0, posQuery);
            }
            $.ajax({
                url: action,
                type: form.attr('method'),
                data: form.serialize()+extraData,
                success: function(response){
                    $('.field-notice',form).html('').hide().parent().removeClass('alert alert-danger');
                    $('.alert.alert-danger').html('').hide();
                    $('.alert.alert-success').html('').hide();
                    
                    var response = $.parseJSON(response);
                    
                    if(targetCont != '') $(targetCont).removeClass('loading-ajax');
                    
                    if(response.error != '') $('.alert.alert-danger', form).html(response.error).slideDown();
                    else if(response.redirect != '' && response.redirect != undefined) window.location.href = response.redirect;
                    else if(refresh === true) window.location.reload(true);
                    if(response.success != '') $('.alert.alert-success', form).html(response.success).slideDown();
                    
                    if(!$.isEmptyObject(response.notices)){
                        if(targetCont != "") $(targetCont).hide();
                        $.each(response.notices, function(field,notice){
                            var elm = $('.field-notice[rel="'+field+'"]', form);
                            if(elm.get(0) !== undefined) elm.html(notice).fadeIn('slow').parent().addClass('alert alert-danger');
                        });
                        $('.captcha_refresh', form).trigger('click');
                    }else{
                        if(targetCont != ""){
                            $(targetCont).html(response.html);
                            $('.open-popup-link').magnificPopup({
                                type:'inline',
                                midClick: true
                            });
                            $('.selectpicker').selectpicker('refresh');
                        }
                    }
                } 
            });
        }
        $('form.ajax-form').on('click change', '.sendAjaxForm', function(e){
            var elm = $(this);
            var tagName = elm.prop('tagName');
            if((e.type == 'click' && ((tagName == 'INPUT' && (elm.attr('type') == 'submit' || elm.attr('type') == 'image')) || tagName == 'A' || tagName == 'BUTTON')) || e.type == 'change'){
                var targetCont = elm.data('target');
                var refresh = elm.data('refresh');
                if(targetCont != "") $(targetCont).html('').addClass('loading-ajax').show();
                sendAjaxForm(elm.parents('form'), elm.data('action'), targetCont, refresh);
                if(tagName == 'A') return false;
            }else{
                if(tagName == 'A') return false;
            }
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
     * FACEBOOK LOGIN
     * =================================================================
     */
    function fblogout(){    
        FB.logout(function(){   
            window.location.reload();
        });    
    }
    window.fbAsyncInit = function(){
        FB.init({
            appId   : '194398910928420',    
            secret  : '646766d08dea2c372ce097269e363012',
            status  : true,    
            cookie  : true,    
            xfbml   : true    
        });    

        FB.Event.subscribe('auth.login', function() {    
            window.location.reload();    
        });    
    };  
    $(function(){
        var e = document.createElement('script');  
        e.src = document.location.protocol + '//connect.facebook.net/en_US/all.js';    
        e.async = true;    
        document.getElementById('fb-root').appendChild(e);
    });
    function fblogin(){    
        FB.login(function(response){    
            
            $.ajax({
                url: document.location.protocol + '//www.aaa.com/includes/php/fb_connect.php',
                type: 'POST',
                success: function(response){
                    if(response == 'ok'){
                        if(redirect_url != '') document.location.href = redirect_url; else document.location.reload();
                    }
                }
            });
            return false;
            
        }, {scope:'email,read_stream,publish_stream,offline_access'});    
    }
    $('a.fblogin').click(function(e){
        e.defaultPrevented;
        fblogin();
    });
    
    /* =================================================================
     * SIGN UP/LOG IN FORM
     * =================================================================
     */
    $(function(){
        $('.login-form').show();
        $('.signup-form').hide();
        $('.pass-form').hide();
        
        $('.open-signup-form').click(function(){
            $('.pass-form').slideUp();
            $('.login-form').slideUp();
            $('.signup-form').slideDown();
            return false;
        });
        $('.open-login-form').click(function(){
            $('.pass-form').slideUp();
            $('.signup-form').slideUp();
            $('.login-form').slideDown();
            return false;
        });
        $('.open-pass-form').click(function(){
            $('.signup-form').slideUp();
            $('.login-form').slideUp();
            $('.pass-form').slideDown();
            return false;
        });
    });
     
    /* =================================================================
     * MAGNIFIC POPUP (MODAL)
     * =================================================================
     */
	if($('.popup-modal').length){
        $('.popup-modal').magnificPopup({
            type: 'inline',
            preloader: false,
            closeBtnInside: false,
            callbacks: {
                open: function(){
                    
                    var content = $(this.content);
                    
                    if($('.owl-carousel', content).length){
                        $('.owl-carousel', content).each(function(){
                            $(this).addClass('owlWrapper').owlCarousel({
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
                }
            }
        });
        $(document).on('click', '.popup-modal-dismiss', function(e){
            e.defaultPrevented;
            $.magnificPopup.close();
        });
        $('.popup-modal').click(function(e){
            e.defaultPrevented;
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
            e.defaultPrevented;
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
    $('.panel-collapse').on('shown.bs.collapse', function(e){
        if($('.img-container').length){
            $('.img-container').imagefill();
        }
    });
    /* =================================================================
     * SHARRRE
     * =================================================================
     */
    var sharrre_media = "";
    var sharrre_descr = "";
    if($('meta[itemprop="image"]').length)
        sharrre_media = $('meta[itemprop="image"]').attr('content');
    if($('meta[name="description"]').length)
        sharrre_descr = $('meta[name="description"]').attr('content');
    
    if($('#twitter').length){
        $('#twitter').sharrre({
            share: {
                twitter: true
            },
            template: '<a class="count" href="#">{total}</a><a class="share">Tweet</a>',
            enableHover: false,
            enableTracking: false,
            enableCounter: false,
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
            template: '<a class="count" href="#">{total}</a><a class="share">Share</a>',
            enableHover: false,
            enableTracking: false,
            enableCounter: false,
            buttons: { facebook: {}},
            click: function(api, options){
                api.simulateClick();
                api.openPopup('facebook');
            }
        });
    }
    if($('#pinterest').length){
        $('#pinterest').sharrre({
            share: {
                pinterest: true
            },
            template: '<a class="count" href="#">{total}</a><a class="share">Pin it</a>',
            enableHover: false,
            enableTracking: true,
            enableCounter: false,
            buttons: {
                pinterest: {
                    media: sharrre_media,
                    description: sharrre_descr,
                    layout: 'vertical'
                }
            },
            click: function(api, options){
                api.simulateClick();
                api.openPopup('pinterest');
            }
        });
    }
    if($('#googleplus').length){
        $('#googleplus').sharrre({
            share: {
                googlePlus: true
            },
            template: '<a class="count" href="#">{total}</a><a class="share">+1</a>',
            enableHover: false,
            enableTracking: true,
            enableCounter: false,
            buttons: { googlePlus: {}},
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
        function royalSliderInit(){
            var height = $(window).height()-parseInt($('body').css('padding-top'));
            var width = $(window).width();
            $('.royalSlider').height(height);
            setTimeout(function(){
                $('.royalSlider').royalSlider({
                    arrowsNav: true,
                    loop: true,
                    keyboardNavEnabled: true,
                    controlsInside: false,
                    imageScaleMode: 'fill',
                    arrowsNavAutoHide: false,
                    autoHeight: false,
                    autoScaleSlider: false,
                    autoScaleSliderWidth: width,     
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
            }, 400);
        }
        royalSliderInit();
        $(window).resize(function(){
            royalSliderInit();
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
		script.src = '//maps.google.com/maps/api/js?callback=initialize';
        if($('#mapWrapper').data('api_key') != '') script.src += '&key='+$('#mapWrapper').data('api_key');
		document.body.appendChild(script);
	}
    /*==================================================================
     * ACTIV'MAP
     * =================================================================
     */
    if($('#activmap-wrapper').length){
        var script = document.createElement('script');
		script.type = 'text/javascript';
		script.src = '//maps.googleapis.com/maps/api/js?v=3.exp&libraries=places&sensor=false&callback=activmap_init';
        if($('#activmap-wrapper').data('api_key') != '') script.src += '&key='+$('#activmap-wrapper').data('api_key');
		document.body.appendChild(script);
    }
});
function activmap_init(){
    var elm = $('#activmap-wrapper');
    elm.activmap({
        lat: elm.data('lat'),
        lng: elm.data('lng'),
        places: locations,
        icon: '',
        posPanel: 'left',
        showPanel: true,
        radius: elm.data('radius'),
        zoom: elm.data('zoom'),
        cluster: true,
        mapType: 'roadmap'
    });
}
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
		zoom: 14,
		styles:[
			{
				'featureType': 'water',
				'stylers': [
				{
					'color': '#AAC6ED'
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
