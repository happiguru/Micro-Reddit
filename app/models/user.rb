class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true, length: ( 8..16 )

  has_many :posts
  has_many :comments
end
