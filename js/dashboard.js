var defaultTheme = getRandom(4);

var today = new Date();

var events = [];

var active_events = [];

var week_date = [];

var curAdd, curRmv;

function getRandom(a) {
    return Math.floor(Math.random() * a);
}

function getWeeksInMonth(a, b) {
    var c = [], d = new Date(b, a, 1), e = new Date(b, a + 1, 0), f = e.getDate();
    var g = 1;
    var h = 7 - d.getDay();
    while (g <= f) {
        c.push({
            start: g,
            end: h
        });
        g = h + 1;
        h += 7;
        if (h > f) h = f;
    }
    return c;
}

week_date = getWeeksInMonth(today.getMonth(), today.getFullYear())[2];

$(document).ready(function () {
    var month = ("0" + (today.getMonth() + 1)).slice(-2);
    getData(month);
});

function getData(month) {
    var host_url = $('#host_url').val();
    $.ajax({
        url: host_url + "/index.php/dashboard/getJobsAjax/" + month,
        data: {month: month},
        method: 'post',
        dataType: 'json',
        success: function(data) {
            console.log(data);
            jQuery.each(data, function (i, v) {
                data[i].name = "<a href='" + host_url + "/index.php/jobs/jobDispatchDetail/" + v.id + "'>" + v.name + "</a>";
            });
            
            showCalender(data);
        }
    });      
}

function showCalender (data) {
    $("#calendar").evoCalendar({
        format: "MM dd, yyyy",
        titleFormat: "MM",
        calendarEvents: data
    });
}

/*$("#calendar").on('selectEvent', function(activeEvent) {
    console.log(activeEvent);
});*/

$("#calendar").on('selectMonth', function(activeMonth, monthIndex) {
    console.log(activeMonth);
    console.log(monthIndex);
    var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
    var month = ("0" + (months.indexOf(monthIndex)+1)).slice(-2);
    $('#calendar').evoCalendar('destroy');
    getData(month);
});



