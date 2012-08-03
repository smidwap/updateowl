class App.Page extends Backbone.View
  el: 'body'

  events:
    'ajax:success a:not([data-no-second-tier]), form:not([data-no-second-tier])': 'show_second_tier_page_from_remote',
    'ajax:error': 'handle_error'

  initialize: (options) ->
    @second_tier_page = new App.SecondTierPage
    super options

  show_second_tier_page: (element) ->
    @$el.append(element)
    @second_tier_page
      .update(element)
      .show()

  show_second_tier_page_from_remote: (e, data, status, xhr) ->
    @show_second_tier_page($(data))

  handle_error: (e, data, status, xhr) ->
    message = if data.status == 403 then data.responseText else "An unknown error has occured. Please refresh and try again."
    alert message