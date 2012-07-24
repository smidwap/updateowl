class App.SecondTierPage extends Backbone.View
  events:
    'ajax:success [data-close-on-success]': 'remove'
    
  update: (fragment) ->
    @remove()
    @setElement fragment
    App.register_behaviors(@$el)
    @

  show: ->
    @$el.modal 'show'
    @trigger_ready_notification()

  remove: ->
    console.log 'hide modal'
    @$el.modal 'hide'
    super()

  trigger_ready_notification: ->
    @$el.trigger('second_tier_page:ready', @)