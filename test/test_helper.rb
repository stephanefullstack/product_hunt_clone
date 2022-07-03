ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

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

# Register the new driver for Capybara
# Capybara.register_driver :headless_chrome do |app|
#   options = Selenium::WebDriver::Chrome::Options.new(args: %w[no-sandbox headless disable-gpu window-size=1400,900])
#   Capybara::Selenium::Driver.new(app, browser: :chromium, options: options)
# end
# Capybara.save_path = Rails.root.join('tmp/capybara')
# Capybara.javascript_driver = :headless_chrome

Capybara.register_driver :firefox do |app|
  Capybara::Selenium::Driver.new(app, browser: :firefox)
end

Capybara.register_driver :headless_firefox do |app|
  options = Selenium::WebDriver::Firefox::Options.new
  options.headless! # added on https://github.com/SeleniumHQ/selenium/pull/4762

  Capybara::Selenium::Driver.new app,
    browser: :firefox,
    options: options
end

Capybara.javascript_driver = ENV['GUI'] ? :firefox : :headless_firefox