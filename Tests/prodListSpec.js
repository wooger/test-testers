describe('prodList Controller', function () {

    var $httpBackend, $rootScope, createController;

    // Mock product data JSON for unit tests
    var mockBikeJSON = {
        "items": [
            {
                "id": 1,
                "class": ["endurance", "race"],
                "gears": ["21"]
            },
            {
                "id": 2,
                "class": ["endurance", "race"],
                "gears": ["21"]
            },
            {
                "id": 3,
                "class": ["comfort", "endurance", "race"],
                "gears": ["18"]
            },
        ]
    };

    beforeEach(module('bikeStore'));

    beforeEach(inject(function ($injector) {

        // Set up the mock http service responses
        $httpBackend = $injector.get('$httpBackend');

        // backend definition common for all tests
        $httpBackend
            .when('GET', /.json/)
            .respond(mockBikeJSON);

        $rootScope = $injector.get('$rootScope');
        var $controller = $injector.get('$controller');

        // define function create controller
        createController = function () {
            return $controller('prodList', { '$scope': $rootScope });
        };

    }));

    beforeEach(function () {
        createController();
        $httpBackend.flush();
    });

    afterEach(function () {

        $httpBackend.verifyNoOutstandingExpectation();
        $httpBackend.verifyNoOutstandingRequest();

    });

    // Basic test for loading the product data
    it('when we create controller then we get product data loaded', function () {

        expect($rootScope.products).not.toBeUndefined();
        expect($rootScope.products.length).toBeGreaterThan(0);

    });

    // basic test that get data filters returns filters
    it('when we get data filters we get some data filters', function () {
        
        var dataFilters = $rootScope.getDataFilters($rootScope.products, ["class"]);

        expect($rootScope.products).not.toBeUndefined();
        expect($rootScope.products.length).toBeGreaterThan(0);

    });

    // basic test that get data filters expected number of filters
    it('when we get data filters we get the expected number of data filters', function () {
        
        var dataFilters = $rootScope.getDataFilters($rootScope.products, ["class", "gears"]);

        expect(dataFilters).not.toBeUndefined();
        expect(dataFilters.length).toEqual(5);

    });

    it('when we get data filters we get only unique data filters', function () {

        // inject our own parametes to getDataFilters
        var dataFilters = $rootScope.getDataFilters($rootScope.products, ["class", "gears"]);

        // get a unique list
        var values = dataFilters.map(filter => filter.value);
        var result = values.filter((value, index) => values.indexOf(value) == index);

        // test unique list length matches
        expect(result.length).toEqual(dataFilters.length);

    });

});