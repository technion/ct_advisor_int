class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.string :email
      t.string :domain
      t.string :nonce
      t.integer :active

      t.timestamps null: false
    end
  end
end
