App.sections.myListening = function() {
  $el = $('.my-lists')

  fetch()

  function fetch() {
    $.ajax({
      url: '/v1/all_library' + App.clientId,
      success: (data) => {
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
      url: '/v1/podcasts/' + user_podcast_status.podcast_id + App.clientId,
      success: function(podcast) {
        $('.my-lists .to-listen').append(
          "<div data-pod-bio='" + escape(podcast.bio) + "'data-pod-title='" + podcast.title + "'data-pod-id='" + podcast.id + "' style='display: inline-block; position: relative;'><img src='" + podcast.logo_url + "' width='75' style='padding: 5px; float: left' /></div>"
        )

        $('.to-listen div').hover(function(e) {
          $('.add-to-library').css('left', 'auto')
          $('.add-to-library').css('right', '5px')
          clearAddToLibraryFromOtherNodes()
          appendAddToLibraryToCurrentNode(e)
          unhideAddToLibrary()
          populateAddToLibraryWithSavedStateFor($(e.currentTarget))
          bindCheckboxClickEvent()
        }, function() {
          $('.add-to-library').addClass('hidden')
        })
      }
    })
  }

  function renderListening(user_podcast_status) {
    $('.my-lists .listening').html('')
    $.ajax({
      url: '/v1/podcasts/' + user_podcast_status.podcast_id + App.clientId,
      success: function(podcast) {
        $('.my-lists .listening').append(
          "<div data-pod-bio='" + escape(podcast.bio) + "data-pod-title='" + podcast.title + "'data-pod-id='" + podcast.id + "' style='display: inline-block; position: relative;'><img src='" + podcast.logo_url + "' width='75' style='padding: 5px; float: left' /></div>"
        )
        $('.listening div').hover(function(e) {
          $('.add-to-library').css('left', 'auto')
          $('.add-to-library').css('right', '0pxl')
          clearAddToLibraryFromOtherNodes()
          appendAddToLibraryToCurrentNode(e)
          unhideAddToLibrary()
          populateAddToLibraryWithSavedStateFor($(e.currentTarget))
          bindCheckboxClickEvent()
        }, function() {
          $('.add-to-library').addClass('hidden')
        })
      }
    })
  }

  function renderListened(user_podcast_status) {
    $('.my-lists .listened').html('')
    $.ajax({
      url: '/v1/podcasts/' + user_podcast_status.podcast_id + App.clientId,
      success: function(podcast) {
        $('.my-lists .listened').append(
          "<div data-pod-bio='" + escape(podcast.bio) + "'data-pod-title='" + podcast.title + "'data-pod-id='" + podcast.id + "' style='display: inline-block; position: relative;'><img src='" + podcast.logo_url + "' width='75' style='padding: 5px; float: left' /></div>"
        )
        $('.listened div').hover(function(e) {
          $('.add-to-library').css('left', 'auto')
          $('.add-to-library').css('right', '0px')
          clearAddToLibraryFromOtherNodes()
          appendAddToLibraryToCurrentNode(e)
          unhideAddToLibrary()
          populateAddToLibraryWithSavedStateFor($(e.currentTarget))
          bindCheckboxClickEvent()
        }, function() {
          $('.add-to-library').addClass('hidden')
        })
      }
    })
  }
}

