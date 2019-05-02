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
//= require_tree .

self = this;
$(document).ready(() => {
  App.initialize()
})

// BOOT APP OR RETURN MEMOIZED VERSION
window.App = App || {}

// SET CONSTANTS
App.rootUrl = 'http://localhost:3000'
App.clientId = '?client_id=078932198103829020278292027898289223828' // TODO: Extract client_id out

// DOM READY ENTRY POINT
App.initialize = () => {
  App.utils.bootRoutes()
}

// SET GLOBALS FOR MPA FRAMEWORK
window.App.sections = {}
window.App.utils    = {}
window.App.models   = {}
window.App.pages    = {}

// CORE ROUTES FOR THE APP
App.routes = {
  1: function() {
    App.utils.checkIfPathIsSet('homepage')
    return {
      run: App.pages['homepage']
    }
  }
}

// BOOT ALL SECTIONS FOR THE FIRST PAGE
App.pages.homepage = function() {
  App.sections.discover();
}
//App.pages.discussions = function() {}

// BOOT UP THE FIRST SECTION
App.sections.discover = function() {
  $el = $('.discover')

  // Fetch & Render abstraction
  // Fetcher, Renderer
  fetch()
  // TODO: Add itunes image and stuff for podcasts 
  // TODO: Add episodes domain model to allow for playing episodes

  function fetch() {
    $.ajax({
      // TODO: Extract attributes to a model
      // url: App.rootUrl + App.models.podcasts.url + App.clientId,
      url: App.models['discover']['url'] + App.clientId,
      success: (data) => {
        renderDiscoverWith(data)
      }
    })
  }


  function renderDiscoverWith(data) {
    clearDomScope($el)
    data.forEach(podcast => {
      $el.append(
        "<img src='" + podcast.logo_url + "' width='60' style='padding: 5px; float: left' />"
      )
    })
  }
} 

App.sections.updates = function() {
  function _updates() {
    console.log("Updates hit");
  }
}

App.sections.myListening = function() {
  function _myListening() {
    console.log("myListening hit");
  }
}

App.models.discover = {}
App.models.discover.url = '/podcasts'

App.utils.bootRoutes = function() {
  $.each(App.routes, function(k,v) {
    route = v
    if (route()) {
      route().run()
    }
  });
}

App.utils.checkIfPathIsSet = function(path) {
  if (window.location.pathname.indexOf(path) != -1) {
    return true;
  } else {
    return false;
  }
}

function clearDomScope(toClear) {
  toClear.html("")
}
