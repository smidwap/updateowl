class App.Main extends Backbone.View
  el: 'body'

  alert: (content) ->
    new App.Alert
      el: $(content).prependTo @$('.alert_container')