$alert = $('<span id="uox-alert">Your update has been sent!</span>').appendTo($('.uox-header'))

setTimeout(->
  $alert.remove()
, 10000)