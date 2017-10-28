class AddAddtlAttributesToClients < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'hstore' unless extension_enabled?('hstore')

    add_column :clients, :dob, :date
    add_column :clients, :telephone, :string
    add_column :clients, :address, :hstore
    add_column :clients, :children, :integer
    add_column :clients, :gender, :string
    add_column :clients, :email, :string
    add_column :clients, :special_population, :string
    add_column :clients, :ethnicity, :string
    add_column :clients, :language, :string
  end
end
