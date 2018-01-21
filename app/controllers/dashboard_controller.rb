class DashboardController < ApplicationController
  before_action :set_order, only: [:order]

  # GET /dashboard
  def index
    unless current_user.admin
      @orders = snipcart_request('orders')['items'].select { |v|
        DateTime.parse(v['creationDate']) >= current_user.periods.last.start_date.beginning_of_day &&
        DateTime.parse(v['creationDate']) <= current_user.periods.last.end_date.end_of_day
      }
    else
      @orders = snipcart_request('orders')['items']
    end
    @orders_without_refund = @orders.select { |v|
      v['refunds'].length <= 0
    }
  end

  # GET /order/:id
  def order
    respond_to do |format|
      format.html {
        render :order
      }
      format.json {
        render json: {
          status: @order['status'],
          invoiceNumber: @order['invoiceNumber'],
          user: {
            billingAddressName: @order['user']['billingAddressName']
          }
        }.to_json
      }
    end
  end

  private

  def set_order
    @order = snipcart_request('orders')['items'].select {|v| v['token'] == params[:id]}[0]
    unless current_user.admin
      start = DateTime.parse(@order['creationDate']) >= current_user.periods.last.start_date.beginning_of_day
      stop = DateTime.parse(@order['creationDate']) <= current_user.periods.last.end_date.end_of_day
      if start == true && stop == true
        return @order
      else
        redirect_to user_root_url, notice: "Vous n'avez pas accès à cette commande"
      end
    end
  end
end
