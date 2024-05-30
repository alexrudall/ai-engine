FactoryBot.define do
  factory :message do
    chat { create(:chat) }
    role { 1 }
    content { "Hi" }
  end

  factory :assistant do
    remote_id { Faker::Internet.uuid }
    name { Faker::Company.buzzword }
    model { AssistantsHelper::MODEL_OPTIONS.sample }
    description { Faker::Company.catch_phrase }
    instructions { Faker::Company.bs }
  end

  factory :chat do
    remote_id { Faker::Internet.uuid }
    assistable { create(:assistant) }
  end

  factory :pipeline do
    name { Faker::Company.catch_phrase }
  end

  factory :user do
    avatar_url { Faker::Avatar.image }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end
