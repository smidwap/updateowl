class App.autocomplete extends Backbone.View
  initialize: (options) ->
    super options

    @$el.autocomplete
      source: @$el.data 'source'
      autoFocus: true
      select: (event, ui) =>
        @trigger_select(ui.item.value)

  trigger_select: (value) ->
    @$el.trigger('autocomplete:select', value)