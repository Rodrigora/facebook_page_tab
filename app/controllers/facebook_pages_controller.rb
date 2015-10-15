class FacebookPagesController < ApplicationController

  def index
    @pages = facebook_graph.get_connections("me", "accounts")
    Rails.logger.info @pages
  end
end