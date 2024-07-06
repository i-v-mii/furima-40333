class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :make_item, only: [:show, :edit, :update, :destroy]
  before_action :item_owner, only: [:edit, :update]

  def index
    @items = Item.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user
    if @item.save
      redirect_to  root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to @item, notice: 'Item was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private
  
  def make_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:product_name,
                                  :price,
                                  :category_id,
                                  :condition_id,
                                  :delivery_charge_id,
                                  :shipping_source_id,
                                  :date_of_shipment_id,
                                  :explanation,
                                  :image
                                )
  end

  def item_owner
    unless current_user == @item.user
      redirect_to root_path
    end
    #if @item.sold?
    #  redirect_to root_path, alert: '売却済みの商品の情報は編集できません。'
    #end
  end

end
