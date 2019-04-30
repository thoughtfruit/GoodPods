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

$(document).ready(function() {
  App.initialize();
});

self = this;

window.App = {
  rootUrl: 'http://localhost:3000',
  clientId: 'client_id=078932198103829020278292027898289223828',

  initialize: function() {
    this.bootRoutes();
  },

  bootRoutes: function() {
    $.each(this.routes, function(k,v) {
      route = v
      if (route()) {
        route().run()
      }
    });
  },

  routes: {
    1: function() {
      App.checkIfPathIsSet('homepage')
      return {
        run: App.pages['homepage']
      }
    }
  },

  pages: {
    homepage: function() {
      App.sections().discover();
      App.sections().updates();
      App.sections().myListening();
    },
    pageTwo: function() {
    }
  },

  sections: function() {
    function _discover() {
      $el = $('.discover')

      // Fetch & Render abstraction
      // Fetcher, Renderer
      fetch().andRender();

      function fetch() {
        $.ajax({
          // TODO: Extract attributes a model
          // url: App.rootUrl + App.models.podcasts.url + App.clientId,
          url: App.rootUrl + '/podcasts?' + App.clientId,
          success: (data) => {
            return {
              render: renderPodcasts(data)
            }
          }
        })
      }

      function renderPodcasts(data) {
        $el.html("")
        data.podcasts.forEach(podcast => {
          $el.append(
            "<div>" + podcast.title + "</div>"
          )
        })
      }

    };
    function _updates() {
      console.log("Updates hit");
    };
    function _myListening() {
      console.log("myListening hit");
    };

    return {
      discover: _discover,
      updates: _updates,
      myListening: _myListening
    }
  },

  checkIfPathIsSet: function(path) {
    if (window.location.pathname.indexOf(path) != -1) {
      return true;
    } else {
      return false;
    }
  }
};

