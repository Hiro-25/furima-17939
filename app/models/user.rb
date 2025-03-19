class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: { message: I18n.t('errors.messages.blank') }
  validates :nickname, presence: true
  validates :email, presence: true, uniqueness: { message: I18n.t('errors.messages.taken') }

  validates :password, presence: true, length: { minimum: 6, message: I18n.t('errors.messages.too_short', count: 6) },
                       format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/, message: 'is invalid. Include both letters and numbers' }

  validates :last_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'is invalid. Input full-width characters' }
  validates :first_name, presence: true,
                         format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'is invalid. Input full-width characters' }

  validates :last_name_kana, presence: true,
                             format: { with: /\A[ァ-ヶー]+\z/, message: 'is invalid. Input full-width katakana characters' }
  validates :first_name_kana, presence: true,
                              format: { with: /\A[ァ-ヶー]+\z/, message: 'is invalid. Input full-width katakana characters' }

  validates :birthday, presence: { message: "can't be blank" }
end
