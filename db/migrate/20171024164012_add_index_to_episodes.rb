class AddIndexToEpisodes < ActiveRecord::Migration[5.1]
  def change
    add_index :episodes, :petitioner_id
    add_index :episodes, :respondent_id
  end
end
