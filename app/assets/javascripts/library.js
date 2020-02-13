App.sections.myListening = function() {
  $el = $('.my-lists')

  initialize()

  function initialize() {
    launchHomepageWidget()
  }

  function launchHomepageWidget() {
    fetch()
  }

  function fetch() {
    $.ajax({
      url: '/v1/all_library' + App.clientId,
      success: (data) => {
        renderMyListsWith(data)
      }
    })
  }

  function renderMyListsWith(data) {
    data.forEach(user_podcast_status => {
      if (user_podcast_status.status == "to-listen") {
        var $elToRenderOn  = $('.my-lists .to-listen')
        var elToBindHover = '.to-listen div'
        render(user_podcast_status, $elToRenderOn, elToBindHover)
      } else if (user_podcast_status.status == 'listening') {
        var $elToRenderOn  = $('.my-lists .listening')
        var elToBindHover = '.listening div'
        render(user_podcast_status, $elToRenderOn, elToBindHover)
      } else if (user_podcast_status.status == 'listened') {
        var $elToRenderOn  = $('.my-lists .listened')
        var elToBindHover = '.listened div'
        render(user_podcast_status, $elToRenderOn, elToBindHover)
      }
    })
  }

  function render(user_podcast_status, $elToRenderOn, elToBindHover) {
    $elToRenderOn.html('')
    $.ajax({
      url: '/v1/podcasts/' + user_podcast_status.podcast_id + App.clientId,
      success: function(podcast) {
        $elToRenderOn.append(
          renderPodcast(podcast)
        )
        $elToBindHover = $(elToBindHover)
        initHoverBinding($elToBindHover)
      }
    })
  }

  function initHoverBinding($elToBindHover) {
    $elToBindHover.hover(function(e) {
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

  function renderPodcast(podcast) {
    return "<div data-pod-bio='" + escape(podcast.bio) + "'data-pod-title='" + podcast.title + "'data-pod-id='" + podcast.id + "' style='display: inline-block; position: relative;'><a href='/podcasts/"+podcast.id+".html'><img src='" + podcast.logo_url + "' style='width: 100px; padding: 5px; float: left; border-radius: 55px;' /></a></div>"
  }
}

