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

