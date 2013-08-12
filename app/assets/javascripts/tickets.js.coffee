@TicketsHelper =
  updateCount: (count) ->
    ticketCount = $('#ticket-count')

    ticketCount.text count
    TitleHelper.updateCount count

    if count > 0
      ticketCount.addClass 'label-danger'
    else
      ticketCount.removeClass 'label-danger'

  updateLastTicket: (lastTicket) ->
    ticketAlert = $('#ticket-alert')

    if ticketAlert && ticketAlert.data('lastTicketId') != lastTicket
      ticketAlert.removeClass 'hidden'
