$(document).ready ->

  $("#left_navbar a").filter ->
      return this.href == location.href.replace(/#.*/, '')
    .addClass 'active'

