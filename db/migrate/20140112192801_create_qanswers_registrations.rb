# frozen_string_literal: true

class CreateQanswersRegistrations < ActiveRecord::Migration[4.2]
  def change
    create_table :qanswers_registrations, id: false do |t|
      t.references :registration, null: false
      t.references :qanswer, null: false
    end
  end
end
