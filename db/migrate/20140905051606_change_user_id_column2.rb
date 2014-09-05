class ChangeUserIdColumn2 < ActiveRecord::Migration
  def change
  	remove_column :statuses, :user
  	add_column :statuses, :user_id, :integer
  end
end
