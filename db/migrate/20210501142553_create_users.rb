class CreateUsers < ActiveRecord::Migration[6.1]
  def up
    create_table :users do |t|
      t.string :name
      t.string :email

      t.timestamps
      # add_index(:profiles, :user_id, :unique => true)
    end
  end

  def down
	drop_table :users
  end
end
