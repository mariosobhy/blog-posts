class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :body
      t.references :author, { to_table: :users }

      t.timestamps
    end
  end
end
