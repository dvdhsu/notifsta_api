require 'net/http'
require 'json'

class ApiFacebookBotController < ApplicationController
  @@page_id = '745181025602763'
  @@page_access_token = 'CAAWqS5AfVUkBAPaFsBIorVmGoVlQrMf07dEm1HLytGyC8gEIyGYa1p8sJE8ZBPpLFGgCmGh9nB5UR4FIPdXWlkw73YMlsXyRZBt4R7TrxKkqf3ZCJiZC9lk6w5hXdWEsx4fp1gMZAqivrzd2i4axjHVEZAVeijO4luHqCjSsLkqDlykRNIxa82qFtVdYHXObJgFRedzQhcLAZDZD'
  @@verify_token = 'verify_token_1111'


  def get
    if params['hub.verify_token'] == @@verify_token
      render plain: params['hub.challenge']
    else
      render plain: 'Error, wrong validation token'
    end
    setWelcomeMessagesExample()
  end

  def post
    Rails.logger.info request.body.read

    messaging_events = JSON.parse(request.body.read)['entry'][0]['messaging']

    messaging_events.each do |event|
      sender = event['sender']['id']
      if event['message'] && event['message']['text']
        text = event['message']['text']
        if text == 'generic'
          sendGenericMessageExample(sender)
        else
          sendTextMessage(sender, text)
        end
      end
    end

    render plain: 'thanks'
  end

  private
    def makePostRequest(base, path, body)
      uri = URI.parse(base)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      https.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = Net::HTTP::Post.new(path)
      request.add_field('Content-Type', 'application/json')
      request.body = body.to_json
      response = https.request(request)

      Rails.logger.info response
    end

    def setWelcomeMessages(messages)
      makePostRequest(
        'https://graph.facebook.com',
        '/v2.6/' + @@page_id + '/thread_settings?access_token=' + @@page_access_token,
        {
          'setting_type' => 'call_to_actions',
          'thread_state' => 'new_thread',
          'call_to_actions' => messages
        }
      )
    end

    def sendMessage(sender, message)
      makePostRequest(
        'https://graph.facebook.com',
        '/v2.6/me/messages?access_token=' + @@page_access_token,
        {
          'recipient' => { 'id' => sender },
          'message' => message,
          'notification_type' => 'REGULAR' # 'SILENT_PUSH', 'NO_PUSH'
        }
      )
    end

    def sendTextMessage(sender, text)
      sendMessage(sender, { 'text' => text })
    end

    def sendImageMessage(sender, image_url)
      sendMessage(sender, {
        'attachment' => {
          'type' => 'image',
          'payload' => {
            'url' => image_url
          }
        }
      })
    end

    def sendGenericMessage(sender, elements)
      sendMessage(sender, {
        "attachment" => {
          "type" => "template",
          "payload" => {
            "template_type" => "generic",
            "elements" => elements
          }
        }
      })
    end

    # get user info (note user ids are app-scoped):
    # curl -X GET 'https://graph.facebook.com/v2.6/<USER_ID>?fields=first_name,last_name,profile_pic&access_token=<PAGE_ACCESS_TOKEN>'
    # result: {'first_name', 'last_name', 'profile_pic'}


    ####################################

    def setWelcomeMessagesExample()
      setWelcomeMessages([
        {
          'message' => {
            'text' => 'Welcome to Notifsta!'
          }
        }
      ])
    end

    def sendGenericMessageExample(sender)
      sendGenericMessage(sender, [
        {
          "title" => "First card",
          "subtitle" => "Element #1 of an hscroll",
          "image_url" => "http://messengerdemo.parseapp.com/img/rift.png",
          "buttons" => [{
            "type" => "web_url",
            "url" => "https://www.messenger.com/",
            "title" => "Web url"
          }, {
            "type" => "postback",
            "title" => "Postback",
            "payload" => "Payload for first element in a generic bubble",
          }],
        },
        {
          "title" => "Second card",
          "subtitle" => "Element #2 of an hscroll",
          "image_url" => "http://messengerdemo.parseapp.com/img/gearvr.png",
          "buttons" => [{
            "type" => "postback",
            "title" => "Postback",
            "payload" => "Payload for second element in a generic bubble",
          }],
        }
      ])
    end

end
