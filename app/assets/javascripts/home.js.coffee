$(document).on 'scroll', ->
  url = $('.pagination .next_page').attr('href')

  if url && $(document).scrollTop() > $(document).height() - $(window).height() - 100
    $('.pagination').text('Loading more messages...');
    $.getScript(url)