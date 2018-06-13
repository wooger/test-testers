# filename: prodlist_spec.rb
require 'selenium-webdriver'
require 'open-uri'
require 'json'
describe 'Bikestore app' do
    before(:each) do
        # Open new browser
        @driver = Selenium::WebDriver.for :chrome
    end
    after(:each) do
        # Kill the browser
        @driver.quit
    end
    it 'product list exists' do
        # Open bike store page
        @driver.get 'http://localhost:8000/'
        # Confirm div for Product List is present
        expect {@driver.find_element(class: 'prodList') }.not_to raise_error
        
    end

    it 'page matches json file' do # Quick and dirty, split into page object later.
        # Open bike store page
        @driver.get 'http://localhost:8000/'

        # Grab only the relevant product List div
        prodlist = @driver.find_element(class: 'prodList')

        # Collect array of elements for all Bikes
        bike_names = prodlist.find_elements(class: 'panel-heading') 

        # Use text method on array to get text names
        bike_names.map!(&:text)

        # Now repeat for images, descriptions & classes
        # Descriptions
        descriptions = prodlist.find_elements(class: 'desc')
        descriptions.map!(&:text)

        # Images element array.
        images = prodlist.find_elements(class: 'img-responsive')
        
        bike_images = [] # Blank array

        #Iterate through array to get source links.
        images.each do |bike|
            bike_images << bike.attribute('src') 
        end

        # Classes - more than one per bike, so an extra step
        bike_classes_raw = prodlist.find_elements(class: 'panel-footer') # One for each bike

        bike_classes = [] # assign new blank array

        # Iterate through array to find individual elements and output to new array
        bike_classes_raw.each do |bike|
            # Find multiple classes per bike and add to temp array
            temp_array = bike.find_elements(class: 'capitalise') 
            temp_array.map!(&:text) # get the text attributes
            bike_classes << temp_array # Add result to final bike_class nested array.
        end


        # Use open-uri & JSON to parse bikes.json directly
        bikes_json = JSON.parse(open('http://localhost:8000/bikes.json').read)

        # Munge into suitable arrays for easy comparison with page data. 
        # Assign blank arrays with suitable names
        names_json = []
        class_json = []
        desc_json = []
        image_json = []

        # Iterate through each bike's data
        bikes_json['items'].each do |bike|
            names_json << bike['name'] # names
            class_json << bike['class'] # array of classes
            desc_json << bike['description'] # descriptions
            image_json << bike['image']['thumb'] # image
        end

        # Finally the tests
        # Compare source data to Product List on store page
        
        # Simple - compare number of bikes
        bikes_total = bike_names.length # Total bike elements on page
        bikes_json_total = bikes_json['items'].length # Total bike elements in JSON
        #expect(bikes_total).to eq(bikes_json_total)

        # Confirm bikes from JSON are all present by comparing arrays
        expect(bike_names).to eq(names_json)
    end


end