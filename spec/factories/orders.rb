FactoryBot.define do
  factory :order_form, class: OrderForm do
    postal_code   { "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 4)}" }
    prefecture_id { Faker::Number.between(from: 2, to: 48) } # 1(---)以外を選択
    city          { Faker::Address.city }
    address       { Faker::Address.street_address }
    building_name { Faker::Address.secondary_address }
    phone_number  { Faker::Number.decimal_part(digits: 11) } # 11桁の数値を生成
    token         { "tok_#{Faker::Alphanumeric.alphanumeric(number: 28)}" }
  end
end
