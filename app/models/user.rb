class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validate :password_complexity

  validates :nickname, presence: true
  validates :birth_date, presence: true

  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'is invalid. Input full-width characters' } do
    validates :last_name
    validates :first_name
  end

  with_options presence: true, format: { with: /\A[ァ-ヶー]+\z/, message: 'is invalid. Input full-width katakana characters' } do
    validates :last_name_kana
    validates :first_name_kana
  end

  private

  def password_complexity
    return if password.blank? || password.match?(/\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i)

    errors.add(:password, 'must include both letters and numbers')
  end
end
