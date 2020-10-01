class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :comment_body
      t.references :posts, foreign_key: true

      t.timestamps
    end
  end
end
