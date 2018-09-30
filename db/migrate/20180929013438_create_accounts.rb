class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :addr1
      t.string :addr2
      t.string :city
      t.string :state
      t.string :zip
      t.string :country
      t.string :hash_id
      t.jsonb :settings, null: false, default: '{}'

      t.timestamps
    end
    add_index :accounts, :hash_id
    add_index :accounts, :settings, using: :gin
  end
end
