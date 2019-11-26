// This is a manifest file that'll be compiled into application.js, which will include all the files // listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require jquery3
//= require jquery_ujs
//= require bootstrap
//= require mousetrap
//= require audiojs
//= require constants
//= require routes
//= require discover
//= require search
//= require library
//= require update
//= require util
//= require_tree .

  audiojs.events.ready(() => {
    var as = audiojs.createAll();
  })

$(document).ready(() => {
  App.initialize()

  $('#js-podcast-sort').change((e) => {
    console.log('hit again')
    console.log($(e.currentTarget).val())
    if ($(e.currentTarget).val() == '1') {
    } else {
    }
  })

  $('.js-description').change((e) => {
    console.log('hit')
    console.log($(e.currentTarget).val())
    if ($(e.currentTarget).val() == '1') {
      $('.episode-description').removeClass('hidden')
      $('.podcasts-page-left-side').css('width', '43%')
      $('.podcasts-page-right-side').css('width', '55%')
      $('.episode').css('width', '100%')
    } else {
      $('.episode-description').addClass('hidden')
      $('.podcasts-page-left-side').css('width', '55%')
      $('.podcasts-page-right-side').css('width', '43%')
      $('.episode').css('width', '460px')
    }
  })

  if (window.location.pathname.includes("podcasts")) {
    $('body').css('background', '#fff')
  }

  $('.button-pg').hover(function(e) { 
    $(e.currentTarget).css('position', 'relative').css('top', '2px').css('left', '2px')
    $(e.currentTarget).css('box-shadow', 'none')
  }, function(e) { 
    $(e.currentTarget).css('position', 'relative').css('top', '-2px').css('left', '-2px')
    $(e.currentTarget).css('box-shadow', '3px 5px 0 #000')
  })

})

App.initialize = () => {
  App.utils.bootRoutes()
}


