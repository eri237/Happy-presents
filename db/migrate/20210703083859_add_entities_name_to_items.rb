class AddEntitiesNameToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :entities_name, :string
  end
end
