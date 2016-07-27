class Topic < ApplicationRecord
  belongs_to :user
  has_many :conversations, dependent: :destroy
  has_many :posts, through: :conversations
end
