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

# Test user accounts
(1..50).each do |i|
  u = User.new(
      email: "user#{i}@example.com",
      password: "1234",
      password_confirmation: "1234"
  )
  u.skip_confirmation!
  u.save!

  puts "#{i} test users created..." if (i % 5 == 0)
end

hack_london_start_time = DateTime.new(2015, 5, 15, 10, 0 , 0, "+1:00")
oxford_inspires_start_time = DateTime.new(2015, 5, 18, 10, 0, 0, "+1:00")
hughsball_start_time = DateTime.new(2015, 5, 9, 20, 0, 0, "+1:00")

e1 = Event.create!(name: "hack_london", cover_photo_url: "http://cdn.notifsta.com/images/india.jpg",
              address: "Strand Campus, King's College London",
              start_time: hack_london_start_time,
              end_time: hack_london_start_time.advance(days: 1),
              description: "Hack London is the largest U.K. hackathon. We hope you enjoy your time here.",
              facebook_url: "https://www.fb.com/hacklondonuk",
              website_url: "http://hacklondon.org")

e2 = Event.create!(name: "Oxford Inspires", cover_photo_url: "http://cdn.notifsta.com/images/walking.jpg",
              address: "Said Business School, Oxford, UK",
              start_time: oxford_inspires_start_time,
              end_time: oxford_inspires_start_time.advance(hours: 36),
              description: "Oxford Inspires hopes to inspire you. Let us know how we can help.",
              facebook_url: "https://www.fb.com/oxinspires",
              website_url: "http://oxfordinspires.com")

e3 = Event.create!(name: "St. Hugh's Ball, 2015", cover_photo_url: "https://sthughsball.com/notifsta_background.jpeg",
              address: "St. Hugh's College, Oxford, UK",
              start_time: hughsball_start_time,
              end_time: hughsball_start_time.advance(hours: 14),
              description: "St. Hugh's is delighted to invite you to our Ball.",
              facebook_url: "https://www.fb.com/sthughsball2015",
              website_url: "http://sthughsball.com")

events = [e1, e2, e3]

