class CreateDaysOfTheWeekMemberships < ActiveRecord::Migration[5.2]
  def change
    create_table :days_of_the_week_memberships do |t|
      t.references :team, foreign_key: true
      t.integer :day
    end
  end
end
