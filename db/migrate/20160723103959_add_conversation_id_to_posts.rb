class AddConversationIdToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :conversation_id, :integer
  end
end
