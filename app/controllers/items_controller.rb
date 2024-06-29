class ItemsController < ApplicationController

  def index
    @items = Item.all
  end

  def new
    @item = Item.all
  end

  private

  def item_params
    params.require(:message).permit(:content, :image).merge(user_id: current_user.id)
  end

end
