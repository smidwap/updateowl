class App.tooltip extends Backbone.View
  initialize: (options) ->
    super options

    @$el.tooltip()
