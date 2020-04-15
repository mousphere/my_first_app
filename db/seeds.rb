# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(name: 'テストユーザー',
            email: 'test@test.com',
            password_digest: User.digest('password'),
            image: File.open('./app/assets/images/animal_penguin.png'),
            order_option: 0,
            for_test: true)
