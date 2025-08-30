FactoryBot.define do
  factory :lesson_schedule do
    lesson { nil }
    start_at { Time.current }
    meeting_url { 'https://example.com' }
    is_booked { false }
  end
end
