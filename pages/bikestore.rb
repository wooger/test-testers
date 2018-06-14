# filename: bikestore.rb

class Bikestore 

    # page variables
    BIKESTORE_URL = "http://localhost:8000/"
    JSON_URL = "http://localhost:8000/bikes.json"
    PRODLIST_LOCATOR = {class: 'prodList'}
    IMAGES_LOCATOR = {class: 'img-responsive'}
    DESC_LOCATOR = {class: 'desc'}
    NAME_LOCATOR = {class: 'panel-heading'}
    CLASS_LOCATOR_A = {class: 'panel-footer'}
    CLASS_LOCATOR_B = {class: 'capitalise'}
    CHECKBOX_LOCATOR = {}
    CHECKBOX_STATE = {}
    CHECKBOX_NAME = {}

    def initialize(driver)
        @driver = driver
        @driver.get 'http://localhost:8000/' # Open bike store page
    end

    def productlist_exists?
        # Grab only the relevant product List div
        prodlist = @driver.find_element(class: 'prodList')
    end

    def parse_bikestore_page
        # Grab only the relevant product List div
        prodlist = @driver.find_element(class: 'prodList')

        # Collect array of elements for all Bikes
        @bike_names = prodlist.find_elements(class: 'panel-heading') 

        # Use text method on array to get text names
        @bike_names.map!(&:text)

        # Now repeat for images, descriptions & classes
        # Descriptions
        descriptions = prodlist.find_elements(class: 'desc')
        descriptions.map!(&:text) # get text

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
    end

    def parse_json_file

        # Use open-uri & JSON to parse bikes.json directly
        @bikes_json = JSON.parse(open(JSON_URL).read)

        # Munge into suitable arrays for easy comparison with page data. 
        # Assign blank arrays with suitable names
        @names_json = []
        @class_json = []
        @desc_json = []
        @image_json = []

        # Iterate through each bike's data
        @bikes_json['items'].each do |bike|
            @names_json << bike['name'] # names
            @class_json << bike['class'] # array of classes
            @desc_json << bike['description'] # descriptions
            @image_json << bike['image']['thumb'] # image
        end
    end

    # Compare source data to Product List on store page
        
    def bike_totals_match?
        # Simple - compare number of bikes
        bikes_total = @bike_names.length # Total bike elements on page
        bikes_json_total = @bikes_json['items'].length # Total bike elements in JSON
        bikes_total == bikes_json_total
    end

    def bike_names_present?
    end

    def bike_names_match?
        # Confirm bikes from JSON are all present by comparing arrays
        @bike_names == @names_json
        #expect(bike_names).to eq(names_json)
    end

    def bike_desc_present?
    end

    def bike_desc_match?
        # Confirm descriptions from JSON are all present by comparing arrays
        expect(bike_names).to eq(names_json)
    end

    def bike_images_present?
    end

    def bike_images_match?
        # Confirm (thumbnail) images from JSON are all present by comparing arrays
        expect(bike_names).to eq(names_json)
    end

    def bike_classes_present?
    end

    def bike_classes_match?
        # Confirm classes from JSON are all present & correct by comparing arrays
        expect(bike_names).to eq(names_json)
    end

    # Placeholders to implement
    def filters_work?
    end

    def filters_state_retained?
    end


end

