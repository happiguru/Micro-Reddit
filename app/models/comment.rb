class Comment < ApplicationRecord
  validates :description

  belongs_to :post
end
