class AddAccountIdToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :account_id, :string
  end
end
