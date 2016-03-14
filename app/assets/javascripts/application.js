// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
// require turbolinks
//= require bootstrap
//= require jquery_lettering
//= require jquery_textillate
//= require jquery.dataTables
//= require dataTables.bootstrap
//= require metisMenu/jquery.metisMenu.js
//= require pace/pace.min.js
//= require slimscroll/jquery.slimscroll.min.js
//= require jquery-mask
//= require countdown
//= require moment-with-locales

$(document).ready(function(){
      $('#game_team2_id').addClass('selectpicker');
    $('#game_team2_id').data('"live-search"', true);
   
    
         $(".alert").fadeTo(3000, 500).slideUp(500, function(){
    $(".alert").alert('close');
});
      
    
    var current_language = $("#current_language").val();
       var languaje;
    
    if(current_language == "en"){
    languaje= "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/English.json"
}else{
    languaje = "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/Spanish.json"
}
    
 
    
$('#data-table').DataTable({
    responsive: true,
     "language": {
            "url": languaje
        }
});
    
});
