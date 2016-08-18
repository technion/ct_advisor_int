class Sth < ActiveRecord::Migration[4.2]
  def change
    create_table :sth do |t|
      t.integer :latest
    end
  end
end
