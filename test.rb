class Authors < ApplicationRecord
    validates: username, uniqueness: true, presence: true, length: { in: 4..12 }
    validates: email, uniqueness: true, presence: true
    validates: password, presence: true, length: { in: 4..16 }

    has_many :posts
end

class Post < ApplicationRecord
    validates: title, presence: true, uniqueness: true
    validates: body, presence: true
    add_reference: authors

    belongs_to :authors
end
