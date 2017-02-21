class User < ApplicationRecord
	has_many :emails_sent, class_name: :Email, foreign_key: :from
	has_many: :email_recieved, 
end
