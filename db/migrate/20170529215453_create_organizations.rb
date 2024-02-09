# frozen_string_literal: true

class CreateOrganizations < ActiveRecord::Migration[4.2]
  def change
    create_table :organizations do |t|
      t.string :name, null: false
      t.text :description
      t.string :picture
    end
  end
end
