class OrderAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :house_number, :building_name,
                :phone_number, :item_id, :user_id, :token

  with_options presence: true do
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'は「3桁-4桁」の形式で入力してください' }
    validates :prefecture_id, numericality: { other_than: 1, message: 'を選択してください' }
    validates :city, :house_number, :phone_number, :token, :user_id, :item_id
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'は10桁または11桁の数字で入力してください' }
  end

  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city,
                   house_number: house_number, building_name: building_name,
                   phone_number: phone_number, order_id: order.id)
  end
end
