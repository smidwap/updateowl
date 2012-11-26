//= require jquery
//= require bootstrap-modal

$(document).on 'click', 'a[href="#video"]', ->
  $('#video-modal').modal()

# Hack to make sure video stops playing on close
$(document).on 'hidden', '#video-modal', ->
  iframe = $(this).find('iframe')
  iframe.remove()
  $(this).find('.modal-body').append(iframe.clone())