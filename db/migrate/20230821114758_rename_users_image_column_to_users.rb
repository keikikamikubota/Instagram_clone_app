class RenameUsersImageColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :users_image, :user_image
  end
end
