# API documentation

## Summary
* All API calls are made to api.notifsta.com/v1. Prefix this to all URLs below.
* All API calls return a "status" and a "data". If successful, "status" will
always be "success"; if not, always "failure". "data" contains the response.


## Authentication (/auth)
### login (/login)
* Expects email and password.
* Responds with User, including Events, and Channels.

* Request: ```api.notifsta.com/v1/auth/login/?email=admin@example.com&password=asdf```

* Response: 

        {
            "status": "success",
            "data": {
                "id": 1,
                "email": "admin@example.com",
                "admin": true,
                "locked": false,
                "created_at": "2015-03-21T07:12:54.705Z",
                "updated_at": "2015-03-21T07:12:54.705Z",
                "phone": null,
                "authentication_token": "Q6VzX_oGdybdoZGjiLqv",
                "events": [
                    {
                        "id": 1,
                        "name": "hack_london",
                        "created_at": "2015-03-21T07:12:59.771Z",
                        "updated_at": "2015-03-21T07:12:59.771Z",
                        "channels": [
                            {
                                "event_id": 1,
                                "id": 1,
                                "name": "General",
                                "created_at": "2015-03-21T07:12:59.804Z",
                                "updated_at": "2015-03-21T07:12:59.804Z"
                            },
                            {
                                "event_id": 1,
                                "id": 2,
                                "name": "Food",
                                "created_at": "2015-03-21T07:12:59.809Z",
                                "updated_at": "2015-03-21T07:12:59.809Z"
                            },
                            {
                                "event_id": 1,
                                "id": 3,
                                "name": "Logistics",
                                "created_at": "2015-03-21T07:12:59.818Z",
                                "updated_at": "2015-03-21T07:12:59.818Z"
                            }
                        ]
                    }
                ]
            }
        }



### logout (/logout)
* Expects authentication_token, and logs out.
* Please don't use, since this logs out on all sessions.

### get_authentication_token (/get_authentication_token)
* Once logged in via cookie in Rails, this returns an authentication token.

## Users (/users)

### show (/[id])
* Returns a User, along with her Events and Channels. 
* Reqest: ```api.notifsta.com/v1/users/1?user_email=admin@example.com&user_token=Q6VzX_oGdybdoZGjiLqv```
* The same response as above.

## Events (/events)

### show (/[id])
* Returns a Event, along with its Channels.
* Request: ```api.notifsta.com/v1/events/1?user_email=admin@example.com&user_token=Q6VzX_oGdybdoZGjiLqv```
* Response:

        {
            "status": "success",
            "data": {
                "id": 1,
                "name": "hack_london",
                "created_at": "2015-03-21T07:12:59.771Z",
                "updated_at": "2015-03-21T07:12:59.771Z",
                "channels": [
                    {
                        "event_id": 1,
                        "id": 1,
                        "name": "General",
                        "created_at": "2015-03-21T07:12:59.804Z",
                        "updated_at": "2015-03-21T07:12:59.804Z"
                    },
                    {
                        "event_id": 1,
                        "id": 2,
                        "name": "Food",
                        "created_at": "2015-03-21T07:12:59.809Z",
                        "updated_at": "2015-03-21T07:12:59.809Z"
                    },
                    {
                        "event_id": 1,
                        "id": 3,
                        "name": "Logistics",
                        "created_at": "2015-03-21T07:12:59.818Z",
                        "updated_at": "2015-03-21T07:12:59.818Z"
                    }
                ]
            }
        }
 
### Channels (/channels)

* Index channels for an Event.
* Request: ```api.notifsta.com/v1/events/1/channels?user_email=admin@example.com&user_token=Q6VzX_oGdybdoZGjiLqv```
* Response:

        {
            "status": "success",
            "data": [
                {
                    "event_id": 1,
                    "id": 1,
                    "name": "General",
                    "created_at": "2015-03-21T07:12:59.804Z",
                    "updated_at": "2015-03-21T07:12:59.804Z"
                },
                {
                    "event_id": 1,
                    "id": 2,
                    "name": "Food",
                    "created_at": "2015-03-21T07:12:59.809Z",
                    "updated_at": "2015-03-21T07:12:59.809Z"
                },
                {
                    "event_id": 1,
                    "id": 3,
                    "name": "Logistics",
                    "created_at": "2015-03-21T07:12:59.818Z",
                    "updated_at": "2015-03-21T07:12:59.818Z"
                }
            ]
        }

## Channels (/channels)

### show (/[id])

* Returns a Channel.
* Request: ```api.notifsta.com/v1/channels/1/?user_email=admin@example.com&user_token=Q6VzX_oGdybdoZGjiLqv```
* Response: 

        {
            "status": "success",
            "data": {
                "event_id": 1,
                "id": 1,
                "name": "General",
                "created_at": "2015-03-21T07:12:59.804Z",
                "updated_at": "2015-03-21T07:12:59.804Z"
            }
        }

### Notifications

#### Index Notifications for a Channel.

