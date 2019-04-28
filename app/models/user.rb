class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable
  # :omniauthable, :omniauth_providers[:facebook]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :photos, dependent: :destroy
  has_many :photo_likes, class_name: "PhotoLike",
                         foreign_key: "liker_id" ,
                         dependent: :destroy
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

  # フォロー対象のFeedを返す
  def feed
    following_ids = "SELECT followed_id FROM user_relationships
                     WHERE follower_id = :user_id"
    Photo.where("user_id IN (#{following_ids})", user_id: id)
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

  #写真いいね！
  def like(photo)
    photo_likes.create(photo_id: photo.id)
  end

  #写真いいね！解除
  def unlike(photo)
    photo_likes.find_by(photo_id: photo.id).destroy
  end

  #課題：もっと良い演算子があるか？
  #いいね！している場合，True
  def liking?(photo)
    !photo_likes.find_by(photo_id: photo.id).nil?
  end
end
