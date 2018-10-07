class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :name
      t.references :account, foreign_key: true
      t.string :timezone
      t.boolean :has_reminder
      t.boolean :has_recap
      t.string :hash_id
      t.time :reminder_time
      t.time :recap_time

      t.timestamps
    end
    add_index :teams, :hash_id
    add_index :teams, [:has_reminder, :reminder_time]
    add_index :teams, [:has_recap, :recap_time]
  end
end
