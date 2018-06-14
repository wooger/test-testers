# filename: bikestore_spec.rb
require_relative 'spec_helper'
require_relative '../pages/bikestore'

describe 'Bikestore app' do

    before(:each) do
        @bikestore = Bikestore.new(@driver)
    end


    it 'product list exists' do
        # Open bike store page
        @driver.get 'http://localhost:8000/'
        # Confirm div for Product List is present
        expect {@driver.find_element(class: 'prodList') }.not_to raise_error
        
    end

    it 'page matches json file' do 
        expect(@bikestore.bike_totals_match?).to be true
    end

    it 'all bikes have classes' do
    end
    
    it 'filters work' do
    end

    it 'filter state retained' do
    end


end