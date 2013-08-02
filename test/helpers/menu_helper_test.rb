require 'test_helper'

class MenuHelperTest < ActionView::TestCase
  test 'menu item for' do
    link = link_to User.model_name.human(count: 0), users_path
    result = menu_item_for model: User, path: users_path

    assert_equal content_tag(:li, link), result

    link = link_to "#{User.model_name.human(count: 0)} X", users_path
    result = menu_item_for model: User, path: users_path, append_to_label: 'X'

    assert_equal content_tag(:li, link), result
  end

  test 'pending tickets badge' do
    assert_match /#{pending_tickets_count}/, pending_tickets_badge
  end

  private

  def pending_tickets_count; 3; end # Controller helper mock =)
end
