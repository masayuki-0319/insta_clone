class Photo < ApplicationRecord
  belongs_to :user
  has_many :photo_likes, dependent: :destroy
  has_many :photo_comments, dependent: :destroy
  has_many :users, through: :photo_likes
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :picture, presence: true
  validate  :picture_size

  def liking?(liker)
    !photo_likes.find_by(liker_id: liker.id).nil?
  end

  private

    #アップロードされた写真容量の検証
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
