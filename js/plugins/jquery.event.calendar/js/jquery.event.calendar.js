/*
 *  jQuery Event Calendar 1.0
 *  Demo's and documentation:
 *    ecalendar.ozkanozturk.me
 *
 *    Copyright © 2014 Özkan Öztürk
 *    www.ozkanozturk.me
 */
(function($){
    $.fn.eCalendar = function(options){
        var date            = new Date(),
            currentMonth    = date.getMonth() + 1,
            currentYear        = date.getFullYear();
        var el                = this,
            defaults         ={
                eventsContainer        : '#hb-event-list',                                                        // container that contains the event list
                ajaxDayLoader        : 'ajax/hb-days.php',                                                    // php file that returns event days of current month
                ajaxEventLoader        : 'ajax/hb-events.php',                                                    // php file that returns event list of current day
                currentMonth        : currentMonth,                                                            // default current month
                currentYear            : currentYear,                                                            // default current year
                startMonth            : currentMonth,                                                            // month of min. date (default current month)
                startYear            : currentYear,                                                            // year of min. date (default current year)
                endMonth            : currentMonth,                                                            // month of max. date (default current month of next year)
                endYear                : currentYear + 1,                                                        // year of max. date (default next year)
                firstDayOfWeek        : 1,                                                                    // fisrt day of the week, 0: Sunday, 1: Monday (default)
                onBeforeLoad        : function(){},                                                        // event: before eCalendar starts loading
                onAfterLoad            : function(){},                                                        // event: after eCalendar loaded
                onClickMonth        : function(){},                                                        // event: click on next or prev month
                onClickDay            : function(){},                                                        // event: click on an event day
                customVar           : null,
            },
            options                    = $.extend({}, defaults, options);

        /* initalize elements and view */
        this.init = function(){
            
            options.onBeforeLoad();
            if(!el.hasClass('hb-calendar')){
                el.attr('class', 'hb-calendar');
            }
            if(el.find('.hb-months').length == 0 && el.find('.hb-days').length == 0){
                el.html('<div class="hb-months">' +
                            '<a class="hb-change-month hb-prev-month" data-month="" data-year=""></a>' +
                            '<span class="hb-current-month" data-month="" data-year=""></span>' +
                            '<a class="hb-change-month hb-next-month " data-month="" data-year=""></a>' +
                        '</div>' +
                        '<div class="hb-days"></div>').addClass('loaded');
            }
           
            $.ajax({
                url: options.ajaxDayLoader,
                type: "POST",
                async: false,
                data: "currentMonth="+options.currentMonth+"&currentYear="+options.currentYear+"&"+options.customVar,
                success: function(response){
                    var response = $.parseJSON(response);
                    options.bookedDays = response.booked;
                    options.freeDays = response.free;
                }
            });
            
            this.initMonths();
            this.initDays();
            options.onAfterLoad();
            this.find('.hb-months a.hb-change-month').unbind('click').bind('click', function(){
                options.onClickMonth();
                var opts ={
                        currentMonth    : $(this).attr('data-month'),
                        currentYear        : $(this).attr('data-year')
                    },
                    opts = $.extend({}, options, opts);
                el.eCalendar(opts);
            });
        }

        /* initalize months */
        this.initMonths = function(){
            var monthsWrapper    = el.find('.hb-months');
            // Previous Month
            var prevMonth = parseInt(options.currentMonth) - 1,
                prevYear  = parseInt(options.currentYear);
            if(prevMonth == 0){
                prevMonth = 12;
                prevYear  = prevYear - 1;
            }
            if(prevYear < options.startYear){
                monthsWrapper.find('.hb-prev-month').css('display', 'none');
            }else{
                if(prevMonth < options.startMonth && prevYear == options.startYear){
                    monthsWrapper.find('.hb-prev-month').css('display', 'none');
                }else{
                    monthsWrapper.find('.hb-prev-month').css('display', '');
                    monthsWrapper.find('.hb-prev-month').attr('data-month', prevMonth);
                    monthsWrapper.find('.hb-prev-month').attr('data-year', prevYear);
                }
            }
            // Current Month
            monthsWrapper.find('.hb-current-month').attr('data-month', options.currentMonth);
            monthsWrapper.find('.hb-current-month').attr('data-year',  options.currentYear);
            monthsWrapper.find('.hb-current-month').html(months[options.currentMonth - 1] + ' ' + options.currentYear);
            // Next Month
            var nextMonth = parseInt(options.currentMonth) + 1,
                nextYear  = parseInt(options.currentYear);
            if(nextMonth == 13){
                nextMonth = 1;
                nextYear  = nextYear + 1;
            }
            if(nextYear > options.endYear){
                monthsWrapper.find('.hb-next-month').css('display', 'none');
            }else{
                if(nextMonth > options.endMonth && nextYear == options.endYear){
                    monthsWrapper.find('.hb-next-month').css('display', 'none');
                }else{
                    monthsWrapper.find('.hb-next-month').css('display', '');
                    monthsWrapper.find('.hb-next-month').attr('data-month', nextMonth);
                    monthsWrapper.find('.hb-next-month').attr('data-year', nextYear);
                }
            }
        }

        /* initalize days */
        this.initDays = function(){
            var daysWrapper    = el.find('.hb-days');
            var dayCount    = new Date(options.currentYear, options.currentMonth, 0).getDate();
            var calendar    = '',
                dayIndex    = 0,
                dayNumber    = 1,
                dayClass    = '',
                dayData        = '',
                cDate        = '',
                firstDay;
            if(options.firstDayOfWeek == 1){
                // Monday is first day
                firstDay    = new Date(options.currentYear, options.currentMonth - 1, 1).getDay();
                for(var i = 0; i < 7; i++)
                    calendar += '<span class="hb-day hb-day-name">' + days[i] + '</span>';
            }else{
                // Sunday is first day
                firstDay  = new Date(options.currentYear, options.currentMonth - 1, 2).getDay();
                calendar += '<span class="hb-day">' + days[6] + '</span>';
                for(var i = 0; i < 6; i++){
                    calendar += '<span class="hb-day hb-day-name">' + days[i] + '</span>';
                }
            }
            if(firstDay == 0)
                firstDay = 7;
            for(var i = 1; i < dayCount + firstDay; i++){
                dayIndex = (i % 7);
                if(i < firstDay)
                    calendar += '<span class="hb-day"></span>';
                else{
                    dayClass = '';
                    if(inArray(dayNumber, options.bookedDays)){
                        if(!inArray(dayNumber-1, options.bookedDays))
                            dayClass += 'hb-d-start ';
                        if(!inArray(dayNumber+1, options.bookedDays))
                            dayClass += 'hb-d-end ';
                            
                        dayClass += 'hb-day hb-d-booked';
                    }else{
                        if(inArray(dayNumber, options.freeDays))
                            dayClass += 'hb-day hb-d-free';
                        else
                            dayClass = 'hb-day';
                    }
                    
                    calendar += '<span class="' + dayClass + '">' + dayNumber + '</span>';
                    dayNumber++;
                }
            }
            daysWrapper.html(calendar);
        }

        function inArray(needle, haystack){
            var length = haystack.length;
            for(var i = 0; i < length; i++)
                if(haystack[i] == needle) return true;
            return false;
        }
        this.init();
    }

    // Methods
    /** /
    $.fn.eCalendar.function = function(){}
    /**/
})(jQuery);
