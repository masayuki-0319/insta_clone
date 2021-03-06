# ユーザー登録
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

#picture = MiniMagick::Image.read(open(URI.encode("db/fixtures/img#{n+20}.jpeg"), &:read))
# 写真投稿機能
10.times do |n|
  picture = MiniMagick::Image.open("db/fixtures/img#{n+1}.jpeg")
  title = "picture-title-#{n+1}"
  User.first.photos.create!(picture: picture, title: title)
end

10.times do |n|
  picture = MiniMagick::Image.open("db/fixtures/img#{n+11}.jpeg")
  title = "picture-title-#{n+11}"
  User.second.photos.create!(picture: picture, title: title)
end

users = User.order(created_at: "DESC").take(5)
4.times do |n|
  picture = MiniMagick::Image.open("db/fixtures/img#{n+20}.jpeg")
  title = "picture-title-#{n+20}"
  users.each { |user| user.photos.create!(picture: picture, title: title) }
end

# フォロー機能
users = User.all
following = users[3..50]
followers = users[3..40]
2.times do |n|
  following.each { |followed| User.find(n+1).follow(followed) }
  followers.each { |follower| follower.follow(User.find(n+1)) }
end

# 写真いいね！機能
photos = Photo.all[5..14]
5.times do |n|
  photos.each { |photo| User.find(n+10).like(photo) }
end
