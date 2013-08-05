@TicketsHelper =
  updateCount: (count) ->
    ticketCount = $('#ticket-count')

    ticketCount.text count
    TitleHelper.updateCount count

    if count > 0
      ticketCount.addClass 'label-danger'
    else
      ticketCount.removeClass 'label-danger'
