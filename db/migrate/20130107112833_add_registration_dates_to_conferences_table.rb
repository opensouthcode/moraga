# frozen_string_literal: true

class AddRegistrationDatesToConferencesTable < ActiveRecord::Migration[4.2]
  def change
    add_column :conferences, :registration_start_date, :date
    add_column :conferences, :registration_end_date, :date
  end
end
