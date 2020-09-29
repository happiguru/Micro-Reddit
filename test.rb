# micro_reddit Model
class Post < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :body, presence: true

  belongs_to :author
end

class Author < ApplicationRecord
  validates :username, uniqueness: true, presence: true, length: { in: 4..12 }
  validates :email, uniqueness: true, presence: true
  validates :password, presence: true, length: { in: 4..16 }

  has_many :post
end
# online_learning_platform Model
class lessons < ApplicationRecord
  validates :title, presence: true, length: { in: 4..12 }
  validates :body, presence: true, length: { in: 20..100 }

  belongs_to :courses
end

class Courses < ApplicationRecord
  validates :title, presence: true, length: { in: 4..12 }
  validates :description, presence: true, length: { in: 20..100 }

  has_many :lessons
end

# This is the migration code for the models.
# micro_reddit Migration
class CreateAuthors < ActiveRecord::Migration[5.2]
  def change
    create_table :authors do |t|
      t.string :username
      t.string :email
      t.string :password
      t.timestamps
    end
  end
end
# online_learning_platform Migration
class CreateLessons < ActiveRecord::Migration[5.2]
  def change
    create_table :lessons do |t|
      t.string :title
      t.string :body
      t.timestamps
    end
  end
end

class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :title
      t.string :description
      t.references :lessons, foreign_key: true
      t.timestamps
    end
  end
end

