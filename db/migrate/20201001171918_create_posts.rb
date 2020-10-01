class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :post_title
      t.text :post_body
      t.references :users, foreign_key: true 

      t.timestamps
    end
  end
end
