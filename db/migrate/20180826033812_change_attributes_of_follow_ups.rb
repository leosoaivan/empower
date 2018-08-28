class ChangeAttributesOfFollowUps < ActiveRecord::Migration[5.2]
  def change
    rename_column :follow_ups, :due_by, :due_by_date
    add_column    :follow_ups, :due_by_timeframe, :integer
  end
end
