class AddRelationshipToEpisodes < ActiveRecord::Migration[5.1]
  def change
    add_column :episodes, :relationship, :string
    add_column :episodes, :victimization, :string
    add_column :episodes, :arrest, :boolean
    add_column :episodes, :open, :boolean, default: true
  end
end
