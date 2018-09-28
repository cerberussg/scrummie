class AddHashIdAndTimeZoneToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :hash_id, :string
    add_index :users, :hash_id
    add_column :users, :time_zone, :string
  end
end
