class Email < ApplicationRecord
	belongs_to :sender,class_name: :user, foreign_key: :from
	belongs_to :recipient, class_name: :user, foreign_key: :to,
end
