class CreateInstruments < ActiveRecord::Migration[6.1]
  def change
    create_table :instruments do |t|
      t.string :title
      t.string :token
      t.integer :count

      t.timestamps
    end
  end
end
