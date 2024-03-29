# frozen_string_literal: true

class AddIndexToEventSchedule < ActiveRecord::Migration[4.2]
  def change
    add_index :event_schedules, [:event_id, :schedule_id], unique: true
  end
end
