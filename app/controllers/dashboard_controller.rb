class DashboardController < ApplicationController
  before_action :set_order, only: [:order]

  # GET /dashboard
  def index
    @orders = snipcart_request('orders')['items']
  end

  # GET /order/:id
  def order
  end

  private

  def set_order
    @order = snipcart_request('orders')['items'].select {|v| v['token'] == params[:id]}[0]
  end
end
