class CreateEpisodes < ActiveRecord::Migration[5.1]
  def change
    create_table :episodes do |t|
      t.integer :petitioner_id
      t.integer :respondent_id

      t.timestamps
    end
  end
end
