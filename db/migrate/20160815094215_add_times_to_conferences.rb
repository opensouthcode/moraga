# frozen_string_literal: true

class AddTimesToConferences < ActiveRecord::Migration[4.2]
  def change
    add_column :conferences, :start_hour, :integer, default: 9
    add_column :conferences, :end_hour, :integer, default: 20
  end
end
