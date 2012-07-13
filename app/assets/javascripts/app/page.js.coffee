class App.Page extends Backbone.View
  el: 'body'

  events:
    'ajax:success a, form': 'show_second_tier_page_from_remote'

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