angular.module('notifista', [
    'notifista.controllers',
    'notifista.services',
    'ngTagsInput'
]);

angular.module('notifista.services', ['ngCookies']);

angular.module('notifista.controllers', ['ngCookies']);

angular.module('notifista').controller('MainController',
    ['$scope', 'NotifistaHttp', '$cookies', '$attrs', function($scope, NotifistaHttp, $cookies, $attrs) {
        //Boot strap that initializes the data


        if ($attrs.auth){
            console.log($attrs.auth.email);
            console.log($attrs.auth.token);
            var email = $attrs.auth.email;
            var token = $attrs.auth.token;

            NotifistaHttp.Login(email, token);

            $scope.event = {
                name: 'Oxford Inspires'
            }
        }
    }]);
