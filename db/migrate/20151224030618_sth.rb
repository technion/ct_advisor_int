class Sth < ActiveRecord::Migration
  def change
    create_table :sth do |t|
      t.integer :latest
    end
  end
end
