class User < ActiveRecord::Base
  has_many :posts
  has_many :comments

  validates :email, uniqueness: true
  validates :email, presence: true

  validates :username, uniqueness: true
  validates :username, presence: true
  validates :password, presence: true

end
