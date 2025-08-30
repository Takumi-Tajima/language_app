FactoryBot.define do
  factory :lesson do
    instructor { nil }
    language { :japanese }
    name { 'テストレッスン' }
    description { 'テスト用のレッスンです' }
  end
end
