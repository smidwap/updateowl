class App.popover extends Backbone.View
  initialize: (options) ->
    super options

    @$el.popover()
