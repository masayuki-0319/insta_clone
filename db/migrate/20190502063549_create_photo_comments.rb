class CreatePhotoComments < ActiveRecord::Migration[5.2]
  def change
    create_table :photo_comments do |t|
      t.text :comment
      t.integer :commenter_id
      t.references :photo, foreign_key: true

      t.timestamps
    end
  end
end
