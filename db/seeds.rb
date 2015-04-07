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

e = Event.new(name: "hack_london", cover_photo_url: "https://hacklondon.org/images/london2.jpg",
              address: "Strand Campus, King's College London, WC2R 2LS, London",
              start_time: DateTime.current.advance(months: -3), 
              end_time: DateTime.current.advance(months: -3, days: 1))


e.save!

notifications = e.channels.create!(name: "Notifications")

notifications.notifications.create!(type: "Message", notification_guts: "First notification!")

survey = notifications.notifications.create!(type: "Survey", notification_guts: "What food?")

survey.options.create!(option_guts: "Burgers")
survey.options.create!(option_guts: "Pizza")
survey.options.create!(option_guts: "Cauliflowers")
survey.options.create!(option_guts: "Carrots")
survey.options.create!(option_guts: "Swiss cheese")

# subscribe users, and respond to survey
# first user is admin
for u in User.all
 u.subscriptions.create!(event_id: 1)
 Response.create!(user_id: u.id, option_id: (u.id % 5) + 1)
end

admin_sub = Subscription.where(user_id: 1).first
admin_sub.admin = true
admin_sub.save!
