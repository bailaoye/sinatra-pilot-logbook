class User < ActiveRecord::Base
  has_secure_password
  has_many :logs
  validates :username, uniqueness: true
  validates_presence_of :username
  validates_presence_of :fullname

  def slug
    self.username.gsub(" ", "-").downcase
  end

  def self.find_by_slug(slug)
    self.all.find{|i| i.slug == slug}
  end
  
end