class CreateSharks < ActiveRecord::Migration[6.1]
  def change
    create_table :sharks do |t|
      t.string :name
      t.text :facts

      t.timestamps
    end
  end
end
