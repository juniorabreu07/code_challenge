class BuiesController < ApplicationController
  before_action :set_buy, only: %i[ show update destroy ]

  # GET /buies
  def index
    @buies = Buy.all

    render json: @buies
  end

  # GET /buies/1
  def show
    render json: @buy
  end

  # POST /buies
  def create
    @buy = Buy.new(buy_params)

    if @buy.save
      render json: @buy, status: :created, location: @buy
    else
      render json: @buy.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /buies/1
  def update
    if @buy.update(buy_params)
      render json: @buy
    else
      render json: @buy.errors, status: :unprocessable_entity
    end
  end

  # DELETE /buies/1
  def destroy
    @buy.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_buy
      @buy = Buy.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def buy_params
      params.require(:buy).permit(:product_id)
    end
end
