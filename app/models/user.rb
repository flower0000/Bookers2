class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #_idは付けない
  attachment :profile_image

  has_many :books, dependent: :destroy

  validates :name, presence: true, uniqueness: true, length:{ minimum: 2, maximum: 20 }#空ではないこと,他と被りがないこと（一意性）,2文字以上20文字以内であることのバリデーション
  validates :introduction, length:{ maximum: 50 }#空ではないこと,50文字以内であることのバリデーション
end
