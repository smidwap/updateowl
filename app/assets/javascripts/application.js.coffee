//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require bootstrap
//= require underscore
//= require backbone
//= require jquery.closest_descendant
//= require jquery.auto_resize
//= require placeholders
//= require_tree .

$ ->
  App.vent = _.extend {}, Backbone.Events

  App.page = new App.Page
  App.main = new App.Main

  App.register_behaviors $('body')

  # Fix for IE placeholders
  Placeholders.init
    live: true

App.register_behaviors = ($el) ->
  $('[data-behavior]', $el).each ->
    behavior_attr = $(@).data 'behavior'
    behavior_classes = behavior_attr.split ' '

    _.each behavior_classes, (behavior) =>
      if App[behavior]
        new App[behavior]
          el: $ @