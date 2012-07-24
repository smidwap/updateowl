//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require bootstrap
//= require underscore
//= require backbone
//= require jquery.closest_descendant
//= require_tree .

$ ->
  App.page = new App.Page
  App.main = new App.Main

  App.register_behaviors $('body')


App.register_behaviors = ($el) ->
  $('[data-behavior]', $el).each ->
    behavior_attr = $(@).data 'behavior'
    behavior_classes = behavior_attr.split ' '

    _.each behavior_classes, (behavior) =>
      if App[behavior]
        new App[behavior]
          el: $ @