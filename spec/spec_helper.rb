require 'rspec'
require 'capybara'
require 'capybara/rspec'
require 'capybara/dsl'
require 'webdrivers'
require 'yaml'
require 'securerandom'
require 'pry'
require_relative 'support/page_object'
require_relative 'support/login_helper'
require_relative 'support/general_helper'
require_relative 'support/helper'

include GeneralHelper
include LoginHelper
include Helper

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
  config.include Helper, type: :request
end
