require 'capybara/rails'

class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL

  require 'capybara/poltergeist'

  setup do
    Capybara.default_driver = :poltergeist
  end

  def login user = users(:franco)
    page.driver.set_cookie 'auth_token', user.auth_token
  end
end
