(($) ->
  class AutocompleteSelectableLink
    constructor: (el) ->
      @$el = $(el)

      @_setupAutocomplete()
      @_renderLinksForDropdown()

    _setupAutocomplete: ->
      @$el.autocomplete
        source: @$el.data 'source'
        autoFocus: true
        select: (event, ui) =>
          @_goToUrl(ui.item.value)

    _renderLinksForDropdown: ->
      @$el.data("autocomplete")._renderItem = (ul, item) =>
        $('<li></li>')
          .data('item.autocomplete', item)
          .append(@_linkFromUrlForDropdown(item.value, item.label))
          .appendTo(ul)

    _linkFromUrlForDropdown: (url, label = "") ->
      data_remote_attr = if @$el.data 'remote' then 'data-remote="true"' else ''
      "<a href=\"#{url}\" #{data_remote_attr}>#{label}</a>"

    _goToUrl: (url) ->
      if @$el.data 'remote'
        $(@_linkFromUrlForDropdown(url))
          .appendTo('body')
          .hide()
          .click()
      else
        window.location = url

  $.fn.autocomplete_selectable_link = () ->
    @each () ->
      data = $.data(@, 'autocomplete_selectable_link')
      $.data(@, 'autocomplete_selectable_link', new AutocompleteSelectableLink(@)) unless data

  $ ->
    $(document).on 'focus', '[data-behavior~=autocomplete_selectable_link]', ->
      $(@).autocomplete_selectable_link()
)($)