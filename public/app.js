angular.module('notifista', [
    'notifista.controllers',
    'notifista.services',
    'ngTagsInput'
]);

angular.module('notifista.services', ['ngCookies']);

angular.module('notifista.controllers', ['ngCookies']);

angular.module('notifista').controller('MainController',
    ['$scope', 'NotifistaHttp', '$cookies', function($scope, NotifistaHttp, $cookies) {
        $scope.event = {
            name: 'Oxford Inspires'
        }
    }]);
