class CreateEmails < ActiveRecord::Migration[5.0]
  def change
    create_table :emails do |t|
      t.string :subject
      t.integer :to
      t.integer :from
      t.string :body

      t.timestamps
    end
  end
end
