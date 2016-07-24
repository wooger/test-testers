describe('prodList Controller', function () {

    var $httpBackend, $rootScope, createController;

    // Mock product data JSON for unit tests
    var mockBikeJSON = {
        "items": [
            {
                "id": 1,
                "class": ["endurance", "race"]
            },
            {
                "id": 2,
                "class": ["endurance", "race"]
            },
            {
                "id": 3,
                "class": ["comfort", "endurance", "race"]
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

    afterEach(function () {

        $httpBackend.verifyNoOutstandingExpectation();
        $httpBackend.verifyNoOutstandingRequest();

    });

    // Basic test for loading the product data
    it('when we create controller then we get product data loaded', function () {

        createController();
        $httpBackend.flush();
        expect($rootScope.products.length).toEqual(3);

    });

});