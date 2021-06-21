class AddAgeWantToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :age_want, :integer
  end
end
