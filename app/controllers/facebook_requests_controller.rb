class FacebookRequestsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:create]

  def create
    @oauth = Koala::Facebook::OAuth.new(
      Rails.application.secrets.facebook_app_id,
      Rails.application.secrets.facebook_api_secret,
      "http://localhost:3000/")

    Rails.logger.debug @oauth.parse_signed_request(params[:signed_request])
    redirect_to "/"
  end


  def base64_url_decode str
    encoded_str = str.gsub('-','+').gsub('_','/')
    encoded_str += '=' while !(encoded_str.size % 4).zero?
    Base64.decode64(encoded_str)
  end

  def decode_data str
    encoded_sig, payload = str.split('.')
    data = ActiveSupport::JSON.decode base64_url_decode(payload)
  end
end