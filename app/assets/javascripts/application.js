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

// Gave myself a challenge to only use javascript and jquery (no frameworks)
// Tbh didn't love it - so next challenge will be to refactor using react/etj

audiojs.events.ready(() => {
  var as = audiojs.createAll();
})

$(document).ready(() => {
  App.initialize()

  $('.js-add-to-library-on-pod-page').change(function() {
    if ($(this).prop('checked')) {
      $.ajax({
        type: 'post',
        url: '/v1/my_library' + App.clientId + '&podcast_id=' + $(this).attr('data-pod-id') + '&save_to_list=' + $(this).attr('data-list'),
        success: (data) => {
          console.log('no-op - saved to my library')
        }, error: () => {
          console.log('error')
          $(e.currentTarget).prop('checked', false)
        }
      })
    } else {
      $.ajax({
        type: 'get',
        url: '/v1/remove_from_my_library' + App.clientId + '&podcast_id=' + $(this).attr('data-pod-id') + '&list=' + $(this).attr('data-list'),
        success: function(data) {
          console.log('no op - removed from library')
        }
      })
    }
  })

  $('.default').removeClass('hidden')

  $('.js-tab').click(function() {
    $('.profile-page-full-column').children().each(function() { $(this).addClass('hidden')})
    $('.js-tab').removeClass('active')
    $(this).addClass('active')
    $('.profile-page-full-column')
      .children('[data-activate*="' + $(this).attr('data-activate') + '"]').removeClass('hidden')
  })

  $('.js-dropdown-custom').hover(function() {
    $('.dropdown-menu-custom').removeClass('hidden')
  }, function() {
    $('.dropdown-menu-custom').addClass('hidden')
  })

  if (window.location.pathname.indexOf('podcasts') === 1 || window.location.pathname.indexOf('profiles') === 1) {
    $('input.js-light-dark-toggle').remove()
  }

  $('.navbar-link')

  $('input.js-light-dark-toggle').change(function(e) {
    if ($(this).prop('checked') == true) {
      // DARK MODE
      $('body').addClass('black-bg')

      // HOMEPAGE
      $('.left-column').addClass('dark-bg')
      $('.navbar-wrapper').addClass('dark-bg')
      $('.navbar-link').addClass('white-text')
      $('.logo').addClass('hidden')
      $('.header').addClass('white-text')
      $('.left-column article').addClass('white-text')
      $('.left-column div').addClass('white-text')
      $('.right-column').addClass('dark-bg')
      $('.right-column div').addClass('white-text')
      $('.right-column header').addClass('white-text')
      $('.right-column h3').addClass('white-text')
      // BROWSE / DISCOVER 
      if (window.location.pathname == "/discover") {
        $('.container').addClass('dark-bg')
        $('.container h4').addClass('white-text')
      }
      // COLLECTIONS
      if (window.location.pathname == "/collections") {
        $('.collection').addClass('dark-bg')
        $('strong').addClass('white-text')
      }
    } else {
      // LIGHT MODE
      $('body').removeClass('black-bg')

      // HOMEPAGE
      $('.navbar-wrapper').removeClass('dark-bg')
      $('.navbar-wrapper a').removeClass('white-text')
      $('.logo').removeClass('hidden')
      $('.right-column').removeClass('dark-bg')
      $('.left-column').removeClass('dark-bg')
      $('.header').removeClass('white-text')
      $('.left-column article').removeClass('white-text')
      $('.left-column div').removeClass('white-text')
      $('.right-column div').removeClass('white-text')
      $('.right-column header').removeClass('white-text')
      $('.right-column h3').removeClass('white-text')
      // BROWSE / DISCOVER
      if (window.location.pathname == "/discover") {
        $('.container').removeClass('dark-bg')
        $('.container h4').removeClass('white-text')
      }
      // COLLECTIONS
      if (window.location.pathname == "/collections") {
        $('.collection').removeClass('dark-bg')
        $('strong').removeClass('white-text')
      }
    }
  });

  //}, function() {
  //})

  $('.js-tooltip').tooltip();

  $('.collection a').hover(function(e) {
    $('.add-to-library').css('left', '5px')
    clearAddToLibraryFromOtherNodes()
    appendAddToLibraryToCurrentNode(e)
    unhideAddToLibrary()
    populateAddToLibraryWithSavedStateFor($(e.currentTarget))
    bindCheckboxClickEvent()
  }, function() {
    $('.add-to-library').addClass('hidden')
  })

  $('.post-an-update textarea').keyup(function(e){
    input = $(e.currentTarget).val()
    if (input == "" || input == null) {
      $('.podcasts-grid').children().show()
    } else {
      $('.podcasts-grid')
        .children()
        .not('[data-pod-title*="' + titlecase(input) + '"]')
        .hide()
      $('.podcasts-grid')
        .children('[data-pod-genre*="' + titlecase(input) + '"]')
        .show()
      $('.podcasts-grid')
        .children('[data-pod-collection*="' + downcase(input) + '"]')
        .show()
    }
  })

  $('.js-description').change((e) => {
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

function reloadPage() {
  window.location.reload()
}

function onlyUnique(value, index, self) { 
  return self.indexOf(value) === index;
}

function clearAddToLibraryFromOtherNodes() {
  $('.discover div').children('add-to-library').remove()
}

function appendAddToLibraryToCurrentNode(e) {
  $(e.currentTarget).append($('.add-to-library').css('display', 'inline-block'))
  $('.add-to-library .podcast-title').text($(e.currentTarget).attr('data-pod-title'))
  $('.add-to-library .podcast-bio').html(unescape($(e.currentTarget).attr('data-pod-bio')))
}

function unhideAddToLibrary() {
  $('.add-to-library').removeClass('hidden')
}

function populateAddToLibraryWithSavedStateFor(target) {
  $.ajax({
    type: 'get',
    url: '/v1/my_library' + App.clientId + '&podcast_id=' + target.attr('data-pod-id'),
    success: function(status) {
      renderStateForToListenForm(target, status)
      renderStateForListenedForm(target, status)
      renderStateForListeningForm(target, status)
    }
  })
}

function bindCheckboxClickEvent() {
  function clickEventActions(e) {
    if (userIsAddingToLibrary(e)) {
      savePodcastToLibraryInStatus(e)
    } else if (userIsRemovingFromLibrary(e)) {
      removePodcastFromLibraryInStatus(e)
    }
    reloadPage()
  }

  $('input[type="checkbox"]').off('click').on('click', (e) => {
    clickEventActions(e)
  })
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

function userIsAddingToLibrary(e) {
  return $(e.currentTarget).prop('checked') === true
}

function savePodcastToLibraryInStatus(e) {
  $.ajax({
    type: 'post',
    url: '/v1/my_library' + App.clientId + '&podcast_id=' + getPodcastId(e) + '&save_to_list=' + $(e.currentTarget).attr('id'),
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
    url: '/v1/remove_from_my_library' + App.clientId + '&podcast_id=' + getPodcastId(e) + '&list=' + $(e.currentTarget).attr('id'),
    success: function(data) {
      // TODO: Update UI to reflect this delete by unchecking boxes before a reload
    }
  })
}

function userIsRemovingFromLibrary(e) {
  return $(e.currentTarget).prop('checked') === false
}

function getPodcastId(e) {
  return $(e.currentTarget).parent().parent().parent().attr('data-pod-id')
}
