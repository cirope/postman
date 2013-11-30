require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  def setup
    @category = categories(:bug)
  end

  test 'validates blank attributes' do
    @category.name = ''

    assert @category.invalid?
    assert_error @category, :name, :blank
  end

  test 'validates unique attributes' do
    @category.name = categories(:feature).name

    assert @category.invalid?
    assert_error @category, :name, :taken
  end
end
