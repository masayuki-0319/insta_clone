class PhotoLike < ApplicationRecord
  belongs_to :photo
  belongs_to :liker, class_name: "User"
end
