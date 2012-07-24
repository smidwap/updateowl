class App.expandable extends Backbone.View
  initialize: (options) ->
    super options

    @$el.closest_descendant('[data-expander]').on 'click', _.bind(@open, @)
    @$el.closest_descendant('[data-closer]').on 'click', _.bind(@close, @)

  open: (e) ->
    e.preventDefault()
    @$el.closest_descendant('[data-expansion]').show()
    @$el.addClass 'expanded'

  close: (e) ->
    e.preventDefault()
    @$el.closest_descendant('[data-expansion]').hide()
    @$el.removeClass 'expanded'