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
    CHECKBOXES_DIV_LOCATOR = {ng-repeat: 'df in dataFilters | filter:{ key: attr }'}
    CHECKBOXES_LOCATOR = {tag_name: 'input'}
    CHECKBOX_STATE = {checked: 'checked'}
    CHECKBOX_NAME = {tag_name: 'span'}

#    Checkboxes: div contains text "filter:{ key: attr }"
# then inside that:
#   * input tag with type: checkbox 
#   * Check state: checked="checked"
#   * Which class is being filtered: span tag, text attr 

    def initialize(driver)
        @driver = driver
        @driver.get BIKESTORE_URL # Open bike store page
    end

    def productlist_exists?
        # Grab only the relevant product List div
        @prodlist = @driver.find_element(PRODLIST_LOCATOR)
    end

    def parse_bikestore_page
        # Grab only the relevant product List div
        @prodlist = @driver.find_element(PRODLIST_LOCATOR)

        # Collect array of elements for all Bikes
        @bike_names = prodlist.find_elements(NAME_LOCATOR) 

        # Use text method on array to get text names
        @bike_names.map!(&:text)

        # Now repeat for images, descriptions & classes
        # Descriptions
        descriptions = prodlist.find_elements(DESC_LOCATOR)
        descriptions.map!(&:text) # get text

        # Images element array.
        images = @prodlist.find_elements(IMAGES_LOCATOR) 
        
        bike_images = [] # Blank array

        #Iterate through array to get source links.
        images.each do |bike|
            bike_images << bike.attribute('src') 
        end

        # Classes - more than one per bike, so an extra step
        bike_classes_raw = @prodlist.find_elements(CLASS_LOCATOR_A) # One for each bike

        bike_classes = [] # assign new blank array

        # Iterate through array to find individual elements and output to new array
        bike_classes_raw.each do |bike|
            # Find multiple classes per bike and add to temp array
            temp_array = bike.find_elements(CLASS_LOCATOR_B) 
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

    def parse_filters
        # Find filter checkboxes div via locator 
        filters_div = @driver.find_element(CHECKBOXES_DIV_LOCATOR)

        # Get checkbox elements into array 
        checkboxes = filters_div.find_elements(CHECKBOXES_LOCATOR) # array

        # Grab the state of each checkbox
        checkboxes.each do |box|
            # Iterate through, state = 1 if element present hence checked
            # state = 0 if element not present hence not checked
            checkbox_states << box.find_elements(checked: 'checked')
        end

        # Get checkbox filter names into array & grab the text attribute
        checkbox_names = filters_div.find_elements(tag_name: 'span')
        checkbox_names.map!(&:text) # replace element by text attribute.

        # We now have three arrays, one of checkbox elements, 
        # one of checkbox states, one of the class each checkbox filters.
        
    end

    def filters_state_retained?(state)

        # Check state, all should be unchecked initially
        parse_filters
        @checkbox_states == [0, 0, 0] # Should all be unchecked on fresh session

        # If state is all ticked, tick all boxes 
        if state == [1, 1, 1]   
            @checkboxes.each do |box|
                box.click # click each checkbox in turn. 
            end
            unless @checkbox_states == state
            # confirm state is now checked for all of them
        end

        # Now refresh again and confirm state is unchanged
        @driver.navigate.refresh # reload page
        parse_filters # Get state again
        @checkbox_states == state # confirm state is retained
    end

    def filters_state_retained?(state)

        # Check state, all should be unchecked initially
        parse_filters
        @checkbox_states == [0, 0, 0] # Should all be unchecked on fresh session

        # Iterate through all three arrays of checkbox: , filter name, state, element
        # Zip all three arrays together for ease:
        @checkbox_names.zip(@checkbox_states @checkboxes).each do |name, state, box|
            box.click # click checkbox
            parse_filters # update state
            state == 1 # Confirm filter state has changed
            
            parse_bikestore_page # Get info on bikes displayed from page

            # Iterate through each bike on page
            bike_classes.each do |class|
                # does each class array contain the filtered term?
                class.include?(name) or raise "Error: filters not working"
            end                 

            # Now reset state of checkbox to unticked

            # Confirm it's unticked


            # Onwards to repeat for all three checkboxes


    end


end

