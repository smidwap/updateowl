class App.Views.InpageFragment extends Backbone.View
  events:
    'hidden': 'remove' # Clean up when modal is hidden

  update: (fragment) ->
    @remove()
    @setElement fragment

  show: ->
    @$el.modal 'show'

  remove: ->
    @$el.modal 'hide'
    super()