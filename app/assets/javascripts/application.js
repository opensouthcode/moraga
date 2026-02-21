// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui/widgets/draggable
//= require jquery-ui/widgets/droppable
//= require waypoints/jquery.waypoints
//= require dataTables/jquery.dataTables
//= require dataTables/bootstrap/3/jquery.dataTables.bootstrap
//= require cocoon
//= require bootstrap
//= require Chart.bundle
//= require chartkick
//= require moraga
//= require jquery-smooth-scroll
//= require trianglify
//= require tinycolor
//= require bootstrap-markdown
//= require to-markdown
//= require markdown
//= require momentjs
//= require leaflet
//= require holderjs
//= require bootstrap-datetimepicker
//= require moraga-datepickers
//= require moraga-datatables
//= require moraga-tickets
//= require bootstrap-switch
//= require moraga-schedule
//= require moraga-switch
//= require moraga-bootstrap
//= require moraga-revisionhistory
//= require moraga-commercials
//= require unobtrusive_flash
//= require unobtrusive_flash_bootstrap
//= require countable
//= require selectize
//= require bootstrap-select
//= require moraga-survey

$(document).ready(function() {
    $('a[disabled=disabled]').click(function(event){
        return false;
    });

    $('body').smoothScroll({
        delegateSelector: 'a.smoothscroll'
    });
});
