class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  protected

  def facebook_graph(token = nil)
    token = session[:access_token] unless token
    Koala::Facebook::API.new token, Rails.application.secrets.facebook_api_secret
  end
end
