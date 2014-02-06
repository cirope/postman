class ProfilesController < ApplicationController
  include Responder

  before_action :authorize, :set_user

  def edit
    @title = t '.title'
  end

  def update
    @title = t 'profiles.edit.title'

    update_and_respond
  end

  private

    def set_user
      @user = current_user
    end

    def user_params
      params.require(:user).permit :name, :lastname, :email, :password, :password_confirmation, :lock_version
    end
    alias_method :resource_params, :user_params

    def resource
      @user
    end

    def after_update_url; root_url; end
    def edit_resource_url; profile_url; end
end
