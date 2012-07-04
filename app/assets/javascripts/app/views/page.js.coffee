class App.Views.Page extends Backbone.View
  el: 'body'

  events:
    'ajax:success a[data-remote]': 'show_inpage_fragment'

  initialize: (options) ->
    @inpage_fragment = new App.Views.InpageFragment
    super options

  show_inpage_fragment: (e, data, status, xhr) ->
    @inpage_fragment
      .update(data)
      .show()