class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :avatar
      t.date :birthday
      t.string :country
      t.string :city
      t.string :address

      t.timestamps null: false
    end
  end
end
