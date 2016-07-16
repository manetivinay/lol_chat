class CreateFriendships < ActiveRecord::Migration[5.0]
  def change

    if table_exists?("friendships")
      drop_table  :friendships
    end

    create_table :friendships do |t|
      t.integer :user_id
      t.integer :friend_id

      t.timestamps
    end
  end
end
