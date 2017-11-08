class ChangeRelationshipTypeOnEpisodes < ActiveRecord::Migration[5.1]
  def change
    change_column :episodes, :relationship, "varchar[] USING (string_to_array(relationship, ','))"
    change_column :episodes, :victimization, "varchar[] USING (string_to_array(victimization, ','))"
  end
end
