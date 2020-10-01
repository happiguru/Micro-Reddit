class Post < ApplicationRecord
  validates :post_title, presence: true
  validates :post_body, presence: true 

  belongs_to :user
  has_many :comments
end
