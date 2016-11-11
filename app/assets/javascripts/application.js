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
//= require sw
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
//= require datetimepicker
//= require cycle
//= require jquery.bxslider
//= require tile-effect
//= require bootstrap-tour.min
//= require jquery-ui
//= require chosen.jquery.min
//= require summernote.min
//= require html2canvas
// require bootstrap2-toggle.min
//= require bootstrap-switch
//= require jquery.innerfade

if ('serviceWorker' in navigator) {
  console.log('Service Worker is supported');
  navigator.serviceWorker.register('/assets/sw.js')
    .then(function(registration) {
      console.log('Successfully registered!', ':^)', registration);
      registration.pushManager.subscribe({ userVisibleOnly: true })
        .then(function(subscription) {
            console.log('endpoint:', subscription.endpoint);
        });
  }).catch(function(error) {
    console.log('Registration failed', ':^(', error);
  });
}



$(document).ready(function(){

	  $('.collapse-link').click(function () {
        var ibox = $(this).closest('div.ibox');
        var button = $(this).find('i');
        var content = ibox.find('div.ibox-content');
        content.slideToggle(200);
        button.toggleClass('fa-chevron-up').toggleClass('fa-chevron-down');
        ibox.toggleClass('').toggleClass('border-bottom');
        setTimeout(function () {
            ibox.resize();
            ibox.find('[id^=map-]').resize();
        }, 50);
    });


                $('.datetimepicker').datetimepicker();


      $('select').addClass('selectpicker');
    $('select').data('live-search', true);


         $(".alert").fadeTo(3000, 500).slideUp(500, function(){
    $(".alert").alert('close');
});



});
