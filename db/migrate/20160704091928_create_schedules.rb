# frozen_string_literal: true

class CreateSchedules < ActiveRecord::Migration[4.2]
  def change
    create_table :schedules do |t|
      t.belongs_to :program, index: true
      t.timestamps null: false
    end
    add_reference :programs, :selected_schedule, index: true
  end
end
