class ApplicationController < ActionController::Base
  include ActionTitle
  include CurrentUser
  include UpdateResource

  protect_from_forgery with: :exception

  def authorize
    plug_mini_profiler

    redirect_to login_url, alert: t('messages.not_authorized') unless current_user
  end

  def pending_tickets_count
    @pending_tickets_count ||= Ticket.loose_or_for(current_user).count if current_user
  end
  helper_method :pending_tickets_count

  private

    def plug_mini_profiler
      Rack::MiniProfiler.authorize_request if current_user.try :is_admin?
    end
end
