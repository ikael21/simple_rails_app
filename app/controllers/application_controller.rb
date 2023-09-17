# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionsHelper

  private

  # before filters
  # confirms a logged in user
  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = 'Please log in.'
    redirect_to(login_url)
  end

  def add_flash_message(key, message)
    flash[key] = message
  end
end
