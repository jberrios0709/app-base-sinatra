class CreateRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :roles do |t|
      t.string :name
      t.integer :active

      t.timestamps
    end

    add_index(:roles, :name, unique: true, name: 'index_rola_name_unique')
  end
end
