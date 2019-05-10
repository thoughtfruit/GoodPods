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

/* mousetrap v1.6.3 craig.is/killing/mice */
(function(q,u,c){function v(a,b,g){a.addEventListener?a.addEventListener(b,g,!1):a.attachEvent("on"+b,g)}function z(a){if("keypress"==a.type){var b=String.fromCharCode(a.which);a.shiftKey||(b=b.toLowerCase());return b}return n[a.which]?n[a.which]:r[a.which]?r[a.which]:String.fromCharCode(a.which).toLowerCase()}function F(a){var b=[];a.shiftKey&&b.push("shift");a.altKey&&b.push("alt");a.ctrlKey&&b.push("ctrl");a.metaKey&&b.push("meta");return b}function w(a){return"shift"==a||"ctrl"==a||"alt"==a||
"meta"==a}function A(a,b){var g,d=[];var e=a;"+"===e?e=["+"]:(e=e.replace(/\+{2}/g,"+plus"),e=e.split("+"));for(g=0;g<e.length;++g){var m=e[g];B[m]&&(m=B[m]);b&&"keypress"!=b&&C[m]&&(m=C[m],d.push("shift"));w(m)&&d.push(m)}e=m;g=b;if(!g){if(!p){p={};for(var c in n)95<c&&112>c||n.hasOwnProperty(c)&&(p[n[c]]=c)}g=p[e]?"keydown":"keypress"}"keypress"==g&&d.length&&(g="keydown");return{key:m,modifiers:d,action:g}}function D(a,b){return null===a||a===u?!1:a===b?!0:D(a.parentNode,b)}function d(a){function b(a){a=
a||{};var b=!1,l;for(l in p)a[l]?b=!0:p[l]=0;b||(x=!1)}function g(a,b,t,f,g,d){var l,E=[],h=t.type;if(!k._callbacks[a])return[];"keyup"==h&&w(a)&&(b=[a]);for(l=0;l<k._callbacks[a].length;++l){var c=k._callbacks[a][l];if((f||!c.seq||p[c.seq]==c.level)&&h==c.action){var e;(e="keypress"==h&&!t.metaKey&&!t.ctrlKey)||(e=c.modifiers,e=b.sort().join(",")===e.sort().join(","));e&&(e=f&&c.seq==f&&c.level==d,(!f&&c.combo==g||e)&&k._callbacks[a].splice(l,1),E.push(c))}}return E}function c(a,b,c,f){k.stopCallback(b,
b.target||b.srcElement,c,f)||!1!==a(b,c)||(b.preventDefault?b.preventDefault():b.returnValue=!1,b.stopPropagation?b.stopPropagation():b.cancelBubble=!0)}function e(a){"number"!==typeof a.which&&(a.which=a.keyCode);var b=z(a);b&&("keyup"==a.type&&y===b?y=!1:k.handleKey(b,F(a),a))}function m(a,g,t,f){function h(c){return function(){x=c;++p[a];clearTimeout(q);q=setTimeout(b,1E3)}}function l(g){c(t,g,a);"keyup"!==f&&(y=z(g));setTimeout(b,10)}for(var d=p[a]=0;d<g.length;++d){var e=d+1===g.length?l:h(f||
A(g[d+1]).action);n(g[d],e,f,a,d)}}function n(a,b,c,f,d){k._directMap[a+":"+c]=b;a=a.replace(/\s+/g," ");var e=a.split(" ");1<e.length?m(a,e,b,c):(c=A(a,c),k._callbacks[c.key]=k._callbacks[c.key]||[],g(c.key,c.modifiers,{type:c.action},f,a,d),k._callbacks[c.key][f?"unshift":"push"]({callback:b,modifiers:c.modifiers,action:c.action,seq:f,level:d,combo:a}))}var k=this;a=a||u;if(!(k instanceof d))return new d(a);k.target=a;k._callbacks={};k._directMap={};var p={},q,y=!1,r=!1,x=!1;k._handleKey=function(a,
d,e){var f=g(a,d,e),h;d={};var k=0,l=!1;for(h=0;h<f.length;++h)f[h].seq&&(k=Math.max(k,f[h].level));for(h=0;h<f.length;++h)f[h].seq?f[h].level==k&&(l=!0,d[f[h].seq]=1,c(f[h].callback,e,f[h].combo,f[h].seq)):l||c(f[h].callback,e,f[h].combo);f="keypress"==e.type&&r;e.type!=x||w(a)||f||b(d);r=l&&"keydown"==e.type};k._bindMultiple=function(a,b,c){for(var d=0;d<a.length;++d)n(a[d],b,c)};v(a,"keypress",e);v(a,"keydown",e);v(a,"keyup",e)}if(q){var n={8:"backspace",9:"tab",13:"enter",16:"shift",17:"ctrl",
18:"alt",20:"capslock",27:"esc",32:"space",33:"pageup",34:"pagedown",35:"end",36:"home",37:"left",38:"up",39:"right",40:"down",45:"ins",46:"del",91:"meta",93:"meta",224:"meta"},r={106:"*",107:"+",109:"-",110:".",111:"/",186:";",187:"=",188:",",189:"-",190:".",191:"/",192:"`",219:"[",220:"\\",221:"]",222:"'"},C={"~":"`","!":"1","@":"2","#":"3",$:"4","%":"5","^":"6","&":"7","*":"8","(":"9",")":"0",_:"-","+":"=",":":";",'"':"'","<":",",">":".","?":"/","|":"\\"},B={option:"alt",command:"meta","return":"enter",
escape:"esc",plus:"+",mod:/Mac|iPod|iPhone|iPad/.test(navigator.platform)?"meta":"ctrl"},p;for(c=1;20>c;++c)n[111+c]="f"+c;for(c=0;9>=c;++c)n[c+96]=c.toString();d.prototype.bind=function(a,b,c){a=a instanceof Array?a:[a];this._bindMultiple.call(this,a,b,c);return this};d.prototype.unbind=function(a,b){return this.bind.call(this,a,function(){},b)};d.prototype.trigger=function(a,b){if(this._directMap[a+":"+b])this._directMap[a+":"+b]({},a);return this};d.prototype.reset=function(){this._callbacks={};
this._directMap={};return this};d.prototype.stopCallback=function(a,b){if(-1<(" "+b.className+" ").indexOf(" mousetrap ")||D(b,this.target))return!1;if("composedPath"in a&&"function"===typeof a.composedPath){var c=a.composedPath()[0];c!==a.target&&(b=c)}return"INPUT"==b.tagName||"SELECT"==b.tagName||"TEXTAREA"==b.tagName||b.isContentEditable};d.prototype.handleKey=function(){return this._handleKey.apply(this,arguments)};d.addKeycodes=function(a){for(var b in a)a.hasOwnProperty(b)&&(n[b]=a[b]);p=null};
d.init=function(){var a=d(u),b;for(b in a)"_"!==b.charAt(0)&&(d[b]=function(b){return function(){return a[b].apply(a,arguments)}}(b))};d.init();q.Mousetrap=d;"undefined"!==typeof module&&module.exports&&(module.exports=d);"function"===typeof define&&define.amd&&define(function(){return d})}})("undefined"!==typeof window?window:null,"undefined"!==typeof window?document:null);


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
    if (b%2==0) {
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

  function clearAddToLibraryFromOtherNodes() {
    $('.discover div').children('add-to-library').remove()
  }

  function appendAddToLibraryToCurrentNode(e) {
    $(e.currentTarget).append($('.add-to-library'))
  }

  function bindCheckboxClickEvent() {
    $('.discover input[type="checkbox"]').off('click').on('click', (e) => {
      // User is trying to add to library
      if ($(e.currentTarget).prop('checked') == true) {
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
      // User is trying to remove from their library
      } else if ($(e.currentTarget).prop('checked') == false) {
        $.ajax({
          type: 'get',
          url: '/remove_from_my_library' + App.clientId + '&podcast_id=' + $(e.currentTarget).parent().parent().attr('data-pod-id') + '&list=' + $(e.currentTarget).attr('id'),
          success: function(data) {
            // TODO: Update UI to reflect this delete by unchecking boxes before a reload
          }
        })
      }
      window.location.reload()
    })
  }

  function unhideAddToLibrary() {
    $('.add-to-library').removeClass('hidden')
  }

  function populateAddToLibraryWithSavedStateFor(target) {
    $.ajax({
      type: 'get',
      url: '/my_library' + App.clientId + '&podcast_id=' + target.attr('data-pod-id'),
      success: function(status) {
        if (status.indexOf("to-listen") != -1) {
          target.find('#to-listen').prop('checked', true)
        } else {
          target.find('#to-listen').prop('checked', false)
        }
        if (status.indexOf("listened") != -1) {
          target.find('#listened').prop('checked', true)
        } else {
          target.find('#listened').prop('checked', false)
        }
        if (status.indexOf("listening") != -1) {
          target.find('#listening').prop('checked', true)
        } else {
          target.find('#listening').prop('checked', false)
        }
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
  function renderMyListsWith(data) {
    data.forEach(user_podcast_status => {
      if (user_podcast_status.status == "to-listen") {
        $('.my-lists .to-listen').html('')
        $.ajax({
          url: '/podcasts/' + user_podcast_status.podcast_id + App.clientId,
          success: function(podcast) {
            $('.my-lists .to-listen').append(
              "<div data-pod-id='" + podcast.id + "' style='display: inline-block; position: relative;'><img src='" + podcast.logo_url + "' width='75' style='padding: 5px; float: left' /></div>"
            )
          }
        })
      } else if (user_podcast_status.status == 'listening') {
        $('.my-lists .listening').html('')
        $.ajax({
          url: '/podcasts/' + user_podcast_status.podcast_id + App.clientId,
          success: function(podcast) {
            $('.my-lists .listening').append(
              "<div data-pod-id='" + podcast.id + "' style='display: inline-block; position: relative;'><img src='" + podcast.logo_url + "' width='75' style='padding: 5px; float: left' /></div>"
            )
          }
        })
      } else if (user_podcast_status.status == 'listened') {
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
      // $el.append(
      //   "<div data-pod-id='" + podcast.id + "' style='display: inline-block; position: relative;'><img src='" + podcast.logo_url + "' width='75' style='padding: 5px; float: left' /></div>"
      // )
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

