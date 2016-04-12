class AddDefaultValueToUsersAvatar < ActiveRecord::Migration
  def change
    change_column_default :users, :avatar, 'alien.jpg'
  end
end
