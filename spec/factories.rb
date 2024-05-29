FactoryBot.define do
  factory :assistant, class: AI::Engine::Assistant do
    remote_id { Faker::Internet.uuid }
    name { Faker::Company.buzzword }
    model { AI::Engine::AssistantsHelper::MODEL_OPTIONS.sample }
    description { Faker::Company.catch_phrase }
    instructions { Faker::Company.bs }
  end
end
