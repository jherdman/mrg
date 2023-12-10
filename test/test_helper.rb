ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

Capybara.app_host = "http://#{ENV.fetch('TEST_APP_HOST')}:#{ENV.fetch('TEST_APP_PORT')}"
Capybara.javascript_driver = :selenium
Capybara.run_server = false

desired_capabilities = Selenium::WebDriver::Remote::Capabilities.new(browser: :chrome)

options = Selenium::WebDriver::Options.chrome
options.add_argument '--start-maximized'
options.add_argument '--no-default-browser-check'

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(
      app,
      browser: :remote,
      url: "http://#{ENV['SELENIUM_HOST']}:#{ENV['SELENIUM_PORT']}/wd/hub",
      desired_capabilities:,
      options:
  )
end

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end
