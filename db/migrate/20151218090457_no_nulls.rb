class NoNulls < ActiveRecord::Migration
  def change
    add_index :registrations, :domain
    change_column_null :registrations, :email, false
    change_column_null :registrations, :domain, false
  end
end
