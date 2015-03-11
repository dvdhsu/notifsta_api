/** Anthony Guo (anthony.guo@some.ox.ac.uk)
 * Purpose of this service is to maintain the global state of the event application.
 * Provides methods for updating
 */

(function(){
    angular.module('notifista.services').service('EventService', ['$cookies', 'NotifistaHttp', 'ParseHttp', service]);
    function service($cookies, NotifistaHttp, ParseHttp){
        function GetEventLoggedIn(){
            return ($cookies['event-name'] != null);
        }


        //We wrap everything under a _data object so that we can perform databindings much more easily!
        //Otherwise, we will be assigning by value and things get messy quite quickly!
        var _data = {
            Event: {
                channels: []
            },
        }
        var _websocket_enabled = false;
        


        function SetEvent(event_name){
            console.log(_data);
            for (var i = 0 ; i != _data.User.events.length; ++i){
                if (_data.User.events[i].name == event_name){
                    _data.Event = _data.User.events[i];
                }
            }
            //var promise = NotifistaHttp.GetEvent(event_name);
            //promise.success(function(resp){
                //_data.Event = resp.data;
            //});
            
            //promise.error(function(err){
            //})

        }

        function SetState(email, password, event_name){
            Login(email, password, function(){SetEvent(event_name)})
        }

        function Login(email, password, callback){
            var p = NotifistaHttp.Login(email, password);
            p.success(function(e){
                _data.User = e.data;
                console.log(e);
                if (callback){
                    callback();
                }
            })
            p.error(function(e){
                console.log(e);
            })
        }

        function UpdateEvent(){
            var event = _data.Event;
            if (_websocket_enabled){ //no need to poll
                return;
            }

            if (!event){
                return;
            }
            //var promise = NotifistaHttp.GetEvent(_data.Event.id);
            //promise.success(function(e){
                //console.log(e);
            //});

            event.channels.map(function(channel){
                var promise = NotifistaHttp.GetMessages(channel.id);
                promise.success(function(e){
                    var messages = e.data;
                    channel.messages = messages.map(function(msg){
                        msg.time = moment(msg.created_at).fromNow();
                        return msg;
                    });
                });
                promise.error(function(error){
                    channel.messages = [
                    {
                        time: 'N/A',
                        message: 'Error in getting data'
                    }
                    ]
                })
            });

        }

        var promise = ParseHttp.GetData();
        promise.success(function(data){
            console.log("successfully queried parse")
            console.log(data);
        });
        promise.error(function(err){
            //error is in err
            console.log('failed to query parse');
            console.log(err);
        })


        return {
            //Used to set the event we would like to have info about
            SetState: SetState,

            //Used to get updated information about the event
            UpdateEvent: UpdateEvent,

            Login: Login,


            //for data binding purposes
            data : _data
        }
    }
})();

