# frozen_string_literal: true

class AddScheduleChangesToCallForPapers < ActiveRecord::Migration[4.2]
  def change
    add_column :call_for_papers, :schedule_changes, :boolean, default: 0
  end
end
