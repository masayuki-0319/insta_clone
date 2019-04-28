class CreatePhotoLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :photo_likes do |t|
      t.integer :liker_id
      t.references :photo, foreign_key: true

      t.timestamps
    end
    add_index :photo_likes, [:liker_id, :photo_id], unique: true
  end
end
