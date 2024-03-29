# frozen_string_literal: true

class CreateRolesTable < ActiveRecord::Migration[4.2]
  def self.up
    create_table :roles do |t|
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :roles
  end
end
