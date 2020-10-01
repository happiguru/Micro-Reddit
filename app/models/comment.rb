class Comment < ApplicationRecord
  validates :comment_body, presence: true, length: ( 10..100 )

  belongs_to :post
  belongs_to :user
end
