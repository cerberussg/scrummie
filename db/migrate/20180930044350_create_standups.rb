class CreateStandups < ActiveRecord::Migration[5.2]
  def change
    create_table :standups do |t|
      t.references :user, foreign_key: true
      t.date :standup_date
      t.string :hash_id

      t.timestamps
    end
  end
end
