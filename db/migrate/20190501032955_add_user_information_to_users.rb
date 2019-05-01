class AddUserInformationToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :website, :string, null: true
    add_column :users, :introduction, :string, null: true
    add_column :users, :tel, :integer, null: true
    add_column :users, :sex, :integer, null: true, default: 0
  end
end
