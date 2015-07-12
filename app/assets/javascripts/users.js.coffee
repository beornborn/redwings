$(document).ready ->

  $(".btn-info").click ->
    $(this).hide().prev().show()
    false

  $(".btn-danger").click ->
    $(this).parent().parent().hide().next().show()
    false

  $(".form-inline").submit ->
    $(this).hide()
    val = $(this).children().next().next().val()
    label = '<div class="label label-danger">' + val.toString() + '</div>'
    $(this).parent().html label
    true

  return

