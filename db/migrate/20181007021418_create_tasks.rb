class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :type
      t.string :title
      t.boolean :is_completed

      t.timestamps
    end
  end
end
