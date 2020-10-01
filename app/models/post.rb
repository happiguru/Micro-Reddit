class Post < ApplicationRecord
  validates :post_title, presence: true
  validates :post_body, presence: true 

  belongs_to :users
  has_many :comments
end
