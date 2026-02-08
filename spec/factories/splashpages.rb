# frozen_string_literal: true

# Read about factories at https://github.com/thoughtbot/factory_bot

FactoryBot.define do
  factory :splashpage do

    public  { false }

    factory :full_splashpage do

      public { true }

      include_tracks { true }
      include_program { true }
      include_social_media { true }
      include_venue { true }
      include_tickets { true }
      include_registrations { true }
      include_sponsors { true }
      include_lodgings { true }
      include_cfp { true }
      video_url { 'https://www.youtube.com/watch?v=dQw4w9WgXcQ' }
    end

    factory :splashpage_with_youtube_video do
      public { true }
      video_url { 'https://www.youtube.com/watch?v=dQw4w9WgXcQ' }
    end

    factory :splashpage_with_vimeo_video do
      public { true }
      video_url { 'https://vimeo.com/123456789' }
    end

    factory :splashpage_with_peertube_video do
      public { true }
      video_url { 'https://peertube.example.com/videos/watch/abc-123-def' }
    end
  end
end
