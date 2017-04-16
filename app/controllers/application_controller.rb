class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # Redirects to stored location (or to the default)
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Store the URL trying to be accessed
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end
end
