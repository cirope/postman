require 'test_helper'

class TicketsTest < ActionDispatch::IntegrationTest
  test 'should poll and detect for new tickets' do
    login

    visit tickets_path

    assert page.has_css?('#ticket-alert', visible: false)

    tickets(:enhancement).dup.save!

    page.execute_script 'jQuery.getScript("/tickets")'

    assert page.has_css?('#ticket-alert', visible: true)
  end

  test 'should update the ticket count' do
    login

    visit users_path # Not necessarily viewing tickets

    assert page.has_css?('#ticket-count', text: 1)

    tickets(:enhancement).dup.save!

    page.execute_script 'jQuery.getScript("/tickets")'

    assert page.has_css?('#ticket-count', text: 2)
  end
end
