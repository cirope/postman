jQuery ($) ->
  updateTicketCount = ->
    $.getScript '/tickets'
    setTimeout updateTicketCount, 15000

  setTimeout updateTicketCount, 15000
