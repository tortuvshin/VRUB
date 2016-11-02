$(function(){  

    'use strict';

    var $colorsHTML =
    '<div id="style-switcher">' +
    '<a href="#" id="switcherToggle"><i class="fa fa-cog"></i></a>' +
    '<h1>style switcher</h1><h2>Color</h2><ul class="color-switcher">' +
    '<li><a href="orange" style="background:#F24937">Orange</a></li>' +
    '<li><a href="yellow" style="background:#FFC300">Yellow</a></li>' +
    '<li><a href="sea" style="background:#038D98">Sea green</a></li>' +
    '<li><a href="blue" style="background:#4BC2EA">Blue</a></li>' +
    '<li><a href="pink" style="background:#ED80C3">Pink</a></li>' +
    '<li><a href="coffee" style="background:#A3855D">Coffee</a></li>' +
    '<li><a href="green" style="background:#A0D04C">Green</a></li>' +
    '<li><a href="grey" style="background:#555555">Grey</a></li>' +
    '</ul>' +
    '</div>';

    var s = document.createElement("script");
    s.src = "/js/plugins/jquery-cookie/jquery-cookie.js";
    $("body").append(s);  

    $('body').append($colorsHTML);

    var color = 'colors';

    if($.cookie('css')){
        var path = $('#colors').attr('href').replace(color, $.cookie('css'));
        color = $.cookie('css');
        $('#colors').attr('href', path);
    }

    $('.color-switcher li a').click(function(){
        var path = $('#colors').attr('href').replace(color, $(this).attr('href'));
        color = $(this).attr('href');
        $('#colors').attr('href', path);
        $.cookie('css', color);
        return false;
    });

    $('#switcherToggle').click(function(e){
        if($('#style-switcher').css('left') === '-200px'){
            $('#style-switcher').animate(
                {'left':0},
                300, 'easeOutQuart'
            );
        }else{
            $('#style-switcher').animate(
                {'left':-200},
                300, 'easeInQuart'
            );
        }
        e.preventDefault();
    });
});
