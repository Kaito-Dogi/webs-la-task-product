require 'bundler/setup'
Bundler.require

ActiveRecord::Base.establish_connection

class User < ActiveRecord::Base
    has_secure_password
    
    has_many :posts
    has_many :favorites
    has_many :favorite_posts, through: :favorites, source: :posts
end

class Post < ActiveRecord::Base
    belongs_to :user
    
    has_many :favorites
    has_many :favorite_users, through: :favorites, source: :users
end

class Favorite < ActiveRecord::Base
    belongs_to :user
    belongs_to :post
end