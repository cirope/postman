class ActionController::TestCase
  def login user = users(:franco)
    cookies.encrypted[:auth_token] = user.auth_token
  end
end
