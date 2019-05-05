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
  App.sections.updates();
}

App.pages.discussions = function() {}

// BOOT UP THE DISCOVER SECTION
App.sections.discover = function() {
  var $el = $('.discover')

  // TODO: Abstract
  fetch()

  function fetch() {
    $.ajax({
      url: App.models['discover']['url'] + App.clientId,
      success: (data) => {
        renderDiscoverWith(data)
      }
    })
  }

  function renderDiscoverWith(data) {
    $el.html("")
    data.forEach(podcast => {
      $el.append(
        "<img src='" + podcast.logo_url + "' width='55' style='padding: 5px; float: left' />"
      )
    })
  }
}

function showSearchDropdown() {
  $('.typeahead-dropdown').removeClass('hidden').addClass('show')
}

function hideSearchDropdown() {
  $('.typeahead-dropdown').removeClass('show').addClass('hidden')
}

function renderSearchResultWith(data) {
  $('.typeahead-dropdown').append("<div>" + data.title + "</div>")
}

function searchInputExtractionAlgo(e) {
  return $(e.currentTarget).val().split("@")[1]
}

function clearSearchDom() {
  $('.typeahead-dropdown').html('')
}

function renderSearchResultNoData() {
  clearSearchDom()
  $('.typeahead-dropdown').append("<div>" + emptyResultMessage() + "</div>")
}

function emptyResultMessage() {
  return "No search results for that term"
}

function typeAheadSearch() {
  var makeSearchFeelNaturalByDelayingInput = 2000
  var textArea = $('textarea')

  textArea.on('keyup', (e) => {
    var searchText       = $(e.currentTarget).val()
    var searchInput      = searchText.split("@")[1]
    var valid            = searchInput != undefined && searchInput != null

    if (valid) {
      var searchTextChars  = searchText.split("")
      var lastIndex        = searchTextChars.length - 1
      var lastCharacter    = searchTextChars[lastIndex]
      var startSearch      = lastCharacter === "@"

      if (startSearch) {
        hideSearchDropdown()
        clearSearchDom()
        setTimeout(function() {
          $.ajax({
            url: '/search?s=' + searchInputExtractionAlgo(e),
            success: function(data) {
              showSearchDropdown()
              if (data.length > 0) {
                data.forEach(function(data) {
                  renderSearchResultWith(data)
                })
              } else {
                renderSearchResultNoData()
              }
            }
          })
        }, makeSearchFeelNaturalByDelayingInput)
      }
    } else {
      hideSearchDropdown()
    }
  })
}

App.sections.updates = function() {
  var $el = $('.updates')

  fetch()
  typeAheadSearch()

  // POSTING A NEW UPDATE
    var allowButtonAnimationByDelayingPost = 1000
    $('.updates input').on('click', () => {
      updateDomToShowWerePosting()
      setTimeout(function() {
        post()
        resetDom()
      }, allowButtonAnimationByDelayingPost)
    })

    function updateDomToShowWerePosting() {
      $('input').val('Posting...')
    }

    function resetDom() {
      $('textarea').val('')
      $('input').val('Post')
    }

    function post() {
      $.ajax({
        type: 'post',
        url: App.models['updates']['url'] + App.clientId + "&body=" + $('textarea').val(),
        success: function (data) {
          console.log("Update saved")
        }
      })
    }

  // FETCHING ALL UPDATES
  function fetch() {
    $.ajax({
      url: App.models['updates']['url'] + App.clientId,
      success: (data) => {
        renderUpdateWith(data)
      }
    })
  }


  function renderUpdateWith(data) {
    $el = $('.updates-body')
    $el.html("")
    data.forEach(update => {
      $el.append(
        "<div>" + update.body + "</div>"
      )
    })
  }
}

App.sections.myListening = function() {
  function _myListening() {
    console.log("myListening hit");
  }
}

App.models.discover = {}
App.models.discover.url = '/podcasts'
App.models.updates = {}
App.models.updates.url = '/updates'

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

