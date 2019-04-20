require 'rspec'
require 'capybara'
require 'capybara/rspec'
require 'capybara/dsl'
require 'webdrivers'
require 'yaml'
require_relative 'support/page_object'

Capybara.run_server = false
Capybara.default_driver = :chrome
Capybara.app_host = 'http://ultimate-weather.slack.com'
Capybara.default_max_wait_time = 2

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'
  config.before(:each) do
    @root = '/'
  end
end
