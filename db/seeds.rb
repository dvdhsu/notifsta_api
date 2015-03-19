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

e = Event.new(name: "hack_london")
e.save!

gen_channel = e.channels.new(name: "General")
food_channel = e.channels.new(name: "Food")
logistics_channel = e.channels.new(name: "Logistics")

gen_channel.save!
food_channel.save!
logistics_channel.save!

gen_channel.notifications.create!(type: "Message", notification_guts: "first notification in general!")
gen_channel.notifications.create!(type: "Message", notification_guts: "second notification in general!")
gen_channel.notifications.create!(type: "Message", notification_guts: "third notification in general!")

food_channel.notifications.create!(type: "Message", notification_guts: "first notification in food!")
food_channel.notifications.create!(type: "Message", notification_guts: "second notification in food!")
food_channel.notifications.create!(type: "Message", notification_guts: "third notification in food!")

logistics_channel.notifications.create!(type: "Message", notification_guts: "first notification in logistics!")
logistics_channel.notifications.create!(type: "Message", notification_guts: "second notification in logistics!")
logistics_channel.notifications.create!(type: "Message", notification_guts: "third notification in logistics!")
