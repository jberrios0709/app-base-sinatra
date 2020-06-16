class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :cellphone
      t.belongs_to :user

      t.timestamps
    end

    add_index(:profiles, :user_id, unique: true, name: 'index_user_profile_unique')
  end
end
