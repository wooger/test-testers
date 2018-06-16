# Planning Exercise

![on my mf bike](/app/favicon.png)
## User Story Analysis:

Check the exercise brief in the original [README.md](README_ORIGINAL.md) file for reference.

### Story 0
*As a user, assuming I have access to a modern web browser (Chrome) with an internet connection and I am visiting the page.*

Affects scope limitations only.

### Story 1
*I would like to see a list/grid of bikes based on /app/bikes.json*

To test this: 
* Part A - is a grid/list shown? Check  class = prodList is present in relevant div.
* Part B - is it based on bikes.json?

Hard to confirm without parsing JSON & making comparison.
Could be as simple as comparison of number of displayed bikes vs number of elements in JSON array.

OR 

Parse JSON directly, validate it & compare to displayed bikes in grid, confirming each named bike is present & alongside appropriate image, class, description etc.

### Story 2
*I would like to see a the name, an image, a description and the class for each bike.*

To test this: Locate element locators for each requirement, cycle through the repeating classes to confirm for each bike displayed.

### Story 3
*I would like to be able to sort the bikes into a custom order based on class.*

To test this: Confirm that each filter checkbox works - i.e. that all bikes displayed have classes containing the selected filter. Use class element locator found in above test. See note below re sorting vs. filtering.

### Story 4
*I would like my custom order to be saved and not change when I refresh the page.*

To test this: Load the page, check a filter box, refresh the page, and confirm the checkbox is still checked. Repeat for all other filters. See note below re sorting vs. filtering.

## Initial thoughts on how to complete the task

* If treated as a whitebox test, I could pull in the whole JSON data object &  compare to page for accuracy - i.e. every bike has the correct images & data shown against it.

    * I don't think this is what we're after, a blackbox test is more appropriate.

    * **UPDATE** Decision NOW REVERSED: Other than examining the JSON manually, I'll treat this exercise as a blackbox test, and run tests only on the app page itself.
    * **UPDATE**: The open-uri gem is the best route to parse & validate the JSON. I've decided it is worthwhile accessing the JSON directly & comparing to the page contents.

* Use Ruby, Rspec & Selenium WebDriver to accomplish the task.

## Assumptions:
* Assume the JSON is valididated already when generated, so don't directly parse the json file.
* Assume that grid & list behave substantially the same, so no need to test both.
* Update: Assume that all filter checkboxes are unticked for a new site visitor.
* Update: Assume that the sort order of bikes on the pages matches that in the JSON. I note that the id parameters from the JSON aren't present on the page, so alpha-numeric sorting via bike name is the only other option.
* Only test on Chrome on Desktop rather than mobile.
* Assume a reasonable screen size such that the desktop 3xN grid is shown. 
* Assume that the specific image & description shown for each bike matters - rather than just *an* image being shown etc.

## User Story Error - filter vs. sort
The page obviously doesn't *sort* bikes based on the class checkboxes, but rather filters based on them. I'm going to assume that the wording of the user story here is an oversight, and you don't want me to re-write the app / make a test for something that isn't included.

I will write my testing assuming the story should instead read:
- *I would like to be able to FILTER the bikes shown based on class.*
- *I would like my FILTER to be saved and not change when I refresh the page.*

## Scope:
- Chrome Desktop Browser only to be tested.
- Average Screensize assumed - i.e. scrolling irrelevant, desktop layout will be used.
- Check only "all ticked" & "none ticked" filter states are retained, not every combination.
- Likewise, check only each class filter checkbox on it's own, rather than every combination.
- As app is locally hosted, timing & latency issues are minimal, so I'll knowingly ignore adding waits for now.

## Locators for exercise:

* **Product List:** class: 'prodList'
* **Bike names:** class: 'panel-heading' 
 * **Bike class:** class: panel-footer -> class: 'capitalise' - repeated...
* **Bike description:** class: 'desc'
* **Bike image:** class: 'img-responsive'
* **Checkboxes:** div contains text "filter:{ key: attr }"
then inside that:
    * input tag with type: checkbox 
    * Check state: checked="checked"
    * Which class is being filtered: span tag, text attr 

## How to run tests with Rspec:

1. Install Ruby
2. Install required ruby gems via: 
```shell
> bundle install 
```
or, if you have bundler installed
```shell
> gem install selenium-webdriver json rspec
```
3. Download Chromedriver, unzip & place on the PATH
4. Install Chrome browser
5. Run bikestore app via one of the methods in the supplied README.md
6. Set URL variables at top of /pages/bikestore.rb to match the host you're using, if not http://localhost:8000
7. Run tests via command 
```shell
> rspec bikestore_spec.rb
``` 
from the /spec directory.

## Bonus Exercise:
Looks easy.

1. Modify mock data to add a new class "gravel" to one of the bikes.
2. Copy the test definition from another test and modify expected count, description & variable data filter name.
3. Create a new data filter variable, and modify to filter the new gravel class.
4. Finally, modify the sanity check test (Number of data filters is right) to include the new test.
5. Reload http://localhost:8000/test and check the result = success
### Screenshot of Success
![screenshot](/bonus_screenshot.png)
