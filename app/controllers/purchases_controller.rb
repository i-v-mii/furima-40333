class PurchasesController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :make_item, only: [:new, :create]

  def index
  end

  def new
    @item = Item.find(params[:item_id])
    @purchase_destination = PurchaseDestination.new
  end

  def create
    @item = Item.find(params[:item_id])
    @purchase_destination = PurchaseDestination.new(purchase_params)
    if @purchase_destination.valid?
      @purchase_destination.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def make_item
    @item = Item.find(params[:item_id])
  end

  def purchase_params
    params.require(:purchase_destination).permit(:post_code,
                                                  :shipping_source_id,
                                                  :municipality,
                                                  :street_address,
                                                  :building_name,
                                                  :tel)
                                            .merge(user_id: current_user.id,
                                                   item_id: params[:item_id])
  end

end
