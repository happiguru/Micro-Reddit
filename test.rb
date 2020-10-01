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
class Lessons < ApplicationRecord
  validates :title, presence: true, length: { in: 4..12 }
  validates :body, presence: true, length: { in: 20..100 }

  belongs_to :courses
end

class Courses < ApplicationRecord
  validates :title, presence: true, length: { in: 4..12 }
  validates :description, presence: true, length: { in: 20..100 }

  has_many :lessons
end

# profile Model
class UserProfile < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :age
  validates :gender, presence: true
  add_reference :user_profile, :city, index: true 
  add_foreign_key :user_profile, :city
  add_reference :user_profile, :state, index: true 
  add_foreign_key :user_profile, :state
  add_reference :user_profile, :country, index: true 
  add_foreign_key :user_profile, :country
  has_many :city
  has_many :state 
  has_one :country
end

class City < ApplicationRecord
  validates :city_name, presence: true
  belongs_to :state 
  belons_to :country
end

class State < ApplicationRecord
  validates :state_name, presence: true
  belongs_to :country
  has_many :city
end

class Country < ApplicationRecord
  validates :country_name, presence: true, uniqueness: true
  has_many :state
  has_many :city
end

# virtual_pinboard Model
class User < ApplicationRecord
  validates :username, presence: true, length: { in: 4..12 }
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { in: 4..16 }

  has_many :pin
  has_many :comment
end

class Comment < ApplicationRecord
  validates :comment_body, presence: true

  belongs_to :pin 
  belongs_to :user
end

class Pin < ApplicationRecord
  validates :pin_body, presence: true
  validates :pin_url, presence: true

  belongs_to :user 
  has_many :comment
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

# profile Migration 
class CreateUserProfile < ActiveRecord::Migration[5.2]
  def change
    create_table :user_profile do |t|
      t.string :username
      t.string :email
      t.int :age
      t.string :gender 
      t.references :city, foreign_key: true
      t.references :state, foreign_key: true
      t.references :country, foreign_key: true
      t.timestamps
    end
  end
end

class CreateCity < ActiveRecord::Migration[5.2]
  def change
    create_table :city do |t|
      t.string :city_name
      t.timestamps
    end
  end
end

class CreateState < ActiveRecord::Migration[5.2]
  def change
    create_table :state do |t|
      t.string :state_name
      t.timestamps
    end
  end
end

class CreateCountry < ActiveRecord::Migration[5.2]
  def change
    create_table :country do |t|
      t.string :country_name
      t.timestamps
    end
  end
end

# virtual_pinboard Migration 
class CreateUser < ActiveRecord::Migration[5.2]
  def change
    create_table :user do |t|
      t.string :username
      t.string :email
      t.string :password
      t.timestamps
    end
  end
end


class CreateComment < ActiveRecord::Migration[5.2]
  def change
    create_table :comment do |t|
      t.string :comment_body
      t.timestamps
    end
  end
end


class CreatePin < ActiveRecord::Migration[5.2]
  def change
    create_table :pin do |t|
      t.string :pin_body 
      t.string :pin_url
      t.timestamps
    end
  end
end
