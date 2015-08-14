clipping = ->
  clip = new ZeroClipboard($('.clip_button'))
  $('[data-toggle="tooltip"]').tooltip()
  $('.clip_button').click ->
    $(this).attr('data-original-title', 'Copied!').tooltip('fixTitle').tooltip 'show'
    $(this).mouseleave ->
      $(this).attr('data-original-title', 'Copy to clipboard').tooltip 'fixTitle'

$ ->
  clipping

# Turbolinks cause problems to with loading ZeroClipboard after going to another page,
# making ZeroClipboard not working,
# so this workaround is to fix them:

$(document).on 'page:before-change', ->
  ZeroClipboard.destroy()

$(window).bind 'page:change', clipping
