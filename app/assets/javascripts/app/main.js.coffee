class App.Main extends Backbone.View
  el: 'body'

  events:
    'second_tier_page:ready .student_selector': 'init_student_selector'

  init_student_selector: (e, second_tier_page) ->
    new App.StudentSelector
      el: second_tier_page.el

  create_and_click_remote_link: (url) ->
    $('<a href="' + url + '" data-remote="true" display></a>')
    .appendTo(@$el)
    .click()

  alert: (content) ->
    new App.Alert
      el: $(content).prependTo @$('.alert_container')

  redirect: (url) ->
    window.location = url