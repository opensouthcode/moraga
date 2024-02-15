Sentry.init do |config|
  config.dsn = ENV.fetch('MORAGA_SENTRY_DSN', Rails.application.secrets.sentry_dsn)
  config.breadcrumbs_logger = [:active_support_logger]

  # To activate performance monitoring, set one of these options.
  # We recommend adjusting the value in production:
  config.traces_sample_rate = ENV.fetch('MORAGA_SENTRY_TRACES_SAMPLE_RATE', '0.5').to_f
  # or
  # config.traces_sampler = lambda do |context|
  #  true
  # end

  # During deployment we touch tmp/restart.txt, let's use its last access time as release.
  # Unless someone has set a variable of course...
  moraga_version_from_file = nil
  version_file = File.expand_path('../../tmp/restart.txt', __dir__)
  moraga_version_from_file = File.new(version_file).atime.to_i if File.file?(version_file)
  moraga_version = ENV.fetch('MORAGA_SENTRY_RELEASE', moraga_version_from_file)
  config.release = moraga_version if moraga_version
end
