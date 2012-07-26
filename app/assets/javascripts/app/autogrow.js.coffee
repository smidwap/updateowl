class App.autogrow extends Backbone.View
  initialize: (options) ->
    super options

    @$el.autogrow
      maxHeight: 60