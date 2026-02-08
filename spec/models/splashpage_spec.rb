# frozen_string_literal: true

require 'spec_helper'

describe Splashpage do
  let(:conference) { create(:conference) }
  let(:splashpage) { build(:splashpage, conference: conference) }

  describe 'validations' do
    context 'video_url' do
      it 'allows blank video_url' do
        splashpage.video_url = nil
        expect(splashpage.valid?).to be true
      end

      it 'allows empty string video_url' do
        splashpage.video_url = ''
        expect(splashpage.valid?).to be true
      end

      it 'validates video_url is a valid URL format' do
        splashpage.video_url = 'not-a-url'
        expect(splashpage.valid?).to be false
        expect(splashpage.errors[:video_url]).to be_present
      end

      it 'validates video_url is from a supported platform' do
        splashpage.video_url = 'https://example.com/video'
        expect(splashpage.valid?).to be false
        expect(splashpage.errors[:video_url]).to be_present
      end

      it 'accepts valid youtube.com/watch URLs' do
        splashpage.video_url = 'https://www.youtube.com/watch?v=dQw4w9WgXcQ'
        expect(splashpage.valid?).to be true
      end

      it 'accepts valid youtu.be URLs' do
        splashpage.video_url = 'https://youtu.be/dQw4w9WgXcQ'
        expect(splashpage.valid?).to be true
      end

      it 'accepts valid youtube.com/embed URLs' do
        splashpage.video_url = 'https://www.youtube.com/embed/dQw4w9WgXcQ'
        expect(splashpage.valid?).to be true
      end

      it 'accepts valid vimeo.com URLs' do
        splashpage.video_url = 'https://vimeo.com/123456789'
        expect(splashpage.valid?).to be true
      end

      it 'accepts valid PeerTube URLs' do
        splashpage.video_url = 'https://peertube.example.com/videos/watch/abc-123-def'
        expect(splashpage.valid?).to be true
      end

      it 'accepts valid Invidious URLs' do
        splashpage.video_url = 'https://invidious.example.com/watch?v=dQw4w9WgXcQ'
        expect(splashpage.valid?).to be true
      end
    end
  end

  describe '#video_platform' do
    it 'detects YouTube from youtube.com/watch URL' do
      splashpage.video_url = 'https://www.youtube.com/watch?v=dQw4w9WgXcQ'
      expect(splashpage.video_platform).to eq(:youtube)
    end

    it 'detects YouTube from youtu.be URL' do
      splashpage.video_url = 'https://youtu.be/dQw4w9WgXcQ'
      expect(splashpage.video_platform).to eq(:youtube)
    end

    it 'detects YouTube from youtube.com/embed URL' do
      splashpage.video_url = 'https://www.youtube.com/embed/dQw4w9WgXcQ'
      expect(splashpage.video_platform).to eq(:youtube)
    end

    it 'detects YouTube from m.youtube.com URL' do
      splashpage.video_url = 'https://m.youtube.com/watch?v=dQw4w9WgXcQ'
      expect(splashpage.video_platform).to eq(:youtube)
    end

    it 'detects Vimeo from vimeo.com URL' do
      splashpage.video_url = 'https://vimeo.com/123456789'
      expect(splashpage.video_platform).to eq(:vimeo)
    end

    it 'detects Vimeo from vimeo.com/video URL' do
      splashpage.video_url = 'https://vimeo.com/video/123456789'
      expect(splashpage.video_platform).to eq(:vimeo)
    end

    it 'detects PeerTube from videos/watch URL' do
      splashpage.video_url = 'https://peertube.example.com/videos/watch/abc-123-def'
      expect(splashpage.video_platform).to eq(:peertube)
    end

    it 'detects PeerTube from /w/ URL' do
      splashpage.video_url = 'https://peertube.example.com/w/abc-123-def'
      expect(splashpage.video_platform).to eq(:peertube)
    end

    it 'detects Invidious from watch URL' do
      splashpage.video_url = 'https://invidious.example.com/watch?v=dQw4w9WgXcQ'
      expect(splashpage.video_platform).to eq(:invidious)
    end

    it 'returns nil for unsupported platform' do
      splashpage.video_url = 'https://dailymotion.com/video/x12345'
      expect(splashpage.video_platform).to be_nil
    end

    it 'returns nil when video_url is blank' do
      splashpage.video_url = nil
      expect(splashpage.video_platform).to be_nil
    end
  end

  describe '#video_id' do
    context 'YouTube' do
      it 'extracts video ID from youtube.com/watch URL' do
        splashpage.video_url = 'https://www.youtube.com/watch?v=dQw4w9WgXcQ'
        expect(splashpage.video_id).to eq('dQw4w9WgXcQ')
      end

      it 'extracts video ID from youtu.be URL' do
        splashpage.video_url = 'https://youtu.be/dQw4w9WgXcQ'
        expect(splashpage.video_id).to eq('dQw4w9WgXcQ')
      end

      it 'extracts video ID from youtube.com/embed URL' do
        splashpage.video_url = 'https://www.youtube.com/embed/dQw4w9WgXcQ'
        expect(splashpage.video_id).to eq('dQw4w9WgXcQ')
      end

      it 'handles URLs with additional query parameters' do
        splashpage.video_url = 'https://www.youtube.com/watch?v=dQw4w9WgXcQ&t=10s'
        expect(splashpage.video_id).to eq('dQw4w9WgXcQ')
      end
    end

    context 'Vimeo' do
      it 'extracts video ID from vimeo.com URL' do
        splashpage.video_url = 'https://vimeo.com/123456789'
        expect(splashpage.video_id).to eq('123456789')
      end

      it 'extracts video ID from vimeo.com/video URL' do
        splashpage.video_url = 'https://vimeo.com/video/123456789'
        expect(splashpage.video_id).to eq('123456789')
      end
    end

    context 'PeerTube' do
      it 'extracts video ID from videos/watch URL' do
        splashpage.video_url = 'https://peertube.example.com/videos/watch/abc-123-def'
        expect(splashpage.video_id).to eq('abc-123-def')
      end

      it 'extracts video ID from /w/ URL' do
        splashpage.video_url = 'https://peertube.example.com/w/xyz-456-ghi'
        expect(splashpage.video_id).to eq('xyz-456-ghi')
      end
    end

    context 'Invidious' do
      it 'extracts video ID from Invidious URL' do
        splashpage.video_url = 'https://invidious.example.com/watch?v=dQw4w9WgXcQ'
        expect(splashpage.video_id).to eq('dQw4w9WgXcQ')
      end
    end

    it 'returns nil when video_url is blank' do
      splashpage.video_url = nil
      expect(splashpage.video_id).to be_nil
    end

    it 'returns nil for unsupported platform' do
      splashpage.video_url = 'https://example.com/video'
      expect(splashpage.video_id).to be_nil
    end
  end

  describe '#video_instance_url' do
    it 'extracts instance URL from PeerTube videos/watch URL' do
      splashpage.video_url = 'https://peertube.example.com/videos/watch/abc-123-def'
      expect(splashpage.video_instance_url).to eq('https://peertube.example.com')
    end

    it 'extracts instance URL from PeerTube /w/ URL' do
      splashpage.video_url = 'https://peertube.example.com/w/abc-123-def'
      expect(splashpage.video_instance_url).to eq('https://peertube.example.com')
    end

    it 'extracts instance URL from Invidious URL' do
      splashpage.video_url = 'https://invidious.example.com/watch?v=dQw4w9WgXcQ'
      expect(splashpage.video_instance_url).to eq('https://invidious.example.com')
    end

    it 'returns nil for YouTube URL' do
      splashpage.video_url = 'https://www.youtube.com/watch?v=dQw4w9WgXcQ'
      expect(splashpage.video_instance_url).to be_nil
    end

    it 'returns nil for Vimeo URL' do
      splashpage.video_url = 'https://vimeo.com/123456789'
      expect(splashpage.video_instance_url).to be_nil
    end

    it 'returns nil when video_url is blank' do
      splashpage.video_url = nil
      expect(splashpage.video_instance_url).to be_nil
    end
  end

  describe '#video_embed_url' do
    it 'generates YouTube embed URL with autoplay parameters' do
      splashpage.video_url = 'https://www.youtube.com/watch?v=dQw4w9WgXcQ'
      expect(splashpage.video_embed_url).to eq('https://www.youtube.com/embed/dQw4w9WgXcQ?autoplay=1&loop=1&mute=1&controls=0&disablekb=1&fs=0&iv_load_policy=3&modestbranding=1&playsinline=1')
    end

    it 'generates Vimeo embed URL with autoplay parameters' do
      splashpage.video_url = 'https://vimeo.com/123456789'
      expect(splashpage.video_embed_url).to eq('https://player.vimeo.com/video/123456789?autoplay=1&muted=1&loop=1&playsinline=1')
    end

    it 'generates PeerTube embed URL with autoplay' do
      splashpage.video_url = 'https://peertube.example.com/videos/watch/abc-123-def'
      expect(splashpage.video_embed_url).to eq('https://peertube.example.com/videos/embed/abc-123-def?autoplay=1&loop=1')
    end

    it 'generates Invidious embed URL with autoplay' do
      splashpage.video_url = 'https://invidious.example.com/watch?v=dQw4w9WgXcQ'
      expect(splashpage.video_embed_url).to eq('https://invidious.example.com/embed/dQw4w9WgXcQ?autoplay=1&loop=1')
    end

    it 'returns nil when video_url is blank' do
      splashpage.video_url = nil
      expect(splashpage.video_embed_url).to be_nil
    end

    it 'returns nil for unsupported platform' do
      splashpage.video_url = 'https://example.com/video'
      expect(splashpage.video_embed_url).to be_nil
    end
  end
end
