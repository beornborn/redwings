$(document).ready ->
  $('#left_navbar a.list-group-item').click ->
    $('#left_navbar a.list-group-item').removeClass 'active'
    $(this).addClass 'active'

  $('#academy_link').click ->
    $('#academy_users').show()
    $('#redwings_users').hide()
    $('#disabled_users').hide()


  $('#redwings_link').click ->
    $('#redwings_users').show()
    $('#academy_users').hide()
    $('#disabled_users').hide()

  $('#disabled_link').click ->
    $('#disabled_users').show()
    $('#redwings_users').hide()
    $('#academy_users').hide()

