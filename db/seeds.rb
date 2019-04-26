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

# 画像投稿機能確認用
10.times do |n|
  picture = open("db/fixtures/img#{n+1}.jpeg")
  title = "picture-title-#{n+1}"
  User.first.photos.create!(picture: picture, title: title)
end

10.times do |n|
  picture = open("db/fixtures/img#{n+11}.jpeg")
  title = "picture-title-#{n+1}"
  User.second.photos.create!(picture: picture, title: title)
end


users = User.order(created_at: "DESC").take(5)
4.times do |n|
  picture = open("db/fixtures/img#{n+20}.jpeg")
  title = "picture-title-#{n+20}"
  users.each { |user| user.photos.create!(picture: picture, title: title) }
end


#users = User.order(:created_at).take(5)
#50.times do |n|
#  picture = Faker::Games::Pokemon.name
#  title = "#{picture}title-#{n+1}"
#  users.each { |user| user.photos.create!(picture: picture,
#                                          title: title) }
#end
