ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  # Devise test helpers
  include Warden::Test::Helpers
  Warden.test_mode!
end

# Capybara.register_driver :headless_chrome do |app|
#   options = Selenium::WebDriver::Chrome::Options ruby.new(args: %w[no-sandbox headless disable-gpu window-size=1400,900])
#   Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
# end

# Capybara.register_driver :headless_chrome do |app|
#   options = Selenium::WebDriver::Chrome::Options.new
#   Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
# end

# Chrome headless driver
Capybara.register_driver :headless_chrome do |app|
  caps = Selenium::WebDriver::Remote::Capabilities.chrome(loggingPrefs: { browser: 'ALL' })
  opts = Selenium::WebDriver::Chrome::Options.new

  chrome_args = %w[--headless --no-sandbox --disable-gpu --window-size=1920,1080 --remote-debugging-port=9222]
  chrome_args.each { |arg| opts.add_argument(arg) }
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: opts, desired_capabilities: caps)
end

Capybara.save_path = Rails.root.join('tmp/capybara')
Capybara.javascript_driver = :headless_chrome

# Chrome non-headless driver
# Capybara.register_driver :chrome do |app|
#   Capybara::Selenium::Driver.new(app, browser: :chrome)
# end

# Capybara.javascript_driver = :chrome
