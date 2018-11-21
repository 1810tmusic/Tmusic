# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name: "admin",
  name_kana: "カンリシャ",
  postal_code: "1234567",
  address: "東京都渋谷区",
  phone_number: "0312345678",
  nickname: "admin",
  birthday: "2018-11-01",
  email: ENV['adminemail'],
  password: ENV['adminpassword'],
  password_confirmation: ENV['adminpassword'] ,
  admin: true)