/** Anthony Guo (anthony.guo@some.ox.ac.uk)
 *
 * sdf
 */
(function(){
    angular.module('notifista.controllers').controller('CreateChannel',
        //['$scope', function($scope){}]);
        ['$scope', 'NotifistaHttp', 'EventService', '$cookies',function($scope, NotifistaHttp, EventService, $cookies) {

        $scope.screen = '';
        $scope.status = '';
        // Need to make 'cmd' a child element of input. The issue is
        // documented here:
        // http://stackoverflow.com/questions/12618342/ng-model-does-not-update-controller-value
        $scope.input = {
            channel_name: ''
        };

        $scope.create_channel = function(){
            var promise = NotifistaHttp.CreateChannel($scope.input.channel_name);
            promise.success(function(data){
                $scope.event.channels.push({'name': $scope.input.channel_name});
            })
            promise.error(function(err){
                $scope.status = err;
            })
        }

        $scope.SelectChannel = function(channel){
            channel.selected = !channel.selected;

        }

    }]);
})();