* Returns a list of Notifications.
* Request: ```api.notifsta.com/v1/channels/1/notifications/?user_email=admin@example.com&user_token=Q6VzX_oGdybdoZGjiLqv```
* Response: 

        {
            "status": "success",
            "data": [
                {
                    "id": 11,
                    "channel_id": 1,
                    "notification_guts": "What food do you want?",
                    "type": "Survey",
                    "created_at": "2015-03-21T07:20:24.009Z",
                    "options": [
                        {
                            "id": 3,
                            "option_guts": "burgerzzzz",
                            "created_at": "2015-03-21T07:20:24.020Z"
                        },
                        {
                            "id": 4,
                            "option_guts": "pizza",
                            "created_at": "2015-03-21T07:20:24.027Z"
                        }
                    ],
                    "response": {
                        "id": 6,
                        "option_id": 4,
                        "created_at": "2015-03-21T22:56:27.078Z",
                        "updated_at": "2015-03-21T22:56:27.078Z"
                    }
                },
                {
                    "id": 10,
                    "channel_id": 1,
                    "notification_guts": "Hello J!",
                    "type": "Survey",
                    "created_at": "2015-03-21T07:20:03.913Z",
                    "options": [
                        {
                            "id": 1,
                            "option_guts": "burgerzzzz",
                            "created_at": "2015-03-21T07:20:03.946Z"
                        },
                        {
                            "id": 2,
                            "option_guts": "pizza",
                            "created_at": "2015-03-21T07:20:03.954Z"
                        }
                    ],
                    "response": null
                },
                {
                    "id": 3,
                    "channel_id": 1,
                    "notification_guts": "third notification in general!",
                    "type": "Message",
                    "created_at": "2015-03-21T07:12:59.871Z"
                },
                {
                    "id": 2,
                    "channel_id": 1,
                    "notification_guts": "second notification in general!",
                    "type": "Message",
                    "created_at": "2015-03-21T07:12:59.859Z"
                },
                {
                    "id": 1,
                    "channel_id": 1,
                    "notification_guts": "first notification in general!",
                    "type": "Message",
                    "created_at": "2015-03-21T07:12:59.844Z"
                }
            ]
        }

#### Create (POST to same URL as Index)
* Requires a type, which is either "Message" or "Survey". Also requires a
"notification_guts", which is the message.
* If type is "Survey", then an "options" array is expected. This contains all
the option_guts, which describe the option (e.g. `options[]=burger&options[]=pizza`).

* Request with Message: ```api.notifsta.com/v1/channels/1/notifications/?user_email=admin@example.com&user_token=Q6VzX_oGdybdoZGjiLqv&notification[notification_guts]=Notifsta!&notification[type]=Message```
* Response: 

        {
            "status": "success",
            "data": {
                "id": 12,
                "channel_id": 1,
                "notification_guts": "Notifsta!",
                "type": "Message",
                "created_at": "2015-03-21T07:54:17.008Z"
            }
        }

* Request with Survey: ```api.notifsta.com/v1/channels/1/notifications/?user_email=admin@example.com&user_token=Q6VzX_oGdybdoZGjiLqv&notification[notification_guts]=What food?&notification[type]=Survey&options[]=burger&options[]=pizza``` 
* Response:

        {
            "status": "success",
            "data": {
                "id": 13,
                "channel_id": 1,
                "notification_guts": "What food?",
                "type": "Survey",
                "created_at": "2015-03-21T07:55:32.164Z",
                "options": [
                    {
                        "id": 5,
                        "option_guts": "burger",
                        "created_at": "2015-03-21T07:55:32.178Z"
                    },
                    {
                        "id": 6,
                        "option_guts": "pizza",
                        "created_at": "2015-03-21T07:55:32.190Z"
                    }
                ],
                "response": null
            }
        }

## Notifications (/notifications)

### show (/[id])
* Request: ```api.notifsta.com/v1/notifications/12?user_email=admin@example.com&user_token=Q6VzX_oGdybdoZGjiLqv```
* Response: 

        {
            "status": "success",
            "data": {
                "id": 12,
                "channel_id": 1,
                "notification_guts": "Notifsta!",
                "type": "Message",
                "created_at": "2015-03-21T07:54:17.008Z"
            }
        }

### Response (/responses)

#### Index (/)
* Admins of the Event can list all responses to a particular Notification.
* Request: ```api.notifsta.com/v1/notifications/11/responses?user_email=admin@example.com&user_token=Q6VzX_oGdybdoZGjiLqv```
* Response: 

        {
            "status": "success",
            "data": [
                {
                    "id": 1,
                    "option_id": 3,
                    "created_at": "2015-03-21T08:04:04.383Z",
                    "updated_at": "2015-03-21T08:04:04.383Z"
                }
            ]
        }

#### Show (/[id])
* Show an individual response.
* Can only be done if it's your response, or if you're an Event admin.
* Request: ```api.notifsta.com/v1/notifications/11/responses/1?user_email=admin@example.com&user_token=Q6VzX_oGdybdoZGjiLqv```
* Response: 

        {
            "status": "success",
            "data": {
                "id": 1,
                "option_id": 3,
                "created_at": "2015-03-21T08:04:04.383Z",
                "updated_at": "2015-03-21T08:04:04.383Z"
            }
        }

#### Create (POST to /)
* Responses can only be created by POSTing to the same URL as showing a Notification.  
* If the user has a previous response, it is overridden.
* Request: ```api.notifsta.com/v1/notifications/11/responses?user_email=admin@example.com&user_token=Q6VzX_oGdybdoZGjiLqv&option_id=3```
* Response: 

        {
            "status": "success",
            "data": {
                "id": 1,
                "option_id": 3,
                "created_at": "2015-03-21T08:04:04.383Z",
                "updated_at": "2015-03-21T08:04:04.383Z"
            }
        }
