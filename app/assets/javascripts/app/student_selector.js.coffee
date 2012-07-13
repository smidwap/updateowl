class App.StudentSelector extends Backbone.View
  initialize: (options) ->
    @render()

    super options

  render: ->
    @$autocomplete = @$ 'input'

    @setup_autocomplete()

    @$autocomplete.focus()

  setup_autocomplete: ->
    @$autocomplete.autocomplete
      source: @$autocomplete.data 'students'
      select: (event, ui) ->
        App.main.create_and_click_remote_link(ui.item.url)
    .data("autocomplete")._renderItem = (ul, item) ->
      StudentSelector.render_autocomplete_item.call(@, ul, item)

  @render_autocomplete_item: (ul, item) ->
    $("<li></li>")
    .data("item.autocomplete", item)
    .append('<a href="' + item.value + '" data-remote="true">' + item.label + '</a>')
    .appendTo(ul)