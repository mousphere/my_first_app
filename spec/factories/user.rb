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

  factory :user_for_validation_check, class: User do
    name { 'a' * 50 }
    email { 'a' * 246 + '@test.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end

  factory :test_user, class: User do
    name { 'test_user' }
    email { 'test_user@test.com' }
    password { 'password' }
    password_confirmation { 'password' }
    for_test { true }
  end
end
