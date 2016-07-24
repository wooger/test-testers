(function(){

    var app = angular.module('bikeStore', []);    

    var datasource = 'https://raw.githubusercontent.com/jujhars13/jujhars13/master/bikes.json';

    app.controller('prodList', ['$scope', '$http', function ($scope, $http) {

        $http.get(datasource).then(function (response) {

            $scope.products = response.data.items;
        
        });
    }]);

})();


