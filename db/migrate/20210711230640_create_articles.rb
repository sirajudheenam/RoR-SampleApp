class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.string :author_id
      t.string :magazine_id

      t.timestamps
    end
  end
end
