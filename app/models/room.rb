# frozen_string_literal: true

class Room < ApplicationRecord
  include RevisionCount
  include RailsSortable::Model

  belongs_to :venue
  has_many :event_schedules, dependent: :destroy
  has_many :tracks

  has_paper_trail ignore: [:guid], meta: { conference_id: :conference_id }

  # Drag-and-drop ordering (rails_sortable) persisted in the `position` column.
  # It is the order in which rooms are shown in the schedule/program.
  set_sortable :position

  # Rooms without an explicit position fall back to alphabetical order at the end.
  scope :ordered, -> { order(Arel.sql('position IS NULL, position, name')) }

  before_create :generate_guid

  validates :name, :venue_id, presence: true

  validates :size, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true

  def conference
    venue.conference
  end

  private

  def generate_guid
    guid = SecureRandom.urlsafe_base64
    self.guid = guid
  end

  def conference_id
    venue.conference_id
  end
end
