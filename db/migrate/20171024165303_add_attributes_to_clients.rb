class AddAttributesToClients < ActiveRecord::Migration[5.1]
  def change
    add_column :clients, :firstname, :string
    add_column :clients, :lastname, :string
  end
end
