class CreateTokenActions < ActiveRecord::Migration[6.0]
  def change
    create_table :token_actions do |t|
      t.string :token
      t.string :action
      t.belongs_to :user

      t.timestamps
    end

    add_index(:token_actions, :token, unique: true)
  end
end
