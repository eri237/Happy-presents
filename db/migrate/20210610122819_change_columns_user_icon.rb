class ChangeColumnsUserIcon < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :icon, :icon_id
    rename_column :items, :image, :image_id
  end
end
