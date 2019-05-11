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
//= require_tree .

self = this

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
  App.sections.discover()
  App.sections.updates()
  App.sections.myListening()
  App.sections.search()
}

App.pages.discussions = function() {}

App.sections.search = function() {
  var b = 1
  Mousetrap.bind('command+j', function(e) {
    b = b + 1
    if (b % 2 === 0) {
      $('.search').removeClass('hidden')
      $('.search input').focus()
    } else {
      $('.search').addClass('hidden')
    }
  })
  Mousetrap.bind('esc', function() {
    $('.search').addClass('hidden')
  })
}

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

  function clearAddToLibraryFromOtherNodes() {
    $('.discover div').children('add-to-library').remove()
  }

  function appendAddToLibraryToCurrentNode(e) {
    $(e.currentTarget).append($('.add-to-library'))
  }

  function userIsAddingToLibrary(e) {
    return $(e.currentTarget).prop('checked') === true
  }

  function userIsRemovingFromLibrary(e) {
    return $(e.currentTarget).prop('checked') === false
  }

  function savePodcastToLibraryInStatus(e) {
    $.ajax({
      type: 'post',
      url: '/my_library' + App.clientId + '&podcast_id=' + $(e.currentTarget).parent().parent().attr('data-pod-id') + '&save_to_list=' + $(e.currentTarget).attr('id'),
      success: (data) => {
        console.log('no-op - saved to my library')
      }, error: () => {
        console.log('error')
        $(e.currentTarget).prop('checked', false)
      }
    })
  }

  function removePodcastFromLibraryInStatus(e) {
    $.ajax({
      type: 'get',
      url: '/remove_from_my_library' + App.clientId + '&podcast_id=' + $(e.currentTarget).parent().parent().attr('data-pod-id') + '&list=' + $(e.currentTarget).attr('id'),
      success: function(data) {
        // TODO: Update UI to reflect this delete by unchecking boxes before a reload
      }
    })
  }

  function reloadPage() {
    window.location.reload()
  }

  function bindCheckboxClickEvent() {
    $('.discover input[type="checkbox"]').off('click').on('click', (e) => {
      if (userIsAddingToLibrary(e)) {
        savePodcastToLibraryInStatus(e)
      } else if (userIsRemovingFromLibrary(e)) {
        removePodcastFromLibraryInStatus(e)
      }
      reloadPage()
    })
  }

  function unhideAddToLibrary() {
    $('.add-to-library').removeClass('hidden')
  }

  function renderStateForToListenForm(target, status) {
    if (status.indexOf("to-listen") != -1) {
      target.find('#to-listen').prop('checked', true)
    } else {
      target.find('#to-listen').prop('checked', false)
    }
  }

  function renderStateForListenedForm(target, status) {
    if (status.indexOf("listened") != -1) {
      target.find('#listened').prop('checked', true)
    } else {
      target.find('#listened').prop('checked', false)
    }
  }

  function renderStateForListeningForm(target, status) {
    if (status.indexOf("listening") != -1) {
      target.find('#listening').prop('checked', true)
    } else {
      target.find('#listening').prop('checked', false)
    }
  }

  function populateAddToLibraryWithSavedStateFor(target) {
    $.ajax({
      type: 'get',
      url: '/my_library' + App.clientId + '&podcast_id=' + target.attr('data-pod-id'),
      success: function(status) {
        renderStateForToListenForm(target, status)
        renderStateForListenedForm(target, status)
        renderStateForListeningForm(target, status)
      }
    })
  }

  function renderDiscoverWith(data) {
    $el.html("")
    data.forEach(podcast => {
      $el.append(
        "<div data-pod-id='" + podcast.id + "' style='display: inline-block; position: relative;'>" +
          "<a href='/podcasts/" + podcast.id + ".html'>" +
            "<img src='" + podcast.logo_url + "' width='75' style='padding: 5px; float: left' />" +
            "</a>" +
        "</div>"
      )
    })

    // TODO: If it's the far right column, switch the direction of the popover
    $('.discover div').hover(function(e) {
      clearAddToLibraryFromOtherNodes()
      appendAddToLibraryToCurrentNode(e)
      unhideAddToLibrary()
      populateAddToLibraryWithSavedStateFor($(e.currentTarget))
      bindCheckboxClickEvent()
    })
  }
}

