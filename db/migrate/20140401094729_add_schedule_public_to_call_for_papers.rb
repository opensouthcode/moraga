# frozen_string_literal: true

class AddSchedulePublicToCallForPapers < ActiveRecord::Migration[4.2]
  def change
    add_column :call_for_papers, :schedule_public, :boolean
  end
end
