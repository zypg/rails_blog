class Conversation < ApplicationRecord
  belongs_to :user
  belongs_to :topic
  has_many :posts
end
