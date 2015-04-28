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

now = DateTime.current

e1 = Event.create!(name: "hack_london", cover_photo_url: "http://www.get-covers.com/wp-content/uploads/2012/02/Wooden.jpg",
              address: "Strand Campus, King's College London",
              start_time: now.advance(months: 3), 
              end_time: now.advance(months: 3, hours: 24),
              description: "Hack London is the largest U.K. hackathon. We hope you enjoy your time here.
              HHack hack hack hack hack.Hack hack hack hack hack.Hack hack hack hack hack.Hack hack hack hack hack.Hack hack hack hack hack.Hack hack hack hack hack.Hack hack hack hack hack.Hack hack hack hack hack.Hack hack hack hack hack.Hack hack hack hack hack.Hack hack hack hack hack.Hack hack hack hack hack.Hack hack hack hack hack.Hack hack hack hack hack.Hack hack hack hack hack.Hack hack hack hack hack.Hack hack hack hack hack.ack hack hack hack hack. ",
              facebook_url: "https://www.fb.com/hacklondonuk",
              website_url: "http://hacklondon.org")

e2 = Event.create!(name: "Oxford Inspires", cover_photo_url: "http://www.f-covers.com/cover/colorful-hearts-facebook-cover-timeline-banner-for-fb.jpg",
              address: "Said Business School, Oxford, UK",
              start_time: now.advance(months: -2), 
              end_time: now.advance(months: -2, hours: 3),
              description: "Oxford Inspires hopes to inspire you. Let us know how we can help.",
              facebook_url: "https://www.fb.com/hacklondonuk",
              website_url: "http://oxfordinspires.org")

e3 = Event.create!(name: "St. Hugh's Ball, 2015", cover_photo_url: "https://sthughsball.com/notifsta_background.jpeg",
              event_map_url: "http://cdn.notifsta.com/event_maps/hughs.jpg",
              address: "St. Hugh's College, Oxford, UK",
              start_time: now.advance(months: 1), 
              end_time: now.advance(months: 1, hours: 8),
              description: "St. Hugh's is delighted to invite you to our Ball.",
              facebook_url: "https://www.fb.com/hacklondonuk",
              website_url: "http://sthughsball.com")

events = [e1, e2, e3]

for event in events
  event.subevents.create!(name: "Welcome event", start_time: DateTime.now, 
                          end_time: DateTime.now.advance(minutes: 20), location: "Main quad", description: "To welcome everybody.")
  event.subevents.create!(name: "Goodbye event", start_time: DateTime.now.advance(hours: 10), 
                          end_time: DateTime.now.advance(hours: 10, minutes: 20), location: "Main quad", 
                          description: "To goodbye everybody.")
  notifications = event.channels.create!(name: "Notifications")

  notifications.notifications.create!(type: "Message", notification_guts: "Welcome!")
  notifications.notifications.create!(type: "Message", notification_guts: "Food now available in the main quad.")
  notifications.notifications.create!(type: "Message", notification_guts: "Get ready for breakfast!")

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
  u.subscriptions.create!(event_id: 1, admin: true)
  u.subscriptions.create!(event_id: 2, admin: true)
  u.subscriptions.create!(event_id: 3, admin: true)
  #Response.create!(user_id: u.id, option_id: (u.id % 5) + 1)
end
