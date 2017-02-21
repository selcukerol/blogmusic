class CreateUsersTable < ActiveRecord::Migration[5.0]
  	def change
    create_table :users do |t|
      t.string :fname
      t.string :lname
      t.string :email
<<<<<<< HEAD
=======
      t.string :username
>>>>>>> 8a41cdf0616d1b4eabdef4a1b32c29bd6cd67028
      t.string :password
    end
  end
end
