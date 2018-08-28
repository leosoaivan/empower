class CreateFollowUps < ActiveRecord::Migration[5.2]
  def change
    create_table :follow_ups do |t|
      t.datetime :due_by
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
