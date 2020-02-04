# frozen_string_literal: true

FactoryBot.define do
  factory :user1, class: User do
    name { 'test1' }
    email { 'test1@test.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end

  factory :user2, class: User do
    name { 'test2' }
    email { 'test2@test.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end

  factory :test_user, class: User do
    name { 'test2' }
    email { 'test2@test.com' }
    password { 'password' }
    password_confirmation { 'password' }
    for_test { true }
  end
end
