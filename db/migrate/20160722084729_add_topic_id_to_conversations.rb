class AddTopicIdToConversations < ActiveRecord::Migration[5.0]
  def change
    add_column :conversations, :topic_id, :integer
  end
end