// BOOT UPDATES SECTION 
App.sections.updates = function() {
  var $el = $('.updates')

  fetch()
  typeAheadSearch()

  var allowButtonAnimationByDelayingPost = 1000
  $('.updates input').on('click', () => {
    updateDomToShowWerePosting()
    setTimeout(function() {
      post()
      resetDom()
      window.location.reload()
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
      }
    })
  }

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
      if (update.podcast_id) {
        $.ajax({
          url: '/podcasts/' + update.podcast_id,
          success: function(data) {
            var image = data.logo_url
            synchronousDomUpdate(image)
          }
        })
      } else {
        setTimeout(function() {
          var image = "http://placehold.it/50x50"
          synchronousDomUpdate(image)
        }, 500)
      }
      function synchronousDomUpdate(image) {
        $el.append(
          "<div class='individual-update' style='overflow: hidden; clear: both; display: block;'>" +
            "<a href='/podcasts/"+update.podcast_id+".html'><img style='float: left; margin: 0 10px;' src='" + image + "' width='50' /></a>" +
            "<div>" + update.body + "</div>" +
          "</div>"
        )
      }
    })
  }

  // Begin Typeahead Search Feature Area
  //
  // TODO: Abstract out to feature sub-section
  // E.g.: App.sections.updates.features.podcast@Mention = function () {}
  function showSearchDropdown() {
    $('.typeahead-dropdown').removeClass('hidden').addClass('show')
  }

  function hideSearchDropdown() {
    $('.typeahead-dropdown').removeClass('show').addClass('hidden')
  }

  function searchInputExtractionAlgo(e) {
    return $(e.currentTarget).val().split("@")[1]
  }

  function clearSearchDom() {
    $('.typeahead-dropdown').html('')
  }

  function emptyResultMessage() {
    return "No search results for that term"
  }

  function renderSearchResultsWithNoData() {
    clearSearchDom()
    $('.typeahead-dropdown').append("<div>" + emptyResultMessage() + "</div>")
  }

  function renderSearchResultsWith(data) {
    data.forEach(function(result) {
      $('.typeahead-dropdown').append("<div data-id='" + result.id + "'>" + result.title + "</div>")
    })
    allowSearchResultToBeUsed()
  }

  function allowSearchResultToBeUsed() {
    $('[data-id]').off('click').on('click', (e) => {
      arrayOfSearch     = $('textarea').val().split("@")
      arrayOfSearch[1]  = $(e.currentTarget).text()
      $('textarea').val(arrayOfSearch.join("@"))
      hideSearchDropdown()
    })
  }

  function featureRestriction(searchInput) {
    if (searchInput && $('textarea').val().split("@").length > 2) {
      searchInput = $('textarea').val()
      $('textarea').val("We only support 1 @ mention per update, for right now.")
      return searchInput
    }
  }

  function typeAheadSearch() {
    var textArea               = $('textarea')
    var makeSearchFeelNatural  = 2000
    var searchCharacterTrigger = "@"

    textArea.on('keyup', (e) => {
      var searchText         = $(e.currentTarget).val()
      var searchInput        = searchText.split("@")[1]
      var valid              = searchInput != undefined && searchInput != null
      searchInput            = featureRestriction(searchInput)

      if (valid) {
        var searchTextChars  = searchText.split("")
        var lastIndex        = searchTextChars.length - 1
        var lastCharacter    = searchTextChars[lastIndex]
        var startSearch      = lastCharacter === searchCharacterTrigger

        if (startSearch) {
          hideSearchDropdown()
          clearSearchDom()
          setTimeout( () => {
            $.ajax({
              url: '/search?s=' + searchInputExtractionAlgo(e),
              success: (data) => {
                showSearchDropdown()
                if (data.length > 0) {
                  renderSearchResultsWith(data)
                } else {
                  renderSearchResultsWithNoData()
                }
              }
            })
          }, makeSearchFeelNatural)
        }
      } else {
        hideSearchDropdown()
      }
    })
  }
}

App.sections.myListening = function() {
  $el = $('.my-lists')

  fetch()

  function fetch() {
    $.ajax({
      url: '/all_library' + App.clientId,
      success: (data) => {
        console.log("hit")
        renderMyListsWith(data)
      }
    })
  }

  // TODO: Convert this to be dynamically assigned
  function renderMyListsWith(data) {
    data.forEach(user_podcast_status => {
      if (user_podcast_status.status == "to-listen") {
        renderToListen(user_podcast_status)
      } else if (user_podcast_status.status == 'listening') {
        renderListening(user_podcast_status)
      } else if (user_podcast_status.status == 'listened') {
        renderListened(user_podcast_status)
      }
    })
  }

  function renderToListen(user_podcast_status ) {
    // TODO: Extract to clearDom('.dom-to-clear')
    $('.my-lists .to-listen').html('')
    $.ajax({
      url: '/podcasts/' + user_podcast_status.podcast_id + App.clientId,
      success: function(podcast) {
        $('.my-lists .to-listen').append(
          "<div data-pod-id='" + podcast.id + "' style='display: inline-block; position: relative;'><img src='" + podcast.logo_url + "' width='75' style='padding: 5px; float: left' /></div>"
        )
      }
    })
  }

  function renderListening(user_podcast_status) {
    $('.my-lists .listening').html('')
    $.ajax({
      url: '/podcasts/' + user_podcast_status.podcast_id + App.clientId,
      success: function(podcast) {
        $('.my-lists .listening').append(
          "<div data-pod-id='" + podcast.id + "' style='display: inline-block; position: relative;'><img src='" + podcast.logo_url + "' width='75' style='padding: 5px; float: left' /></div>"
        )
      }
    })
  }

  function renderListened(user_podcast_status) {
    $('.my-lists .listened').html('')
    $.ajax({
      url: '/podcasts/' + user_podcast_status.podcast_id + App.clientId,
      success: function(podcast) {
        $('.my-lists .listened').append(
          "<div data-pod-id='" + podcast.id + "' style='display: inline-block; position: relative;'><img src='" + podcast.logo_url + "' width='75' style='padding: 5px; float: left' /></div>"
        )
      }
    })
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
  })
}

App.utils.checkIfPathIsSet = function(path) {
  if (window.location.pathname.indexOf(path) != -1) {
    return true
  } else {
    return false
  }
}

