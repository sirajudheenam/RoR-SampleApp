class CreateProfiles < ActiveRecord::Migration[6.1]
  def up
    create_table :profiles do |t|
      t.integer :user_id
      t.string :gender
      t.integer :age
      t.date :date_of_birth
      t.string :city
      t.string :country
      t.boolean :subscribe

      t.timestamps

    end
    def down
      drop_table :profiles
    end
  end
end
