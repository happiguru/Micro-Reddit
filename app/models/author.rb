class Author < ApplicationRecord
    validates: username, uniqueness: true, presence: true, length: { in: 4..12 }
    validates: email, uniqueness: true, presence: true
    validates: password, presence: true, length: { in: 4..16 }

    has_many :post
end
