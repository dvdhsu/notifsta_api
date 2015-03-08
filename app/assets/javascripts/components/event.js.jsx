var Message = React.createClass({
  render: function() {
    return(
      <div className="message">
      <p>{this.props.message_guts}</p>
      <p>{moment(this.props.message_time).fromNow()}</p>
      </div>
    )
  }
});

var ChannelBar = React.createClass({
  render: function() {
    return(
      <div className="channelBar">
      <h2>#{this.props.channel_name}</h2>
      </div>
    )
  }
});

var Channel = React.createClass({
  loadDataFromServer: function() {
    $.ajax({
      url: this.props.domain + "/api/v1/channels/" + this.props.channel_id + "/messages" + this.props.login,
      dataType: 'json',
      success: function(res) {
        var messages = res.data.map(function(message) {
          return [message.message_guts, message.created_at]
        });
        this.setState({messages: messages.reverse() });
      }.bind(this),
      error: function(xhr, status, err) {
        console.log("error loading messages");
      }.bind(this)
    });
  },
  getInitialState: function() {
    return {
      messages: []
    };
  },
  componentDidMount: function() {
    this.loadDataFromServer();
    setInterval(this.loadDataFromServer, this.props.poll_interval);
  },
  render: function() {
    var messageNodes = this.state.messages.map(function (message) {
      return (
        <Message message_guts={message[0]} message_time={message[1]} />
      );
    });
    return(
      <div className="channel col-md-4">
      <ChannelBar channel_name={this.props.channel_name} />
      { messageNodes }
      </div>
    );
  }
});

var Event = React.createClass({
  loadDataFromServer: function() {
    $.ajax({
      url: this.props.domain + "/api/v1/events/" + this.props.event_id + "/" + this.props.login,
      dataType: 'json',
      success: function(res) {
        var channel_ids_and_names = res.data.channels.map(function(channel) {
          return [channel.id, channel.name];
        });
        this.setState({channels: channel_ids_and_names });
      }.bind(this),
      error: function(xhr, status, err) {
        console.error("load error in event");
      }.bind(this)
    });
  },
  getInitialState: function() {
    return {
      channels: []
    };
  },
  componentDidMount: function() {
    this.loadDataFromServer();
    setInterval(this.loadDataFromServer, this.props.poll_interval);
  },
  render: function() {
    var self = this;
    var channelNodes = this.state.channels.map(function (channel) {
      return (
        <Channel channel_id={channel[0]} channel_name={channel[1]}
         poll_interval={10000} domain={self.props.domain} 
         login={self.props.login} />
      );
    });
    return(
      <div className="event">
      <h1>{this.props.event_name}</h1>
      {channelNodes}
      </div>
    )
  }
});
