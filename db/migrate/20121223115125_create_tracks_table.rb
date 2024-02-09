# frozen_string_literal: true

class CreateTracksTable < ActiveRecord::Migration[4.2]
  def up
    create_table :tracks do |t|
      t.string :guid, null: false
      t.references :conference
      t.string :name, null: false
      t.text :description
      t.string :color, default: '#ffffff'

      t.timestamps
    end
  end

  def down
  end
end
