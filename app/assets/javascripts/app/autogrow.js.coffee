class App.autogrow extends Backbone.View
  initialize: (options) ->
    super options

    @$el.autosize()