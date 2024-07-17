class PurchasesController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :make_item, only: [:new, :create]
  before_action :redirect_if_sold_out_or_not_owner, only: [:new, :create]

  def index
  end

  def new
    @purchase_destination = PurchaseDestination.new
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
  end

  def create
    @item = Item.find(params[:item_id])
    @purchase_destination = PurchaseDestination.new(purchase_params)
    if @purchase_destination.valid?
      pay_item
      @purchase_destination.save
      redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
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
                                                   item_id: params[:item_id],
                                                   token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @item.price,
        card: purchase_params[:token],
        currency: 'jpy'
      )
  end

  def redirect_if_sold_out_or_not_owner
    if @item.sold_out? || @item.user == current_user
      redirect_to root_path
    end
  end

end
