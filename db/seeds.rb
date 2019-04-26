User.create!(user_name: "Example User",
             pen_name:  "example user",
             email: "example@example.com",
             password:              "foobar",
             password_confirmation: "foobar",
             confirmed_at: Time.zone.now)

99.times do |n|
  user_name = Faker::Name.name
  pen_name = "#{user_name}-#{n+1}"
  email = "example-#{n+1}@example.com"
  password = "password"
  User.create!(user_name: user_name,
               pen_name: pen_name,
               email: email,
               password:              password,
               password_confirmation: password,
               confirmed_at: Time.zone.now)
end

users = User.order(:created_at).take(6)
50.times do |n|
  picture = Faker::Games::Pokemon.name
  title = "#{picture}title-#{n+1}"
  users.each { |user| user.photos.create!(picture: picture,
                                          title: title) }
end
