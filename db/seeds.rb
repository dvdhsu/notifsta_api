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

gen_channel.messages.create!(message_guts: "first message in general!")
gen_channel.messages.create!(message_guts: "second message in general!")
gen_channel.messages.create!(message_guts: "third message in general!")

food_channel.messages.create!(message_guts: "first message in food!")
food_channel.messages.create!(message_guts: "second message in food!")
food_channel.messages.create!(message_guts: "third message in food!")

logistics_channel.messages.create!(message_guts: "first message in logistics!")
logistics_channel.messages.create!(message_guts: "second message in logistics!")
logistics_channel.messages.create!(message_guts: "third message in logistics!")
