class ActionController::TestCase
  def login user = users(:franco)
    cookies[:auth_token] = user.auth_token
  end
end
