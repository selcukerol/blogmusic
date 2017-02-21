# our system users
class User < ActiveRecord::Base
<<<<<<< HEAD
  
end

class Post < ActiveRecord::Base
end
=======
validates_uniqueness_of :username
validates_uniqueness_of :email
has_many :posts	

end

# our blog system
class Post < ActiveRecord::Base
belongs_to :user

end	
>>>>>>> 8a41cdf0616d1b4eabdef4a1b32c29bd6cd67028
