class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.datetime :publication_date
      t.boolean :active
      t.integer :user_id
      t.integer :competition_id

      t.timestamps
    end
  end
end
