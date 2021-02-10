class AddForeignKeysToFriendRequests < ActiveRecord::Migration[6.1]
  def change
    change_table :friend_requests do |t|
      t.references :sender, null: false, foreign_key: { to_table: :users }
      t.references :recipient, null: false, foreign_key: { to_table: :users }
    end
  end
end
