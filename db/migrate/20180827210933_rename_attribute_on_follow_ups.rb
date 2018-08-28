class RenameAttributeOnFollowUps < ActiveRecord::Migration[5.2]
  def change
    rename_column :follow_ups, :due_by_timeframe, :due_by_shift
  end
end
