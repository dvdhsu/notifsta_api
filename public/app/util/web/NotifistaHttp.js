(function(){
    angular.module('notifista.services').service('NotifistaHttp', ['$http', service]);
    var BASE_URL = 'http://notifsta.com';
    //var BASE_URL = '';
    var credentials = {
        email: null,
        key: null 
    }

    function GetAuth(){
        return 'user_email=' + credentials.email + '&user_token=' + credentials.key;
    }


    function service($http){
        function GetEvent(id) {
            console.log(GetAuth());
            return $http.get(BASE_URL + '/api/v1/events/'+ id + '/?' + GetAuth());
        }

        function Broadcast(broadcast, channel_ids){
            return channel_ids.map(function(channel_id){
                var req = {
                    url: BASE_URL + '/api/v1/channels/' + channel_id + '/messages',
                    method: 'POST',
                    params: {
                        'user_email': credentials.email,
                        'user_token': credentials.key,
                        'message[message_guts]' : broadcast
                    }
                }
                return $http(req);
            })
        }

        function Login(email, password){
            credentials.email = email;
            credentials.password = password
            console.log(credentials);
            var promise = $http.get(BASE_URL + '/api/v1/auth/login?email='+ email + '&password='+ password);
            promise.success(function(e){
                if (e.data){
                    credentials.key = e.data.authentication_token;
                }
            })
            return promise;
        }

        function GetUser(user_id){
          var promise = $http.get(BASE_URL + '/api/v1/users/' + user_id );
          return promise;

        }

        /* OBSOLETED CODE */
        function CreateEvent(name, password){
            throw "NOT IMPLEMENTED";
            return $http.post('/api/v1/event/', {
                name : name,
                password: password
            });
        }

        function CreateChannel(name){
            throw "NOT IMPLEMENTED";
            return $http.post('/api/v1/event/channel', {
                name : name
            });
        }

        function CreateNotification(event_name, channel_name, message){
            return $http.post('/api/v1/event/channel/notif')
        }

        function GetMessages(id){
            var req = {
                url: BASE_URL + '/api/v1/channels/' + id + '/messages',
                method: 'GET',
                params: {
                    'user_email': credentials.email,
                    'user_token': credentials.key
                }
            }
            return $http(req);
        }

        return {
            Login: Login,
            CreateEvent: CreateEvent,
            CreateChannel: CreateChannel,
            GetEvent: GetEvent,
            Broadcast: Broadcast,
            GetMessages: GetMessages,
            GetUser: GetUser,
            credentials: credentials
        }
    }

})();
