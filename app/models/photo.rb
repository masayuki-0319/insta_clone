class Photo < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :picture, presence: true
  validates :title, length: { maximum: 50 }
end
