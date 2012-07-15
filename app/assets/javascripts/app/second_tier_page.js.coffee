class App.SecondTierPage extends Backbone.View
  events:
    'submit form': 'remove'
    
  update: (fragment) ->
    @remove()
    @setElement fragment
    @

  show: ->
    @$el.modal 'show'
    @trigger_ready_notification()

  remove: ->
    @$el.modal 'hide'
    super()

  trigger_ready_notification: ->
    @$el.trigger('second_tier_page:ready', @)