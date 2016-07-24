(function () {

    var app = angular.module('bikeStore', []);

    var datasource = 'https://raw.githubusercontent.com/jujhars13/jujhars13/master/bikes.json'; // external JSON datasource 

    app.controller('prodList', ['$scope', '$http', function ($scope, $http) {

        $http.get(datasource).then(function (response) {

            $scope.products = response.data.items;

            // list of attributes we want to filter our data on
            // add more attributes to this list to display them in the filter options
            $scope.attributesToFilter = ["class"];

            // initialise the datafilters
            $scope.dataFilters = $scope.getDataFilters($scope.products, $scope.attributesToFilter);

        });

        $scope.getDataFilters = function (products, attributesToFilter) {

            // list of data filters to return
            var dataFilters = [];

            // loop through each attribute we want to add to the filtering e.g. "class" etc 
            angular.forEach(attributesToFilter, function (key) {

                // find if any products have any values for this attibute e.g. "race", "endurance" etc
                angular.forEach(products, function (product) {
                    angular.forEach(product[key], function (value) {

                        var newFilterOption =
                            {
                                "key": key,
                                "value": value,
                                "state": false
                            };

                        // get a list of any duplicates we may have already added
                        var duplicates = dataFilters.filter(
                            filterOption =>
                                filterOption.key == newFilterOption.key
                                && filterOption.value == newFilterOption.value
                        );

                        // if we will not duplicate the new filter option then add it to the list
                        if (duplicates.length == 0) {
                            dataFilters.push(newFilterOption);
                        }

                    }, this);
                }, this);
            }, this);

            return dataFilters;
        }
    }]);

})();


