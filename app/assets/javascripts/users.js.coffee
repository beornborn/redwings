$(document).ready ->

  $(".btn-info").click ->
    $(this).hide().prev().show()
    false

  $(".btn-danger").click ->
    $(this).parent().parent().hide().next().show()
    false

  $(".form-inline").submit (event) ->
    event.preventDefault()

    action = $(this).attr("action")
    method = $(this).children().next().val()
    token  = $(this).children().next().next().val()
    reason = $(this).children().next().next().next().val()

    $.ajax({
      async: true,
      method: method,
      dataType: "json",
      contentType: "application/json",
      url: action,
      data: JSON.stringify({"authenticity_token": token,"goodbye_reason": reason}),
    })

    $(this).hide()
    label = '<div class="label label-danger">' + reason + '</div>'
    $(this).parent().html label

  return