/*
function showSettingsSample(a) {
    var b = $("#event-settings");
    var c;
    switch (a) {
        case "theme":
            c = '<br><span class="green">// theme</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">evoCalendar</span>({<br>' + "&#8194;&#8194;&#8194;&#8194;&#8194;<span class=\"violet\">'theme'</span>: <span class=\"red\">'Theme Name'</span><br>" + "});" + "<br> ";
            break;

        case "language":
            c = '<br><span class="green">// language</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">evoCalendar</span>({<br>' + "&#8194;&#8194;&#8194;&#8194;&#8194;<span class=\"violet\">'language'</span>: <span class=\"red\">'en'</span><br>" + '&#8194;&#8194;&#8194;&#8194;&#8194;<span class="green">// Supported language: en, es, de..</span><br>' + "});" + "<br> ";
            break;

        case "format":
            c = '<br><span class="green">// format</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">evoCalendar</span>({<br>' + "&#8194;&#8194;&#8194;&#8194;&#8194;<span class=\"violet\">'format'</span>: <span class=\"red\">'MM dd, yyyy'</span><br>" + '&#8194;&#8194;&#8194;&#8194;&#8194;<span class="green">// some browsers doesn\'t support other format, so...</span><br>' + "});" + "<br> ";
            break;

        case "titleFormat":
            c = '<br><span class="green">// titleFormat</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">evoCalendar</span>({<br>' + "&#8194;&#8194;&#8194;&#8194;&#8194;<span class=\"violet\">'titleFormat'</span>: <span class=\"red\">'MM'</span><br>" + "});" + "<br> ";
            break;

        case "eventHeaderFormat":
            c = '<br><span class="green">// eventHeaderFormat</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">evoCalendar</span>({<br>' + "&#8194;&#8194;&#8194;&#8194;&#8194;<span class=\"violet\">'eventHeaderFormat'</span>: <span class=\"red\">'MM dd'</span><br>" + "});" + "<br> ";
            break;

        case "firstDayOfWeek":
            c = '<br><span class="green">// firstDayOfWeek</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">evoCalendar</span>({<br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;<span class="violet">\'firstDayOfWeek\'</span>: <span class="red">0</span> <span class="green">// Sun</span><br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;<span class="green">// 0-6 (Sun-Sat)</span><br>' + "});" + "<br> ";
            break;

        case "todayHighlight":
            c = '<br><span class="green">// todayHighlight</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">evoCalendar</span>({<br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;<span class="violet">\'todayHighlight\'</span>: <span class="blue">true</span><br>' + "});" + "<br> ";
            break;

        case "sidebarDisplayDefault":
            c = '<br><span class="green">// sidebarDisplayDefault</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">evoCalendar</span>({<br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;<span class="violet">\'sidebarDisplayDefault\'</span>: <span class="blue">false</span><br>' + "});" + "<br> ";
            break;

        case "sidebarToggler":
            c = '<br><span class="green">// sidebarToggler</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">evoCalendar</span>({<br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;<span class="violet">\'sidebarToggler\'</span>: <span class="blue">false</span><br>' + "});" + "<br> ";
            break;

        case "eventDisplayDefault":
            c = '<br><span class="green">// eventDisplayDefault</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">evoCalendar</span>({<br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;<span class="violet">\'eventDisplayDefault\'</span>: <span class="blue">false</span><br>' + "});" + "<br> ";
            break;

        case "eventListToggler":
            c = '<br><span class="green">// eventListToggler</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">evoCalendar</span>({<br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;<span class="violet">\'eventListToggler\'</span>: <span class="blue">false</span><br>' + "});" + "<br> ";
            break;

        case "calendarEvents":
            c = '<br><span class="green">// calendarEvents</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">evoCalendar</span>(<span class="violet">\'calendarEvents\'</span>, {<br>' + "&#8194;&#8194;&#8194;&#8194;&#8194;<span class=\"violet\">'calendarEvents'</span>: [<br>" + "&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;{<br>" + '&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;<span class="blue">id</span>: <span class="red">\'4hducye\'</span>, <span class="green">// Event\'s id (required, for removing event)</span><br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;<span class="blue">description</span>: <span class="red">\'Lorem ipsum dolor sit amet..\'</span>, <span class="green">// Description of event (optional)</span><br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;<span class="blue">badge</span>: <span class="red">\'1-day event\'</span>, <span class="green">// Event badge (optional)</span><br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;<span class="blue">date</span>: <span class="blue">new</span> <span class="yellow">Date</span>(), <span class="green">// Date of event</span><br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;<span class="blue">type</span>: <span class="red">\'holiday\'</span>, <span class="green">// Type of event (event|holiday|birthday)</span><br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;<span class="blue">color</span>: <span class="red">\'#63d867\'</span>, <span class="green">// Event custom color (optional)</span><br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;<span class="blue">everyYear</span>: <span class="blue">true</span> <span class="green">// Event is every year (optional)</span><br>' + "&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;}<br>" + "&#8194;&#8194;&#8194;&#8194;&#8194;]<br>" + "});" + "<br> ";
    }
    $("[data-settings]").removeClass("active");
    $('[data-settings="' + a + '"]').addClass("active");
    b.html(c);
}

function showMethodSample(a) {
    var b = $("#method-code");
    var c;
    switch (a) {
        case "setTheme":
            c = '<br><span class="green">// setTheme</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">evoCalendar</span>(<span class="violet">\'setTheme\'</span>, <span class="red">\'Theme Name\'</span>);' + "<br> ";
            break;

        case "toggleSidebar":
            c = '<br><span class="green">// toggleSidebar</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">evoCalendar</span>(<span class="violet">\'toggleSidebar\'</span>);' + "<br> " + '<br><span class="green">// open sidebar</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">evoCalendar</span>(<span class="violet">\'toggleSidebar\'</span>, <span class="blue">true</span>);' + "<br> ";
            break;

        case "toggleEventList":
            c = '<br><span class="green">// toggleEventList</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">evoCalendar</span>(<span class="violet">\'toggleEventList\'</span>);' + "<br> " + '<br><span class="green">// close event list</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">evoCalendar</span>(<span class="violet">\'toggleEventList\'</span>, <span class="blue">false</span>);' + "<br> ";
            break;

        case "getActiveDate":
            c = '<br><span class="green">// getActiveDate</span><br>' + '<span class="red">var</span> <span class="orange">active_date</span> = $(<span class="red">\'#calendar\'</span>).<span class="yellow">evoCalendar</span>(<span class="violet">\'getActiveDate\'</span>);' + "<br> ";
            break;

        case "getActiveEvents":
            c = '<br><span class="green">// getActiveEvents</span><br>' + '<span class="red">var</span> <span class="orange">active_events</span> = $(<span class="red">\'#calendar\'</span>).<span class="yellow">evoCalendar</span>(<span class="violet">\'getActiveEvents\'</span>);' + "<br> ";
            break;

        case "selectYear":
            c = '<br><span class="green">// selectYear</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">evoCalendar</span>(<span class="violet">\'selectYear\'</span>, <span class="red">2021</span>);' + "<br> ";
            break;

        case "selectMonth":
            c = '<br><span class="green">// selectMonth</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">evoCalendar</span>(<span class="violet">\'selectMonth\'</span>, <span class="red">1</span>); <span class="green">// february</span>' + "<br> ";
            break;

        case "selectDate":
            c = '<br><span class="green">// selectDate</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">evoCalendar</span>(<span class="violet">\'selectDate\'</span>, <span class="red">\'February 15, 2020\'</span>);' + "<br> ";
            break;

        case "addCalendarEvent":
            c = '<br><span class="green">// addCalendarEvent</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">evoCalendar</span>(<span class="violet">\'addCalendarEvent\'</span>, {<br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;<span class="blue">id</span>: <span class="red">\'kNybja6\'</span>,<br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;<span class="blue">name</span>: <span class="red">\'Mom\\\'s Birthday\'</span>,<br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;<span class="blue">description</span>: <span class="red">\'Lorem ipsum dolor sit..\'</span>,<br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;<span class="blue">date</span>: <span class="red">\'May 27, 2020\'</span>,<br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;<span class="blue">type</span>: <span class="red">\'birthday\'</span><br>' + "});" + '<br><span class="green">// add multiple events</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">evoCalendar</span>(<span class="violet">\'addCalendarEvent\'</span>, [<br>' + "&#8194;&#8194;&#8194;&#8194;&#8194;{<br>" + '&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;<span class="blue">id</span>: <span class="red">\'kNybja6\'</span>,<br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;<span class="blue">name</span>: <span class="red">\'Mom\\\'s Birthday\'</span>,<br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;<span class="blue">date</span>: <span class="red">\'May 27, 1965\'</span>,<br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;<span class="blue">type</span>: <span class="red">\'birthday\'</span>,<br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;<span class="blue">everyYear</span>: <span class="blue">true</span> <span class="green">// optional</span><br>' + "&#8194;&#8194;&#8194;&#8194;&#8194;},<br>" + "&#8194;&#8194;&#8194;&#8194;&#8194;{<br>" + '&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;<span class="blue">id</span>: <span class="red">\'asDf87L\'</span>,<br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;<span class="blue">name</span>: <span class="red">\'Graduation Day!\'</span>,<br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;<span class="blue">date</span>: <span class="red">\'March 21, 2020\'</span>,<br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;<span class="blue">type</span>: <span class="red">\'event\'</span><br>' + "&#8194;&#8194;&#8194;&#8194;&#8194;}<br>" + "]);" + "<br> ";
            break;

        case "removeCalendarEvent":
            c = '<br><span class="green">// removeCalendarEvent</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">evoCalendar</span>(<span class="violet">\'removeCalendarEvent\'</span>, <span class="red">\'kNybja6\'</span>);' + "<br> " + '<br><span class="green">// delete multiple event</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">evoCalendar</span>(<span class="violet">\'removeCalendarEvent\'</span>, [<span class="red">\'kNybja6\'</span>, <span class="red">\'asDf87L\'</span>]);' + "<br> ";
            break;

        case "destroy":
            c = '<br><span class="green">// destroy</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">evoCalendar</span>(<span class="violet">\'destroy\'</span>);' + "<br> ";
    }
    $("[data-method]").removeClass("active");
    $('[data-method="' + a + '"]').addClass("active");
    b.html(c);
}

function showEventSample(a) {
    var b = $("#event-code");
    var c;
    switch (a) {
        case "selectDate":
            c = '<br><span class="green">// selectDate</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">on</span>(<span class="violet">\'selectDate\'</span>, <span class="blue">function</span>(<span class="yellow">event</span>, <span class="yellow">newDate</span>, <span class="yellow">oldDate</span>) {<br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;<span class="green">// code here...</span><br>' + "});" + "<br> ";
            break;

        case "selectEvent":
            c = '<br><span class="green">// selectEvent</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">on</span>(<span class="violet">\'selectEvent\'</span>, <span class="blue">function</span>(<span class="yellow">event</span>, <span class="yellow">activeEvent</span>) {<br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;<span class="green">// code here...</span><br>' + "});" + "<br> ";
            break;

        case "selectMonth":
            c = '<br><span class="green">// selectMonth</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">on</span>(<span class="violet">\'selectMonth\'</span>, <span class="blue">function</span>(<span class="yellow">event</span>, <span class="yellow">activeMonth</span>, <span class="yellow">monthIndex</span>) {<br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;<span class="green">// code here...</span><br>' + "});" + "<br> ";
            break;

        case "selectYear":
            c = '<br><span class="green">// selectYear</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">on</span>(<span class="violet">\'selectYear\'</span>, <span class="blue">function</span>(<span class="yellow">event</span>, <span class="yellow">activeYear</span>) {<br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;<span class="green">// code here...</span><br>' + "});" + "<br> ";
            break;

        case "destroy":
            c = '<br><span class="green">// destroy</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">on</span>(<span class="violet">\'destroy\'</span>, <span class="blue">function</span>(<span class="yellow">event</span>, <span class="yellow">evoCalendar</span>) {<br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;<span class="green">// code here...</span><br>' + "});" + "<br> ";
    }
    $("[data-event]").removeClass("active");
    $('[data-event="' + a + '"]').addClass("active");
    b.html(c);
}*/

