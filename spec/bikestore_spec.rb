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

    it 'all bikes have class, name, image, description' do
        expect(@bikestore.bike_names_present?).to be true
        expect(@bikestore.bike_desc_present?).to be true
        expect(@bikestore.bike_images_present?).to be true
        expect(@bikestore.bike_classes_present?).to be true
    end
    
    it 'number of bikes match' do 
        expect(@bikestore.bike_totals_match?).to be true
    end

    it 'names match json ' do
        expect(@bikestore.bike_names_match?).to be true
    end

    it 'desc match json ' do
        expect(@bikestore.bike_desc_match?).to be true
    end
    
    it 'images match json ' do
        expect(@bikestore.bike_images_match?).to be true
    end
    
    it 'classes match json ' do
        expect(@bikestore.bike_classes_match?).to be true
    end
    
    it 'filters work' do
        expect(@bikestore.filters_working?).to be true
    end

    it 'Filters stay off' do
        state = [0, 0, 0]
        expect(@bikestore.filters_state_retained?(state)).to be true
    end

    it 'Filters stay on' do
        state = [1, 1, 1 ]
        expect(@bikestore.filters_state_retained?(state)).to be true
    end

end