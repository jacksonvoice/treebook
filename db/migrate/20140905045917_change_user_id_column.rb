class ChangeUserIdColumn < ActiveRecord::Migration
  def change
  	remove_column :statuses, :user_id
  	add_column :statuses, :user, :integer
  end
end
