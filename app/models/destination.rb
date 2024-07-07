class Destination < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :shipping_source

  belongs_to :purchase

  validates :post_code, presence: true, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
  validates :shipping_source_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :municipality, presence: true
  validates :street_address, presence: true
  validates :tel, presence: true, format: { with: /\A\d{10,11}\z/, message: "should be 10 or 11 digit numbers" }

end
