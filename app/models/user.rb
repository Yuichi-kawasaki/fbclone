class User < ApplicationRecord
  attr_accessor:remember_token

  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :birthday,  presence: true
  validates :gender, presence: true
  before_validation { email.downcase! }
  has_secure_password
  validates :password, presence: true, length: { minimum: 8 }, on: :create
  has_many :pictures, dependent: :destroy
  has_many :active_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
  has_many :passive_relationships, foreign_key: 'followed_id', class_name: 'Relationship', dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  mount_uploader :image, IconUploader

  def follow!(other_user)
    active_relationships.create!(followed_id: other_user.id)
  end

  def following?(other_user)
    active_relationships.find_by(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def User.digest(string)
   cost = ActiveModel::SecurePassword.min_cost ? Bcrypt::Engine::MIN_COST :
                                                BCrypt::Engine.cost
   BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
   SecureRandom::urlsafe_base64
  end

  def remember
   self.remember_token = User.new_token
   update_attribute(:remember_digest,User.digest(remember_token))
  end
end
