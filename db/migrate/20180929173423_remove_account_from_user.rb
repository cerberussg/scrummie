class RemoveAccountFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :account, :string
  end
end
