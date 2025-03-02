class AddBlueSkyToContacts < ActiveRecord::Migration[7.0]
  def change
    add_column :contacts, :bluesky, :string
  end
end
