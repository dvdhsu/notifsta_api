# Generated with RailsBricks
# Initial seed file to use with Devise User Model

# Temporary admin account
u = User.new(
    email: "admin@example.com",
    password: "asdf",
    password_confirmation: "asdf",
    admin: true
)
u.skip_confirmation!
u.save!

# account for Apple Review
u = User.new(
    email: "apple@apple.com",
    password: "asdf",
    password_confirmation: "asdf",
    admin: false
)
u.skip_confirmation!
u.save!

hack_london_start_time = DateTime.new(2015, 5, 15, 10, 0 , 0, "+1:00")
orielball_start_time = DateTime.new(2015, 5, 18, 10, 0, 0, "+1:00")
hughsball_start_time = DateTime.new(2015, 5, 9, 20, 0, 0, "+1:00")

e1 = Event.create!(name: "St. Hugh's Ball, 2015", cover_photo_url: "https://sthughsball.com/notifsta_background.jpeg",
              address: "St. Hugh's College, Oxford",
              start_time: hughsball_start_time,
              end_time: hughsball_start_time.advance(hours: 8, minutes: 30),
              description: "St. Hugh's is delighted to invite you to our Ball.",
              facebook_url: "https://www.fb.com/sthughsball2015",
              website_url: "http://sthughsball.com",
              event_map_url: "http://cdn.notifsta.com/event_maps/hughs.jpg")

e2 = Event.create!(name: "Hack London", cover_photo_url: "http://cdn.notifsta.com/images/walking.jpg",
              address: "Strand Campus, King's College London",
              start_time: hack_london_start_time,
              end_time: hack_london_start_time.advance(days: 1),
              description: "Hack London is the largest U.K. hackathon. With over 24 hours of hacking, we're sure you'll make something great.",
              facebook_url: "https://www.fb.com/hacklondonuk",
              website_url: "http://hacklondon.org")

e3 = Event.create!(name: "Oriel Ball, 2015", cover_photo_url: "https://notifsta.s3.amazonaws.com/bg.jpg",
              address: "Oriel College, Oxford",
              start_time: orielball_start_time,
              end_time: orielball_start_time.advance(days: 1),
              description: "Oriel Ball 2015 is excited you to welcome you to the Gardens of Babylon.",
              facebook_url: "https://www.facebook.com/orielball",
              website_url: "https://orielball.uk")

events = [e1, e2, e3]

for event in events
  start_time = event.start_time

  if event.id == 1
    event.subevents.create!(name: "Garfunkel", start_time: start_time.advance(minutes: 15),
                            end_time: start_time.advance(hours: 1, minutes: 15), location: "The Enchanted Court")

    event.subevents.create!(name: "Oxford Univeristy Jazz Orchestra", start_time: start_time.advance(minutes: 45),
                          end_time: start_time.advance(hours: 1, minutes: 45), location: "Main Stage (The Glade)")

    event.subevents.create!(name: "Fireworks", start_time: start_time.advance(hours: 2),
                          end_time: start_time.advance(hours: 2, minutes: 15), location: "Main Lawn")

    event.subevents.create!(name: "Billie Black", start_time: start_time.advance(hours: 2, minutes: 15),
                          end_time: start_time.advance(hours: 3), location: "The Enchanted Court")

    event.subevents.create!(name: "Jamie Berry", start_time: start_time.advance(hours: 2, minutes: 15),
                            end_time: start_time.advance(hours: 3, minutes: 15), location: "Main Stage (The Glade)")

    event.subevents.create!(name: "Switch", start_time: start_time.advance(hours: 2, minutes: 15),
                            end_time: start_time.advance(hours: 4, minutes: 15), location: "DJ Stage (The Meadows)")

    event.subevents.create!(name: "K Stewart", start_time: start_time.advance(hours: 3, minutes: 15),
                            end_time: start_time.advance(hours: 3, minutes: 45), location: "The Enchanted Court")

    event.subevents.create!(name: "Dot's Funk Odyssey", start_time: start_time.advance(hours: 3, minutes: 30),
                            end_time: start_time.advance(hours: 4, minutes: 30), location: "Main Stage (The Glade)")

    event.subevents.create!(name: "Karma Kid", start_time: start_time.advance(hours: 4, minutes: 15),
                            end_time: start_time.advance(hours: 5, minutes: 15), location: "DJ Stage (The Meadows)")

    event.subevents.create!(name: "Amber Run", start_time: start_time.advance(hours: 4, minutes: 15),
                            end_time: start_time.advance(hours: 5, minutes: 15), location: "The Enchanted Court")

    event.subevents.create!(name: "The Correspondents", start_time: start_time.advance(hours: 5, minutes: 15),
                            end_time: start_time.advance(hours: 6), location: "Main Stage (The Glade)")

    event.subevents.create!(name: "Silent Disco", start_time: start_time.advance(hours: 6, minutes: 15),
                            end_time: start_time.advance(hours: 8), location: "Main Stage (The Glade)")
  end

  notifications = event.channels.create!(name: "Notifications")

  if event.id == 2
    notifications.notifications.create!(type: "Message", notification_guts: "Welcome to Hack London!")
  elsif event.id == 3
    notifications.notifications.create!(type: "Message", notification_guts: "Welcome to the Oriel Commemmoration Ball, 2015. We'll be sending out more notifications closer to the Ball.")
  else
    notifications.notifications.create!(type: "Message", notification_guts: "Welcome to the St. Hugh's Ball, 2015.")
  end

=begin
  survey = notifications.notifications.create!(type: "Survey", notification_guts: "What food?")

  survey.options.create!(option_guts: "Burgers")
  survey.options.create!(option_guts: "Pizza")
  survey.options.create!(option_guts: "Cauliflowers")
  survey.options.create!(option_guts: "Carrots")
  survey.options.create!(option_guts: "Swiss cheese")
=end
end

# subscribe users, and respond to survey
# first user is admin
for u in User.all
  u.subscriptions.create!(event_id: 1, admin: false)
  u.subscriptions.create!(event_id: 2, admin: false)
  u.subscriptions.create!(event_id: 3, admin: false)
  #Response.create!(user_id: u.id, option_id: (u.id % 5) + 1)
end
