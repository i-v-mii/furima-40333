class PurchasesController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
  end

  def new
    @purchases_destination = PurchasesDestination.new
  end

  def create
    @purchases_destination = PurchasesDestination.new(purchases_destination_params)
    if @purchases_destination.valid?
      @purchases_destination.save
      redirect_to root_path
    else
      render :index
    end
  end

  def make_item
    @item = Item.find(params[:item_id])
  end

  def destination_params
    params.require(:purchases_destination).permit(:post_code,
                                                  :shipping_source_id,
                                                  :municipality,
                                                  :street_address,
                                                  :building_name, :tel
                                                  )
                                            .merge(user_id: current_user.id,
                                                   item_id: params[:item_id],
                                                    token: params[:token]
                                                  )
  end
  
end
