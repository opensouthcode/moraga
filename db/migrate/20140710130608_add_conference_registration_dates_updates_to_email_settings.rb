# frozen_string_literal: true

class AddConferenceRegistrationDatesUpdatesToEmailSettings < ActiveRecord::Migration[4.2]
  def change
    add_column :email_settings, :send_on_updated_conference_registration_dates, :boolean, default: true
    add_column :email_settings, :updated_conference_registration_dates_subject, :string
    add_column :email_settings, :updated_conference_registration_dates_template, :text
  end
end