$('[data-go*="#"]').on("click", function (a) {
    a.preventDefault();
    var b = $(this).data().go;
    if ("#top" === b) {
        $("html, body").animate({
            scrollTop: 0
        }, 500);
        return;
    } else var c = $(b)[0].offsetTop - $("header")[0].offsetHeight - 10;
    $("html, body").animate({
        scrollTop: c
    }, 500);
});

$(document).ready(function() {
    reporting('7_days');
    $('.report_select').change(function() {
        var value = $(this).val();
        var host_url = $('#host_url').val();
        $.ajax({
            url: host_url + "/index.php/dashboard/getDashboardReportingDataAjax/" + value,
            method: 'post',
            dataType: 'json',
            success: function(data) {
                $('#report_total_jobs').html(data.total_jobs);
                $('#report_total_hours').html(parseFloat(data.total_time).toFixed(2));
                $('#report_total_contract_hours').html(parseFloat(data.total_contract_time).toFixed(2));
            }
        });  
    });
})

function reporting(value) {
    var host_url = $('#host_url').val();
    $.ajax({
        url: host_url + "/index.php/dashboard/getDashboardReportingDataAjax/" + value,
        method: 'post',
        dataType: 'json',
        success: function(data) {
            $('#report_total_jobs').html(data.total_jobs);
            $('#report_total_hours').html(parseFloat(data.total_time).toFixed(2));
            $('#report_total_contract_hours').html(parseFloat(data.total_contract_time).toFixed(2));
        }
    });  
}
