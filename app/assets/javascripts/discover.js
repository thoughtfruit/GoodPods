if (window.location.pathname == "/discover") {
  $('.podcasts-grid div').hover(function(e) {
    $('.add-to-library').css('left', '0px')
    clearAddToLibraryFromOtherNodes()
    appendAddToLibraryToCurrentNode(e)
    unhideAddToLibrary()
    populateAddToLibraryWithSavedStateFor($(e.currentTarget))
    bindCheckboxClickEvent()
  }, function() {
    $('.add-to-library').addClass('hidden')
  })
}

App.sections.discover = function() {
  var $el = $('.discover')

  // TODO: Abstract
  fetch()

  function fetch() {
    this.genres = [];
    $.ajax({
      url: App.models['discover']['url'] + App.clientId,
      success: (data) => {
        renderDiscoverWith(data)
      }
    })
  }

  function renderDiscoverWith(data) {
    $el.html("")
    window.data = data;
    console.log(data)
    data.forEach(podcast => {
      $el.append(
        '<div data-pod-bio="' + escape(podcast.bio) + '"data-pod-title="' + podcast.title + '"data-pod-id="' + podcast.id + '" style="display: inline-block; position: relative;">' +
          "<a href='/podcasts/" + podcast.id + ".html'>" +
            "<img src='" + podcast.logo_url + "' width='75' style='padding: 5px; float: left' />" +
            "</a>" +
        "</div>"
      )
      this.genres.push(podcast.genre)
    })

    var uniqueGenres = this.genres.filter(onlyUnique);

    $('.homepage-genre-switcher').html('')
      $('.homepage-genre-switcher').append(
        '<option value="all">All</option>'
      )
    uniqueGenres.sort().forEach(function(genre) {
      $('.homepage-genre-switcher').append(
        '<option>' + genre + '</option>'
      )
    })

    // RE RENDER THE DISCOVER AREA AFTER SELECT MENU GENRE CHANGE
    $('.homepage-genre-switcher').change(function(e) {
      var genre = $('.homepage-genre-switcher option:selected').text()
      $('.discover').html('')
      window.data.forEach(podcast => {
        if (podcast.genre == genre) {
          $('.discover').append(
            '<div data-pod-bio="' + escape(podcast.bio) + '"data-pod-title="' + podcast.title + '"data-pod-id="' + podcast.id + '" style="display: inline-block; position: relative;">' +
              "<a href='/podcasts/" + podcast.id + ".html'>" +
                "<img src='" + podcast.logo_url + "' width='75' style='padding: 5px; float: left' />" +
                "</a>" +
            "</div>"
          )
        }
      })
    })

    hoverstate()
    function hoverstate() {
      $('.discover div').hover(function(e) {
        $('.add-to-library').css('left', '0px')
        clearAddToLibraryFromOtherNodes()
        appendAddToLibraryToCurrentNode(e)
        unhideAddToLibrary()
        populateAddToLibraryWithSavedStateFor($(e.currentTarget))
        bindCheckboxClickEvent()
      }, function() {
        $('.add-to-library').addClass('hidden')
      })
    }

    $('.header').hover(function(e){
      $(e).tooltip('show')
    });

  }
}

