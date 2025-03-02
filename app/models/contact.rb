# frozen_string_literal: true

class Contact < ApplicationRecord
  has_paper_trail on: [:update], ignore: [:updated_at], meta: { conference_id: :conference_id }

  belongs_to :conference

  validates :conference, presence: true
  # Conferences only have one contact
  validates :facebook, :twitter, :instagram, :mastodon, :bluesky,
            format: URI::regexp(%w(http https)), allow_blank: true

  def has_social_media?
    return true if facebook.present? || twitter.present? || instagram.present? || mastodon.present? || email.present? || bluesky.present?

    false
  end
end
