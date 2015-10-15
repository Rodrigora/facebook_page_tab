class FacebookPageTabsController < ApplicationController

  def index
    @page = page_graph.get_object(params[:facebook_page_id])
    @tabs = page_graph.get_connections(params[:facebook_page_id], 'tabs')

    Rails.logger.debug @page
    Rails.logger.debug @tabs
  end

  def create
    options = {
      app_id: Rails.application.secrets.facebook_app_id,
      custom_name: 'Custom name'
    }
    graph = page_graph.put_connections(page_id, "tabs", options)
    flash[:notice] = "Page tab added"
    redirect_to facebook_page_facebook_page_tabs_path page_id, token: token
  end

  def destroy
    options = {
      tab: params[:id]
    }
    graph = page_graph.delete_connections(page_id, "tabs", options)
    flash[:notice] = "Page tab removed"

    redirect_to facebook_page_facebook_page_tabs_path page_id, token: token
  end

  private

  def page_graph
    @graph ||= facebook_graph(token)
  end

  def page_id
    params[:facebook_page_id]
  end

  def token
    params[:token]
  end
end