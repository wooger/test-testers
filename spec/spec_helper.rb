# filename: spec_helper.rb
require 'selenium-webdriver'
require 'open-uri'
require 'json'

RSpec.configure do |config|
    
    config.before(:each) do
        # Open new browser
        @driver = Selenium::WebDriver.for :chrome
    end
    
    config.after(:each) do
        # Kill the browser
        @driver.quit
    end

end