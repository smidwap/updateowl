class App.autocomplete_selectable_link extends Backbone.View
  initialize: (options) ->
    super options

    @render_links_for_dropdown()

    @$el.bind 'autocomplete:select', (e, value) =>
      @go_to_url(value)

  render_links_for_dropdown: ->
    @$el.data("autocomplete")._renderItem = (ul, item) =>
      $('<li></li>')
        .data('item.autocomplete', item)
        .append(@link_from_url_and_label(item.value, item.label))
        .appendTo(ul)

  link_from_url_and_label: (url, label = "") ->
    data_remote_attr = if @$el.data 'remote' then 'data-remote="true"' else ''
    "<a href=\"#{url}\" #{data_remote_attr}>#{label}</a>"

  go_to_url: (url) ->
    if @$el.data 'remote'
      $(@link_from_url_and_label(url))
        .appendTo('body')
        .hide()
        .click()
    else
      window.location = url