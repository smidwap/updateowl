class App.Alert extends Backbone.View
  FADE_OUT_TIME: 8000

  initialize: (options) ->
    super options

    @setup()

    @

  setup: ->
    @setup_fadeout()

  setup_fadeout: ->
    that = @
    setTimeout ->
      that.$el.fadeOut 'slow', ->
        that.remove()
    , that.FADE_OUT_TIME