class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :header, null: false
      t.integer :views, default: 0
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
