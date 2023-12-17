FactoryBot.define do
    factory :user do
      email { 'test@example.com' }
      name { 'testuser' }
      password { 'password' }
      # Другие атрибуты, если необходимо
    end
  end