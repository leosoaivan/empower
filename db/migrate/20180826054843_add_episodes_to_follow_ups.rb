class AddEpisodesToFollowUps < ActiveRecord::Migration[5.2]
  def change
    add_reference :follow_ups, :episode, foreign_key: true
  end
end
