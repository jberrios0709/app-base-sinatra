class AddActiveUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :active, :boolean
    change_column_default :users, :active, false
  end
end
