# frozen_string_literal: true

class RegistrationsVchoices < ActiveRecord::Migration[4.2]
  def up
    create_table :registrations_vchoices, id: false do |t|
      t.references :registration, :vchoice
    end
  end

  def down
    drop_table :registrations_vchoices
  end
end
