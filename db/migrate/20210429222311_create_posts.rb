class CreatePosts < ActiveRecord::Migration[6.1]
  def up
    create_table :posts do |t|
      t.text :body
      t.references :shark, null: false, foreign_key: true

      t.timestamps
    end
  end
  def down
    drop_table :posts
  end
end
