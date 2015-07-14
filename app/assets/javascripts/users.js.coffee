$(document).ready ->

  $('.goodbye-reason').find('.add-reason-button').click ->
    name = $(this).attr('name')

    $(this).hide()
    $("form[name='#{name}']").show()

  $('.goodbye-reason').find('.btn-danger').click ->
    name = $(this).attr('name')

    $("form[name='#{name}']").hide()
    $(".add-reason-button[name='#{name}']").show()

  $('.goodbye-reason').find('.form-inline').submit (event) ->
    event.preventDefault()

    form = $(this)
    url  = form.attr('action')
    name = form.attr('name')
    data = form.serialize()

    $.ajax({
      method: 'PATCH',
      url: url,
      data: data,
      success: (data) ->
        form.hide()
        $(".goodbye-reason[name='#{name}']").text data.goodbye_reason
    })

