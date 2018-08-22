class RenameAttributesOnClient < ActiveRecord::Migration[5.2]
  def change
    change_table :clients do |t|
      t.rename :firstname, :first_name
      t.rename :lastname, :last_name
    end
  end
end
