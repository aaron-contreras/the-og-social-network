# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.delete_all
Post.delete_all
user = User.create!(name: 'Aaron Contreras',
             email: 'example@example.com',
             password: 'foobar',
             password_confirmation: 'foobar')
post = user.posts.build(content: 'My first post')
post.save
