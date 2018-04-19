App.room = App.cable.subscriptions.create "ActivityNotificationsChannel",
  received: (data) ->
    $('body[data-controller="bands"][data-action="show"][data-id="'+data['band']+'"] .current_activity').fadeOut 'fast', ->
      $('.activities').fadeIn 'fast'
      $('.activity_success').html(data['message']).fadeIn 'fast', ->
        $(this).delay(3000).fadeOut 'slow'
        $('body[data-controller="bands"][data-action="show"][data-id="'+data['band']+'"] .news').load('/bands/'+data['band']+'/happenings')
