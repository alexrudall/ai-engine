FactoryBot.define do
  factory :message do
    chat { create(:chat) }
    role { 1 }
    content { "Hi" }
  end

  factory :storyteller do
    name { Faker::Company.buzzword }
    model { AI::Engine::Assistant::MODEL_OPTIONS.sample }
    instructions { Faker::Company.bs }
  end

  factory :chat, class: AI::Engine::Chat do
    remote_id { Faker::Internet.uuid }
    chattable { create(:user) }
  end

  factory :user do
    avatar_url { Faker::Avatar.image }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end
