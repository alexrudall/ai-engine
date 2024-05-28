OpenAI.configure do |config|
  config.access_token = ENV.fetch("OPENAI_ACCESS_TOKEN")
  config.organization_id = ENV.fetch("OPENAI_ORGANIZATION_ID")
  config.log_errors = Rails.env.development? || Rails.env.test?
  config.request_timeout = 2.minutes.to_i
end
