require 'test_helper'

class TenantTest < ActiveSupport::TestCase
  def setup
    @tenant = tenants(:postman)
  end
    
  test 'validates blank attributes' do
    @tenant.name = ''
    @tenant.subdomain = ''
    
    assert @tenant.invalid?
    assert_error @tenant, :name, :blank
    assert_error @tenant, :subdomain, :blank
  end

  test 'validates attributes length' do
    @tenant.name = 'abcde' * 52
    @tenant.subdomain = 'abcde' * 52
    
    assert @tenant.invalid?
    assert_error @tenant, :name, :too_long, count: 255
    assert_error @tenant, :subdomain, :too_long, count: 255
  end
    
  test 'validates unique attributes' do
    @tenant.subdomain = tenants(:libreduca).subdomain

    assert @tenant.invalid?
    assert_error @tenant, :subdomain, :taken
  end
end
