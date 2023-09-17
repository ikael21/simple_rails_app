# frozen_string_literal: true

class AccountActivationsController < ApplicationController
  def edit
    unless should_activate_user?
      flash[:danger] = 'Invalid activation link'

      return redirect_to root_url
    end

    user_resource.activate
    log_in(user_resource)

    flash[:success] = 'Account activated!'

    redirect_to user_resource
  end

  private

  def should_activate_user?
    return false if user_resource.blank?

    !user_resource.activated? && user_resource.authenticated?(:activation, params[:id])
  end

  def user_resource
    @user_resource ||= User.find_by(email: params[:email])
  end
end
