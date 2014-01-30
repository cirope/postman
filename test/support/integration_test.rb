require 'capybara/rails'

class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL

  require 'capybara/poltergeist'

  setup do
    Capybara.default_driver = :poltergeist
  end

  teardown do
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end

  def login user = users(:franco)
    visit login_path

    fill_in 'email', with: user.email
    fill_in 'password', with: '123'

    click_button I18n.t('sessions.new.log_in')
  end
end
