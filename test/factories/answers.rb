FactoryBot.define do
    factory :answer do
      title { 'title' }
      content { 'content' }
      user
      # Другие атрибуты, если необходимо
    end
  end