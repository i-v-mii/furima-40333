class PurchaseDestination
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :post_code, :shipping_source_id, :municipality, :street_address, :building_name, :tel,  :token

  with_options presence: true do
    validates :user_id, presence: true
    validates :item_id, presence: true
    validates :post_code, format: { with: /\A\d{3}-\d{4}\z/, message: "should be in the format 123-4567" }
    validates :shipping_source_id, numericality: { other_than: 1 , message: "can't be blank"}
    validates :municipality
    validates :street_address
    validates :tel, format: { with: /\A\d{10,11}\z/, message: "should be 10 or 11 digit numbers" }
    validates :token, presence: true
  
  end
  validates :shipping_source_id, numericality: { only_integer: true }

  def save
    if valid?
      purchase = Purchase.create(user_id: user_id, item_id: item_id)
      destination = Destination.create(post_code: post_code,
                                    shipping_source_id: shipping_source_id,
                                    municipality: municipality,
                                    street_address: street_address,
                                    building_name: building_name,
                                    tel: tel,
                                    purchase_id: purchase.id)
      true
    else
      false
    end
  end

  def user=(user)
    @user_id = user.id
  end

  def shipping_sources
    ShippingSource.all
  end
end