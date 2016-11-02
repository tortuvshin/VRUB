(function($){

    $.lazyLoader = {
		defaults: {
			loader: 'get_data.php',
			pages: 1,
			limit: 50,
            mode: 'scroll',
            more_caption: 'Load more',
            variables: '',
            isIsotope: false
		}
	};
    
    $.fn.extend({
		
		lazyLoader : function(settings){
		
			var elems = this;
			var s = $.extend({}, $.lazyLoader.defaults, settings);
                
            elems.each(function(){
				
                var Obj = {
                    elem: $(this),
                    page: 2,
                    loading: false,
                    oldscroll: 0,
                    img_loading: null,
                    _init: function(){
                        this.more_wrapper = $('<div class="lazy-more-wrapper">').appendTo(this.elem);
                        if(s.mode == 'scroll')
                            this.img_loading = $('<div class="lazy-img-loading">').appendTo(this.more_wrapper);
                        if(s.mode == 'click')
                            this.more_btn = $('<a class="lazy-more-btn">'+s.more_caption+'</a>').appendTo(this.more_wrapper);
                    },
                    _load_content: function(){
						var obj = this;
                        $.ajax({
                            'url' : s.loader,
                            'type' : 'post',
                            'data' : 'offset='+obj.page+'&limit='+s.limit+'&ajax=1&'+s.variables,
                            success:function(data){
                                var data = $.parseJSON(data);
                                obj.elem.removeClass('loading');
                                
                                if(s.isIsotope){
                                    $(data.html).imagesLoaded(function(){
                                        $('.isotopeWrapper').isotope('insert', $(data.html), function(){
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
                                        });
                                    });
                                }else
                                    $(data.html).hide().appendTo(obj.elem).fadeIn(1000);
                                    
                                
                                
                                obj.page++;
                                obj.more_wrapper.fadeOut();
                                obj.loading = false;
                            }
                        });	
                    }
                }
                Obj._init();

                $(window).scroll(function(){
                    if(($(window).scrollTop() + $(window).height() >= Obj.elem.offset().top + Obj.elem.height()) && (Obj.page <= s.pages)){
                        if(!Obj.loading){
                            Obj.loading = true;
                            Obj.elem.addClass('loading');
                            Obj.more_wrapper.fadeIn();
                            
                            if(s.mode == 'scroll'){
                                setTimeout(function(){
                                    Obj._load_content();
                                },500);
                            }
                            if(s.mode == 'click'){
                                Obj.more_btn.unbind('click').click(function(){
                                    Obj._load_content();
                                });
                            }
                        }
                    }
                });
            });
        }
    });
})(jQuery);
