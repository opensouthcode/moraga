# frozen_string_literal: true

class Splashpage < ApplicationRecord
  belongs_to :conference

  has_paper_trail ignore: [:updated_at], meta: { conference_id: :conference_id }

  validates :video_url,
            format: { with: URI::regexp(%w(http https)), message: :invalid_url },
            allow_blank: true

  validate :video_url_is_supported_platform, if: :video_url?

  # Configuration for supported video platforms
  # To add a new platform: add an entry with patterns (regex) and embed_template
  SUPPORTED_PLATFORMS = {
    youtube: {
      patterns: [
        /(?:youtube\.com\/watch\?v=|youtu\.be\/|youtube\.com\/embed\/|m\.youtube\.com\/watch\?v=)([a-zA-Z0-9_-]{11})/
      ],
      embed_template: 'https://www.youtube.com/embed/%{video_id}',
      autoplay_params: 'autoplay=1&loop=1&mute=1&controls=0&disablekb=1&fs=0&iv_load_policy=3&modestbranding=1&playsinline=1'
    },
    vimeo: {
      patterns: [/vimeo\.com\/(?:video\/)?(\d+)/],
      embed_template: 'https://player.vimeo.com/video/%{video_id}',
      autoplay_params: 'autoplay=1&muted=1&loop=1&playsinline=1'
    },
    peertube: {
      patterns: [
        /(https?:\/\/[^\/]+)\/videos\/watch\/([a-zA-Z0-9-]+)/,
        /(https?:\/\/[^\/]+)\/w\/([a-zA-Z0-9-]+)/
      ],
      embed_template: '%{instance_url}/videos/embed/%{video_id}',
      autoplay_params: 'autoplay=1&loop=1'
    },
    invidious: {
      patterns: [/(https?:\/\/[^\/]+)\/watch\?v=([a-zA-Z0-9_-]{11})/],
      embed_template: '%{instance_url}/embed/%{video_id}',
      autoplay_params: 'autoplay=1&loop=1'
    }
  }.freeze

  # Detect platform from video URL
  def video_platform
    return nil unless video_url.present?

    SUPPORTED_PLATFORMS.find do |platform, config|
      config[:patterns].any? { |pattern| video_url.match?(pattern) }
    end&.first
  end

  # Extract video ID from URL
  def video_id
    match_data = url_match_data
    return nil unless match_data

    # For federated platforms (PeerTube, Invidious), video_id is the second capture
    match_data.captures.length > 1 ? match_data[2] : match_data[1]
  end

  # Extract instance URL for federated platforms (PeerTube, Invidious)
  def video_instance_url
    return nil unless [:peertube, :invidious].include?(video_platform)

    match_data = url_match_data
    match_data&.captures&.length.to_i > 1 ? match_data[1] : nil
  end

  # Generate complete embed URL with autoplay parameters
  def video_embed_url
    return nil unless video_platform && video_id

    config = SUPPORTED_PLATFORMS[video_platform]
    base_url = build_base_url(config)

    "#{base_url}?#{config[:autoplay_params]}"
  end

  private

  # Get regex match data for the current video URL
  def url_match_data
    return nil unless video_url.present? && video_platform.present?

    config = SUPPORTED_PLATFORMS[video_platform]
    config[:patterns].each do |pattern|
      match = video_url.match(pattern)
      return match if match
    end

    nil
  end

  # Build base embed URL from template
  def build_base_url(config)
    template = config[:embed_template]

    if [:peertube, :invidious].include?(video_platform)
      template % { instance_url: video_instance_url, video_id: video_id }
    else
      template % { video_id: video_id }
    end
  end

  # Validation: ensure URL is from a supported platform
  def video_url_is_supported_platform
    return if video_platform.present?

    errors.add(:video_url, :unsupported_platform)
  end
end
