require_relative "boot"

require 'rails/all'

Bundler.require(*Rails.groups)

module YourApplicationName
  class Application < Rails::Application
    config.load_defaults 7.0

    # その他の設定
    ActiveSupport.on_load(:active_storage_blob) do
      ActiveStorage::Current.host = 'http://localhost:3000'
    end
  end
end