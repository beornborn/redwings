$(document).on "page:change", ->
  $('#edit_about-link').click ->
    $('#about-box').hide()
    $('#edit_about-box').fadeIn()
    $('#user_about').focus()
