App.room = App.cable.subscriptions.create "ActivityNotificationsChannel",
  received: (data) ->
    $('#messages').append data['message']
