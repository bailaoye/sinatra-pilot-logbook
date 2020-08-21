class User < ActiveRecord::Base
  has_secure_password
  has_many :logbooks
  validates :name, uniqueness: true

end