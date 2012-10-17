$container = $('<div id="updateowl_extension_container"></div>').prependTo 'body'

class RemoteUrl
  constructor: (@url, @method = 'get', @data = '') ->
    @

  goto: ->
    if @method is 'get' then @_goto_via_get() else @_goto_via_post()

  handleResponse: (response) ->
    eval response

  _goto_via_get: ->
    appAPI.request.get @url, RemoteUrl.prototype.handleResponse

  _goto_via_post: ->
    appAPI.request.post @url, @data, RemoteUrl.prototype.handleResponse

$(document, $container).on 'click', 'a[data-remote]', (e) ->
  e.preventDefault()

  url = $(@).attr 'href'

  new RemoteUrl(url).goto()

$(document, $container).on 'submit', 'form[data-remote]', (e) ->
  e.preventDefault()

  url = $(@).attr 'action'
  data = $.param($(@).serializeArray())

  new RemoteUrl(url, 'post', data).goto()

(()->
  new RemoteUrl('http://localhost:3000/dashboard.extension').goto()

  $('body').css({
    paddingTop: parseInt($('body').css('padding-top')) + 50
  })
).call(@)