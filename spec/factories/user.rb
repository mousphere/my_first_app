FactoryBot.define do
  factory :valid_user, class: User do
    name { 'testuser1' }
    email { 'test@test.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end
  
  factory :invalid_user, class: User do
    name { '' }
    email { 'test@test.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end