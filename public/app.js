angular.module('notifista', [
    'notifista.controllers',
    'notifista.services',
    'ngTagsInput'
]);

angular.module('notifista.services', ['ngCookies']);

angular.module('notifista.controllers', ['ngCookies']);

angular.module('notifista').controller('MainController',
    ['$scope', 'NotifistaHttp', '$cookies',  function($scope, NotifistaHttp, $cookies, attrs) {
        //Boot strap that initializes the data

        var el = document.getElementById('main_controller');
        var email = el.dataset.authEmail;
        var token = el.dataset.authToken;
        var name = el.dataset.eventName;

        NotifistaHttp.Login(email, token);
        $scope.event = {
            name: name
        }
        $scope.email = email;
        $scope.key = token;
        $scope.user_id = el.dataset.userId;
    }]);
