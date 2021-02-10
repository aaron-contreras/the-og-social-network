class CreateFriendRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :friend_requests do |t|
      t.boolean :accepted, default: false

      t.timestamps
    end
  end
end
