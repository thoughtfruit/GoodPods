App.sections.updates = function() {
  var $el = $('.updates')

  fetch()
  typeAheadSearch()

  var allowButtonAnimationByDelayingPost = 1000
  $('.updates input').on('click', () => {
    if ($('textarea').val() === "") {
      alert("Please enter an update")
      false
    } else {
      updateDomToShowWerePosting()
      setTimeout(function() {
        post()
        resetDom()
        window.location.reload()
      }, allowButtonAnimationByDelayingPost)
    }
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
          url: '/v1/podcasts/' + update.podcast_id,
          success: function(data) {
            var image = data.logo_url
            $el.append(
              "<div class='individual-update' style='overflow: hidden; clear: both; display: block;'>" +
                "<a href='/podcasts/"+update.podcast_id+".html'><img style='float: left; margin: 0 10px;' src='" + image + "' width='50' /></a>" +
                "<div>" + update.body + "</div>" +
                "<div>" + update.user_id + "</div>" +
              "</div>"
            )
          }
        })
      } else {
        setTimeout(function() {
          $el.append(
            "<div class='individual-update' style='overflow: hidden; clear: both; display: block;'>" +
              "<div>" + update.body + "</div>" +
            "</div>"
          )
        }, 500)
      }
    })

    $('.js-post-an-update').click(function(e) {
      $('#hidden-poster-for-updates').toggleClass("hidden")
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
              url: '/v1/search?s=' + searchInputExtractionAlgo(e),
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


