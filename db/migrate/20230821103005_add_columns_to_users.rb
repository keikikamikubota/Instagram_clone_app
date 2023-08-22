class AddColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :users_image, :text
  end
end
