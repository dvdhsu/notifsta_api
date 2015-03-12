var Message = React.createClass({
  render() {
    return(
      <div className="message">
        <p>{this.props.guts}</p>
        <p>{moment(this.props.time).fromNow()}</p>
      </div>
    )
  }
});

var Channel = React.createClass({
  render() {
    var message_nodes = this.props.channel_data.messages.map(
      m => <Message guts={m.message_guts} time={m.created_at}/>
    )
    return (
      <div className="messages">
        <div className="channelHeader">
          <h2> {this.props.channel_data.name} </h2>
        </div>
        {message_nodes}
      </div>
    )
  }
});

var Event = React.createClass({
  getInitialState() {
    data = this.props.initial_channel_data
    return {
      channels_data: this.props.initial_channel_data
    };
  },
  componentDidMount() {
    // connect to websocket for notifications after initial
    var dispatcher = new WebSocketRails(this.props.websocket_url);
    channel = dispatcher.subscribe('messages_' + this.props.event_name);

    if ("Notification" in window) {
      // if notifications are avail, immediately request
      Notification.requestPermission()
    }

    channel.bind('new', function(m) {
      // set state somewhere here from the message
      // look up channel first
      state = this.state.channels_data;
      state["_" + m.channel_id].messages.unshift(m.message);
      console.log("received one");
      this.setState({channels_data: state});
      if ("Notification" in window) {
        var opts = {
          icon: 'http://notifsta.com/icon.png'
        }
        var notification = new Notification(m.message.message_guts, opts);
      }
    }.bind(this));
  },
  render() {
    // unfortunately there's no map :: Object -> Array, so for loop instead
    console.log(this.state.channels_data["_" + "1"]);
    var channel_nodes = [];
    for (var key in this.state.channels_data) {
      channel_nodes.push(<Channel channel_data={this.state.channels_data[key]} />)
    }
    return(
      <div className="event">
        <h1>{this.props.event_name}</h1>
        {channel_nodes}
      </div>
    )
  }
});
