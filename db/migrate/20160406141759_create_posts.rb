class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :body, null: false
      t.integer :votes, default: 0
      t.references :postable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
