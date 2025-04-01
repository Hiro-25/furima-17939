class OrderAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :address, :building, :phone_number, :item_id, :user_id, :token

  with_options presence: true do
    validates :postal_code
    validates :prefecture_id
    validates :city
    validates :address
    validates :phone_number
    validates :user_id
    validates :item_id
    # validates :token
  end

  # 郵便番号の形式：123-4567
  validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid' }

  # 都道府県が「---」(id: 1)以外を選んでいるか
  validates :prefecture_id, numericality: { other_than: 1, message: 'must be other than 1' }

  # 電話番号は10〜11桁の数字（ハイフンなし）
  validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'is invalid' }

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      city: city,
      address: address,
      building: building,
      phone_number: phone_number,
      order_id: order.id
    )
  end
end