for event in events
  start_time = event.start_time
  end_time = event.end_time

  if event.id == 3
    event.subevents.create!(name: "Garfunkel", start_time: start_time.advance(minutes: 15),
                            end_time: start_time.advance(hours: 2, minutes: 15), location: "The Enchanted Court")

    event.subevents.create!(name: "Oxford Univeristy Jazz Orchestra", start_time: start_time.advance(minutes: 45),
                          end_time: start_time.advance(hours: 2, minutes: 45), location: "Main Stage (The Glade)")

    event.subevents.create!(name: "Fireworks", start_time: start_time.advance(hours: 2),
                          end_time: start_time.advance(hours: 2, minutes: 30), location: "Main Lawn")

    event.subevents.create!(name: "Billie Black", start_time: start_time.advance(hours: 2, minutes: 15),
                          end_time: start_time.advance(hours: 2, minutes: 45), location: "The Enchanted Court")

    event.subevents.create!(name: "Jamie Berry", start_time: start_time.advance(hours: 2, minutes: 15),
                            end_time: start_time.advance(hours: 3), location: "Main Stage (The Glade)")

    event.subevents.create!(name: "Switch", start_time: start_time.advance(hours: 2, minutes: 15),
                            end_time: start_time.advance(hours: 4, minutes: 15), location: "DJ Stage (The Meadows)")

    event.subevents.create!(name: "K Stewart", start_time: start_time.advance(hours: 3, minutes: 15),
                            end_time: start_time.advance(hours: 4, minutes: 45), location: "The Enchanted Court")

    event.subevents.create!(name: "Dot's Funk Odyssey", start_time: start_time.advance(hours: 3, minutes: 30),
                            end_time: start_time.advance(hours: 4, minutes: 30), location: "Main Stage (The Glade)")

    event.subevents.create!(name: "Karma Kid", start_time: start_time.advance(hours: 4, minutes: 15),
                            end_time: start_time.advance(hours: 5, minutes: 15), location: "DJ Stage (The Meadows)")

    event.subevents.create!(name: "Amber Run", start_time: start_time.advance(hours: 4, minutes: 15),
                            end_time: start_time.advance(hours: 5, minutes: 15), location: "The Enchanted Court")

    event.subevents.create!(name: "The Correspondents", start_time: start_time.advance(hours: 5),
                            end_time: start_time.advance(hours: 6), location: "Main Stage (The Glade)")

    event.subevents.create!(name: "Silent Disco", start_time: start_time.advance(hours: 6, minutes: 15),
                            end_time: start_time.advance(hours: 8), location: "Main Stage (The Glade)")
  else
    event.subevents.create!(name: "Welcome event for sponsors", start_time: start_time,
                            end_time: start_time.advance(minutes: 20), location: "Boardroom", description: "To welcome everybody.")
    event.subevents.create!(name: "Welcome event for administrators", start_time: start_time,
                            end_time: start_time.advance(minutes: 20), location: "Gherkin quad", description: "To welcome everybody.")

    event.subevents.create!(name: "Roger Thiel", start_time: end_time.advance(hours: -1),
                            end_time: end_time.advance(minutes: -30), location: "Lecture Theater 1", description: "To goodbye everybody.")
    event.subevents.create!(name: "Mark Ramsey", start_time: end_time.advance(hours: -1),
                            end_time: end_time.advance(minutes: -30), location: "Lecture Theater 2", description: "To goodbye everybody.")
    event.subevents.create!(name: "Marak Mourash", start_time: end_time.advance(hours: -1), end_time: end_time.advance(minutes: -30),
                            location: "Lecture Theater 3", description: "To goodbye everybody.")

    event.subevents.create!(name: "Goodbye event", start_time: end_time.advance(minutes: -20), end_time: end_time,
                            location: "Main quad", description: "To goodbye everybody.")
    event.subevents.create!(name: "Goodbye event for sponsors", start_time: end_time.advance(minutes: -20), end_time: end_time,
                            location: "Boardroom", description: "To goodbye everybody.")
    event.subevents.create!(name: "Goodbye event for administrators", start_time: end_time.advance(minutes: -20), end_time: end_time,
                            location: "Gherkin quad", description: "To goodbye everybody.")
  end

  notifications = event.channels.create!(name: "Notifications")

  if event.id == 1
    notifications.notifications.create!(type: "Message", notification_guts: "Welcome!")
    notifications.notifications.create!(type: "Message", notification_guts: "Food now available in the main quad.")
    notifications.notifications.create!(type: "Message", notification_guts: "Get ready for breakfast!")
    notifications.notifications.create!(type: "Message", notification_guts: "Breakfast now being served in the Gherkin quad!")
    notifications.notifications.create!(type: "Message", notification_guts: "Roger Thiel is about to speak in Lecture Theater 1!")
  elsif event.id == 2
    notifications.notifications.create!(type: "Message", notification_guts: "Welcome!")
    notifications.notifications.create!(type: "Message", notification_guts: "Mark Ramsey is about to speak about finance in Lecture Theater 2!")
    notifications.notifications.create!(type: "Message", notification_guts: "Lunch is now being served in the Main Hall.")
    notifications.notifications.create!(type: "Message", notification_guts: "Marak Mourash is about to speak about democracies in Lecture Theater 2!")
  else
    notifications.notifications.create!(type: "Message", notification_guts: "Welcome to the St. Hugh's Ball, 2015.")
    notifications.notifications.create!(type: "Message", notification_guts: "Garfunkel will be starting in The Enchanted Court.")
    notifications.notifications.create!(type: "Message", notification_guts: "Oxford University Jazz Orchestra will be starting on the Main Stage.")
    notifications.notifications.create!(type: "Message", notification_guts: "Fireworks on the Main Lawn now.")
    notifications.notifications.create!(type: "Message", notification_guts: "Switch on the DJ Stage, Billie Black in The Enchanted Court, and Jamie Berry on the Main Stage. All in 5 minutes.")
    notifications.notifications.create!(type: "Message", notification_guts: "Get ready for the Silent Disco on the Main Stage in 5 minutes!")
    notifications.notifications.create!(type: "Message", notification_guts: "Still around? We've got breakfast at 6.")
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
