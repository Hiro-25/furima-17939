class Item < ApplicationRecord
  belongs_to :user
  # has_one :order
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :shipping_days

  # 商品名・説明
  validates :name, presence: { message: 'を入力してください' }
  validates :description, presence: { message: 'を入力してください' }

  # ActiveHash のデータが `---` (id: 1) の場合を禁止
  validates :category_id, numericality: { other_than: 1, message: 'を選択してください' }, allow_blank: true
  validates :condition_id, numericality: { other_than: 1, message: 'を選択してください' }, allow_blank: true
  validates :shipping_fee_id, numericality: { other_than: 1, message: 'を選択してください' }, allow_blank: true
  validates :prefecture_id, numericality: { other_than: 1, message: 'を選択してください' }, allow_blank: true
  validates :shipping_days_id, numericality: { other_than: 1, message: 'を選択してください' }, allow_blank: true

  # 価格のバリデーション
  validates :price, presence: { message: 'を入力してください' },
                    numericality: {
                      only_integer: true,
                      greater_than_or_equal_to: 300,
                      less_than_or_equal_to: 9_999_999,
                      message: 'は¥300〜¥9,999,999の範囲で入力してください'
                    }

  # 画像のバリデーション
  validate :image_presence

  private

  def image_presence
    errors.add(:image, 'を添付してください') unless image.attached?
  end
end
