App.sections.updates = function() {
  var $el = $('.updates');

  fetch();
  typeAheadSearch();

  var allowButtonAnimationByDelayingPost = 1000;
  $('.updates input').on('click', () => {
    if ($('textarea').val() === "") {
      alert("Please enter an update");
      return false;
    } else {
      updateDomToShowWerePosting();
      setTimeout(function() {
        post();
        resetDom();
        window.location.reload();
      }, allowButtonAnimationByDelayingPost);
    }
    return false;
  });

  function updateDomToShowWerePosting() {
    $('input').val('Posting...');
  }

  function resetDom() {
    $('textarea').val('');
    $('input').val('Post');
  }

  function post() {
    $.ajax({
      type: 'post',
      url: (App.models['updates']['url'] +
            App.clientId + "&body=" +
            $('textarea').val()),
      success: function (data) {
      }
    });
  }

  function fetch() {
    $.ajax({
      url: App.models['updates']['url'] + App.clientId,
      success: (data) => {
        console.log(data);
        renderUpdateWith(data);
      }
    });
  }

  function individualUpdateHtml(update, image) {
    return "<div class='individual-update' style='overflow: hidden; clear: both; display: block;'>" +
      "<a href='/podcasts/"+update.podcast_id+".html'><img style='float: left; margin: 0 10px;' src='" + image + "' width='50' /></a>" +
      "<div>" + update.body + "</div>" +
    "</div>";
  }

  function renderUpdateWith(data) {
    $el = $('.updates-body');
    $el.html("");
    data.forEach(update => {
      if (update.podcast_id) {
        $.ajax({
          url: '/v1/podcasts/' + update.podcast_id,
          success: function(data) {
            var image = data.logo_url;
            $el.append(
              individualUpdateHtml(update, image)
            );
          }
        });
      } else {
        setTimeout(function() {
          $el.append(
            "<div class='individual-update' style='overflow: hidden; clear: both; display: block;'>" +
              "<div>" + update.body + "</div>" +
              "</div>"
          );
        }, 500);
      }
    });
    $('.js-post-an-update').click(function(e) {
      $('#hidden-poster-for-updates').toggleClass("hidden");
    });
  }

  function showSearchDropdown() {
    $('.typeahead-dropdown').removeClass('hidden').addClass('show');
  }

  function hideSearchDropdown() {
    $('.typeahead-dropdown').removeClass('show').addClass('hidden');
  }

  function searchInputExtractionAlgo(e) {
    return $(e.currentTarget).val().split("@")[1];
  }

  function clearSearchDom() {
    $('.typeahead-dropdown').html('');
  }

  function emptyResultMessage() {
    return "No search results for that term";
  }

  function renderSearchResultsWithNoData() {
    clearSearchDom();
    $('.typeahead-dropdown').append("<div style='font-size: 18px; padding: 5px;'>" + emptyResultMessage() + "</div>");
  }

  function renderSearchResultsWith(data) {
    data.forEach(function(result) {
      $('.typeahead-dropdown').append("<div data-id='" + result.id + "' style='font-size: 18px;border-bottom: 1px #aaa solid; padding: 5px;'>" + result.title + "</div>");
    });
    allowSearchResultToBeUsed();
  }

  function allowSearchResultToBeUsed() {
    $('[data-id]').off('click').on('click', (e) => {
      arrayOfSearch     = $('textarea').val().split("@");
      arrayOfSearch[1]  = $(e.currentTarget).text();
      $('textarea').val(arrayOfSearch.join("@"));
      hideSearchDropdown();
    });
  }

  function featureRestriction(searchInput) {
    if (searchInput && $('textarea').val().split("@").length > 2) {
      searchInput = $('textarea').val();
      $('textarea').val("We only support 1 @ mention per update, for right now.");
    }
    return searchInput;
  };

  function typeAheadSearch() {
    var textArea               = $('textarea');
    var makeSearchFeelNatural  = 2000;
    textArea.on('keyup', (e) => {
      var searchText           = $(e.currentTarget).val();
      var searchInput          = searchText.split("@")[1];
      var valid                = searchInput != undefined
                                 && searchInput != null;
      if (valid) {
        var startSearch = true;
        if (startSearch) {
          hideSearchDropdown();
          clearSearchDom();
          setTimeout(function () {
            $.ajax({
              url: '/v1/search?s=' + searchInput,
              success: (data) => {
                showSearchDropdown();
                if (data.length > 0) {
                  renderSearchResultsWith(data);
                } else {
                  renderSearchResultsWithNoData();
                }
              }
            });
          }, makeSearchFeelNatural);
        }
      } else {
        hideSearchDropdown();
      }
    });
  }
};
