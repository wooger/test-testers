# filename: prodlist_spec.rb
require 'selenium-webdriver'
describe 'Check div with class prodlist exists' do
    before(:each) do
        # Open new browser
        @driver = Selenium::WebDriver.for :chrome
    end
    after(:each) do
        # Kill the browser
        @driver.quit
    end
    it 'exists' do
        # Open bike store page
        @driver.get 'http://localhost:8000/'
        # Confirm div for Product List is present
        expect {@driver.find_element(class: 'prodList') }.not_to raise_error
        
    end
end