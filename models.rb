# our system users
class User < ActiveRecord::Base
validates_uniqueness_of :username
validates_uniqueness_of :email
has_many :posts	

end

# our blog system
class Post < ActiveRecord::Base
belongs_to :user

end	