class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password, format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/, message: 'は半角英数字混合で入力してください' }
  validates :password_confirmation, presence: true
  validate :password_match
  validates :family_name, presence: true, format: { with: /\A[一-龥ぁ-んー-龥]+\z/, message: 'は全角で入力してください' }
  validates :first_name, presence: true, format: { with: /\A[一-龥ぁ-んー-龥]+\z/, message: 'は全角で入力してください' }
  validates :family_name_kana, presence: true, format: { with: /\A[ァ-ヶー]+\z/, message: 'は全角カタカナで入力してください' }
  validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー]+\z/, message: 'は全角カタカナで入力してください' }
  validates :birthday, presence: true

  private

  def password_match
    errors.add(:password_confirmation, 'が一致しません') if password != password_confirmation
  end
end
