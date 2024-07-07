class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :delivery_charge
  belongs_to_active_hash :shipping_source
  belongs_to_active_hash :date_of_shipment

  belongs_to :user
  has_one_attached :image
  has_one :purchase

  validates :product_name, presence: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }
  validates :category_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :condition_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :delivery_charge_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :shipping_source_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :date_of_shipment_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :explanation, presence: true
  validates :image, presence: true

  # def sold?
    # order.present?
  # end

end
