class PeriodsController < ApplicationController
  before_action :set_period, only: [:show, :edit, :update, :destroy]

  # GET /periods
  # GET /periods.json
  def index
    unless current_user.admin
      @periods = Period.where(user: current_user)
    else
      @periods = Period.all
    end
  end

  # GET /periods/1
  # GET /periods/1.json
  def show
    @orders = snipcart_request('orders')['items'].select { |v|
      DateTime.parse(v['creationDate']) >= @period.start_date.beginning_of_day &&
      DateTime.parse(v['creationDate']) <= @period.end_date.end_of_day
    }
  end

  # POST /periods/1
  def order_status
    @orders = []
    current_user.periods.each do |period|
      @orders.push(
        snipcart_request('orders')['items'].select { |v|
          DateTime.parse(v['creationDate']) >= period.start_date.beginning_of_day &&
          DateTime.parse(v['creationDate']) <= period.end_date.end_of_day
        }
      )
    end

    @orders[0].each do |order|
      if order['token'].to_s == params[:token].to_s || current_user.admin
        snipcart_request('orders/' + params[:token], {status: params[:status]}, 'PUT')
        respond_to do |format|
          format.js {render inline: "location.reload();" }
        end
      else
        redirect_to periods_url, notice: "vous n'avez pas accès à cette commande"
      end
    end
  end

  # GET /periods/new
  def new
    @period = Period.new
  end

  # GET /periods/1/edit
  def edit
  end

  # POST /periods
  # POST /periods.json
  def create
    @period = Period.new(period_params)

    respond_to do |format|
      if @period.save
        format.html { redirect_to @period, notice: 'Period was successfully created.' }
        format.json { render :show, status: :created, location: @period }
      else
        format.html { render :new }
        format.json { render json: @period.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /periods/1
  # PATCH/PUT /periods/1.json
  def update
    respond_to do |format|
      if @period.update(period_params)
        format.html { redirect_to @period, notice: 'Period was successfully updated.' }
        format.json { render :show, status: :ok, location: @period }
      else
        format.html { render :edit }
        format.json { render json: @period.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /periods/1
  # DELETE /periods/1.json
  def destroy
    @period.destroy
    respond_to do |format|
      format.html { redirect_to periods_url, notice: 'Period was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_period
      @period = Period.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def period_params
      params.require(:period).permit(:start_date, :end_date, :user_id)
    end
end
