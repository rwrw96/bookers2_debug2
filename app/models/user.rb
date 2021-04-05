class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites
  has_many :book_comments, dependent: :destroy
  
  has_many :active_relationships, class_name: "Relationship", foreign_key: :followed_id, dependent: :destroy
  has_many :followeds, through: :active_relationships, source: :follower
  
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :followed
  
  attachment :profile_image, destroy: false

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: {maximum: 50}
  validates :postal_code, presence: true
  validates :prefecture_code, presence: true
  validates :city, presence: true
  validates :street, presence: true
  
  def followed_by?(user)
    passive_relationships.find_by(followed_id: user.id).present?
  end
  
  def favorited_by?(user)
	 favorites.where(user_id: user.id).exists?
  end
  
end
