class PurchaseDestination
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :post_code, :shipping_source_id, :municipality, :street_address, :building_name, :tel, :token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :post_code, format: { with: /\A\d{3}-\d{4}\z/, message: "should include a hyphen in the correct format" }
    validates :municipality
    validates :street_address
    validates :tel, format: { with: /\A\d{10,11}\z/, message: "should be 10 or 11 digit numbers" }
    validates :token
  end
  validates :shipping_source_id, numericality: { only_integer: true }

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Destination.create(
      post_code: post_code,
      shipping_source_id: shipping_source_id,
      municipality: municipality,
      street_address: street_address,
      building_name: building_name,
      tel: tel,
      purchase_id: purchase.id
    )
  end
end