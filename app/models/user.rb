class User < ApplicationRecord
    validates :username, presence: true, length: ( 5..16 )

    has_many :posts
end
