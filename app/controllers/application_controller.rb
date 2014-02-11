class ApplicationController < ActionController::Base
  include ActionTitle

  protect_from_forgery with: :exception

  def current_user
    @current_user ||= user_by_auth_token if cookies[:auth_token]
  end
  helper_method :current_user

  def authorize
    plug_mini_profiler

    redirect_to login_url, alert: t('messages.not_authorized') unless current_user
  end

  def pending_tickets_count
    @pending_tickets_count ||= Ticket.loose_or_for(current_user).count if current_user
  end
  helper_method :pending_tickets_count

  private

    def user_by_auth_token
      User.find_by auth_token: cookies.encrypted[:auth_token]
    end

    def plug_mini_profiler
      Rack::MiniProfiler.authorize_request if current_user.try :is_admin?
    end
end
