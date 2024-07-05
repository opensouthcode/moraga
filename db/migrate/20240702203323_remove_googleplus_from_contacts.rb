class RemoveGoogleplusFromContacts < ActiveRecord::Migration[7.0]
  def change
    remove_column :contacts, :googleplus, :string
  end
end
