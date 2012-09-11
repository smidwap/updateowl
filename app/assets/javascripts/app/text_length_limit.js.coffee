class App.text_length_limit extends Backbone.View
  events:
    'keydown [data-limited-input]': 'text_changed'

  initialize: (options) ->
    super options

    @$limited_input = @$('[data-limited-input]')
    @$countdown = @$('[data-countdown]')
    @$length_exceeded = @$('[data-length-exceeded]')

    @limit = @$el.data('limit')
    @show_countdown_at = @$el.data('show_countdown_at')
    @warn_at = @$el.data('warn_at')

  text_changed: ->
    @show_countdown()
    @style_countdown()
    @show_exceeded()

  show_countdown: ->
    if @characters() > @show_countdown_at
      @$countdown.show()
      @$countdown.text("#{@remaining()} remaining (recommended)")
    else
      @$countdown.hide()

  style_countdown: ->
    if @characters() > @warn_at
      @$countdown.addClass('getting_close')
    else
      @$countdown.removeClass('getting_close')

  show_exceeded: ->
    if @remaining() < 0
      @$length_exceeded.show()
    else
      @$length_exceeded.hide()

  remaining: ->
    @limit - @characters()

  characters: ->
    @$limited_input.val().length