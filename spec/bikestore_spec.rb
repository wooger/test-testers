# filename: bikestore_spec.rb
require_relative 'spec_helper'
require_relative '../pages/bikestore'

describe 'Bikestore app' do

    before(:each) do
        @bikestore = Bikestore.new(@driver)
    end

    it 'product list exists' do
        expect {@bikestore.productlist_exists?}.not_to raise_error
    end

    it 'number of bikes match' do 
        @bikestore.parse_bikestore_page
        @bikestore.parse_json_file
        expect(@bikestore.bike_totals_match?).to be true
    end

    it 'names match json ' do
        @bikestore.parse_bikestore_page
        @bikestore.parse_json_file
        expect(@bikestore.bike_names_match?).to be true
    end

    it 'all bikes have class, name, image, description' do
    end
    
    it 'filters work' do
    end

    it 'filter state retained' do
    end


end