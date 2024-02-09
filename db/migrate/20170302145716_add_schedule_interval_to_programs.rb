# frozen_string_literal: true

class AddScheduleIntervalToPrograms < ActiveRecord::Migration[4.2]
  def change
    add_column :programs, :schedule_interval, :integer, default: 15, null: false
  end
end
