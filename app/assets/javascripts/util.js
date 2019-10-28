App.utils.checkIfPathIsSet = function(path) {
  if (window.location.pathname.indexOf(path) != -1) {
    return true
  } else {
    return false
  }
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

  $('.discover input[type="checkbox"]').off('click').on('click', (e) => {
    clickEventActions(e)
  })
  $('.to-listen input[type="checkbox"]').off('click').on('click', (e) => {
    clickEventActions(e)
  })
  $('.listening input[type="checkbox"]').off('click').on('click', (e) => {
    clickEventActions(e)
  })
  $('.listened input[type="checkbox"]').off('click').on('click', (e) => {
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
