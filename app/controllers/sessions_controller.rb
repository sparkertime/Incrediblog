class SessionsController < ApplicationController
  def create
    self.logged_in = Authentication.authenticate(params[:password])

    logged_in? ? 
      redirect_to(posts_path)
      : redirect_to(new_session_path)
  end
end
