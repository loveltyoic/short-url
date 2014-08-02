$(document).ready ->
  $('button').click ->
    $.post '/url', {url: $('#url').val()}, (response)->
      $('#short_url').html(response.short_url)