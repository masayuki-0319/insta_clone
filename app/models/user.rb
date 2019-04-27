class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable
  # :omniauthable, :omniauth_providers[:facebook]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :photos, dependent: :destroy
  has_many :active_user_relationships, class_name: "UserRelationship",
                                       foreign_key: "follower_id",
                                       dependent: :destroy
  has_many :following, through: :active_user_relationships, source: :followed
  has_many :passive_user_relationships, class_name: "UserRelationship",
                                        foreign_key: "followed_id",
                                        dependent: :destroy
  has_many :followers, through: :passive_user_relationships, source: :follower
  before_save { self.email = email.downcase }
  validates :user_name, presence: true, length: { in: 3..50}
  validates :pen_name, presence: true, length: { in: 3..50}
  validates :email, uniqueness: { case_sensitive: false }

  def feed
    Photo.where("user_id = ?", id)
  end

  #ユーザーをフォロー
  def follow(other_user)
    following << other_user
  end

  #ユーザーをフォロー解除
  def unfollow(other_user)
    active_user_relationships.find_by(followed_id: other_user.id).destroy
  end

  #現在ユーザーがフォローしている場合，True
  def following?(other_user)
    following.include?(other_user)
  end
end
