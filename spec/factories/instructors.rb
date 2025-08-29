FactoryBot.define do
  factory :instructor do
    sequence(:email) { |n| "instructor#{n}@example.com" }
    password { 'password' }
    name { 'テスト講師' }
    introduction { 'テスト用の講師です' }
    teachable_language { [:japanese] }
    confirmed_at { Time.current }
  end
end
