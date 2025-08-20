class ShippingInformation < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :order
  belongs_to :prefecture

  # `belongs_to :order`により、orderの存在は自動的に検証されます。
  # READMEの`null:false`制約に基づき、他の必須項目にもバリデーションを追加します。
  with_options presence: true do
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :city
    validates :address
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'is invalid. Input only numbers' }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
  end
end
