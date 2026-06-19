# frozen_string_literal: true

class AddPositionToRooms < ActiveRecord::Migration[7.0]
  def up
    add_column :rooms, :position, :integer

    # Backfill existing rooms per venue using the current (by name) order
    # so the schedule keeps its present ordering until an admin changes it.
    Room.reset_column_information
    Venue.find_each do |venue|
      venue.rooms.order(:name).each_with_index do |room, index|
        room.update_column(:position, index + 1)
      end
    end
  end

  def down
    remove_column :rooms, :position
  end
end
