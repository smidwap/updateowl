class App.NewMessage extends Backbone.View
  initialize: (options) ->
    super options

    @$('[data-message-field]').focus()