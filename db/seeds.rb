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

food_channel.notifications.create!(type: "Message", notification_guts: "first notification in food!")
survey = food_channel.notifications.create!(type: "Survey", notification_guts: "What food?")

survey.options.create!(option_guts: "Burgers")
survey.options.create!(option_guts: "Pizza")

logistics_channel.notifications.create!(type: "Message", notification_guts: "first notification in logistics!")

# subscribe users, and respond to survey
# first user is admin
for u in User.all
 u.subscriptions.create!(event_id: 1)
 Response.create!(user_id: u.id, option_id: (u.id % 2) + 1)
end

admin_sub = Subscription.where(user_id: 1).first
admin_sub.admin = true
admin_sub.save!













