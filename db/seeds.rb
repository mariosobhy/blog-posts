# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


user1 = User.create!(email: 'example@mail.com' , password: '123123123' , password_confirmation: '123123123')
user2 = User.create!(email: 'mario@gmail.com' , password: 'Ma987654321' , password_confirmation: 'Ma987654321')

post1 = Post.create!(title: 'post 1', body: 'body 1', author: user1)
post2 = Post.create!(title: 'post 2', body: 'body 2', author: user2)

comment1 = Comment.create(text: 'comment 1', commenter: user1, post: post2)
comment2 = Comment.create(text: 'comment 2', commenter: user2, post: post1)