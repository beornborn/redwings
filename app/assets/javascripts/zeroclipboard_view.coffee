$(document).ready ->
  clip = new ZeroClipboard($('.clip_button'))
  $('[data-toggle="tooltip"]').tooltip()
  $('.clip_button').click ->
    $(this).attr('data-original-title', 'Copied!').tooltip('fixTitle').tooltip 'show'
    $(this).mouseleave ->
      $(this).attr('data-original-title', 'Copy to clipboard').tooltip 'fixTitle'
      return
    return
  return
