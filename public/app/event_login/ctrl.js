/** Anthony Guo (anthony.guo@some.ox.ac.uk)
 *
 * A shell to interact with the bughouse internet chess server.
 *
 * The shell is only turned on if the "dev=true" flag is in
 * the URL.
 *
 */
(function(){
    angular.module('notifista.controllers').controller('EventLoginController',
        ['$scope', 'NotifistaHttp', '$cookies',function($scope, NotifistaHttp,  $cookies) {
            console.log("HWFEWF")

        $scope.screen = '';


        // Need to make 'cmd' a child element of input. The issue is
        // documented here:
        // http://stackoverflow.com/questions/12618342/ng-model-does-not-update-controller-value
        $scope.input = {
            eventname: 'event',
            password: 'asdfasdf'
        };

        $scope.event_id = function(){
            return $cookies['sails.sid'];
        }
        console.log($cookies);

        $scope.submit = function(cmd){
            $scope.input.cmd = '';
        }

        $scope.login = function(){
            var p = NotifistaHttp.LoginEvent($scope.input.eventname, $scope.input.password);
            console.log(p);
            p.success(function(event){
                console.log(event);
            })
            p.error(function(e){
                console.log(e);
            })
        }
        $scope.logout = function(){
            var p =NotifistaHttp.LogoutEvent();
            p.success(function(e){
                console.log(e);
            })
            p.error(function(e){
                console.log(e);
            })
        }
    }]);
})();
