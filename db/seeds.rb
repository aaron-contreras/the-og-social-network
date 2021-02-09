# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.delete_all

test_user = User.create!(name: 'Example',
             email: 'example@example.com',
             password: 'foobar',
             password_confirmation: 'foobar')
post = test_user.posts.build(content: Faker::Movies::HitchhikersGuideToTheGalaxy.quote)
post.save!

10.times do
  password = Faker::Alphanumeric.alpha(number: 7)

  User.create!(name: Faker::Name.unique.name,
               email: Faker::Internet.email,
               password: password,
               password_confirmation: password)
end

User.all.each do |user|
  post = user.posts.build(content: Faker::Movies::HitchhikersGuideToTheGalaxy.quote)
  post.save!
end

Post.all.each do |post|
  User.all.each do |user|
    like = Like.new(user: user, post: post)
    like.save!
  end
end


