Rollbar.configure do |config|
  config.access_token = ENV['ROLLBAR_ACCESS_TOKEN']

  if Rails.env.development? || Rails.env.test?
    config.enabled = false
  end

  config.environment = ENV['ROLLBAR_ENV'].presence || Rails.env
end

begin
  x = nil
  x.hello?
rescue => e
  rollbar_notifier = Rollbar.scope(
    {
      # Adding info about the user affected by this event (optional)
      # The 'id' field is required, anything else is optional
      :person => {
          :id => '1234',
          :username => 'testuser',
          :email => 'user@test'
      },

      # Example of adding arbitrary metadata (optional)
      :custom => {
        :trace_id => 'aabbccddeeff',
        :feature_flags => [
          'feature_1',
          'feature_2'
        ]
      }
    }
  )

  rollbar_notifier.error(e)
end
