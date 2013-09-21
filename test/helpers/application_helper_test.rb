require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test 'title' do
    @title = 'test page'

    assert_equal [I18n.t('app_name'), @title].join(' | '), title
  end

  test 'title with count' do
    @title = 'test page'
    @count = 5

    assert_equal [I18n.t('app_name'), "(#@count) #@title"].join(' | '), title
  end

  private

  def pending_tickets_count; @count; end # Controller method mock
end
