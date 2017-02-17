# our system users
class User < ActiveRecord::Base
validates_uniqueness_of :username
validates_uniqueness_of :email	

end

# our blog system
class Post < ActiveRecord::Base

end	