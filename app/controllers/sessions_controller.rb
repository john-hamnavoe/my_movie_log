# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        login_user_and_direct(user)
      end
    else
      report_authentication_failure
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private
    def login_user_and_direct(user)
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or user
    end

    def report_authentication_failure
      message = 'Account not activated. '
      message += 'Check your email for the activation link.'
      flash.now[:warning] = message
      redirect_to root_url
    end
end
