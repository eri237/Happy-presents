class AddMetadataToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :metadata, :string
  end
end
