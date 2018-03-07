class CreateContactsServicesJoinTable < ActiveRecord::Migration[5.1]
  def change
    create_join_table :contacts, :services do |t|
      t.index :contact_id
      t.index :service_id
    end
  end
end
