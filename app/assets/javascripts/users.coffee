$(document).on "page:change", ->
  $('#edit_about-link').click ->
    $('#about-box').hide()
    $('#edit_about-box').fadeIn()
    $('#user_about').focus()

  userInvalid = !$('.user').data('user-valid')
  $('#edit_about-link').trigger 'click' if userInvalid
