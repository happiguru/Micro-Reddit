# Exercise 1
=begin
  You are building an online learning platform (much like this!). 
  You’ve got many different courses, each with a title and description, 
  and each course has multiple lessons. Lesson content consists of a title 
  and body text.
=end
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
#######################################################################
# Exercise 2
=begin
  You are building the profile tab for a new user on your site. 
  You are already storing your user’s username and email, but now you want 
  to collect demographic information like city, state, country, age and gender. 
  Think – how many profiles should a user have? How would you relate 
  this to the User model?
=end
# user_profile Model
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

# user_profile Migration 
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
#######################################################################
# Exercise 3
=begin
  You want to build a virtual pinboard, so you’ll have users on your platform 
  who can create “pins”. Each pin will contain the URL to an image on the web. 
  Users can comment on pins (but can’t comment on comments).
=end
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

# virtual_pinboard Migration 
class CreateUser < ActiveRecord::Migration[5.2]
  def change
    create_table :user do |t|
      t.string :username
      t.string :email
      t.string :password
      t.references :pin, foreign_key: true
      t.references :comment, foreign_key: true
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
      t.references :comment, foreign_key: true
      t.timestamps
    end
  end
end
#######################################################################
# Exercise 4
=begin
  You want to build a message board like Hacker News. Users can post links. 
  Other users can comment on these submissions or comment on the comments. 
  How would you make sure a comment knows where in the hierarchy it lives?
=end
# hacker_news Model 
class User < ApplicationRecord
  validates :username, presence: true, length: { in: 4..12 }
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { in: 4..16 }

  has_many :comment
  has_many :link
  has_many :tcomment
end

class Link < ApplicationRecord
  validates :link_body, presence: true
  validates :link_url, presence: true

  belongs_to :user 
  has_many :comment
end

class Comment < ApplicationRecord
  validates :comment_body, presence: true

  belongs_to :user 
  has_many :tcomment
end

class Tcomment < ApplicationRecord
  validates :tcomment_body, presence: true

  belongs_to :comment 
  belongs_to :user
end

# hacker_news Migration 
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

class CreateLink < ActiveRecord::Migration[5.2]
  def change
    create_table :link do |t|
      t.string :link_body 
      t.string :link_url
      t.references :user_id, foreign_key: true
      t.timestamps
    end
  end
end

class CreateComment < ActiveRecord::Migration[5.2]
  def change
    create_table :comment do |t|
      t.string :comment_body 
      t.references :link, foreign_key: true
      t.references :user_id, foreign_key: true
      t.timestamps
    end
  end
end

class CreateTcomment < ActiveRecord::Migration[5.2]
  def change
    create_table :tcomment do |t|
      t.string :tcomment_body 
      t.references :comment, foreign_key: true
      t.references :user_id, foreign_key: true
      t.timestamps
    end
  end
end
#######################################################################
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



user

id:
username:string
has_many: posts
has_many: comments

posts
id:
post_title:string
post_body: text
belongs_to: user
has_many: comments
references user(fk=user_id)
references comment(fk-comment_id)

comment

id:
comment_body: text
belongs_to: posts




