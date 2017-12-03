Messenger.configure do |config|
  config.verify_token      = ENV.fetch('VERIFY_TOKEN')
  config.page_access_token = ENV.fetch('PAGE_ACCESS_TOKEN')
end
