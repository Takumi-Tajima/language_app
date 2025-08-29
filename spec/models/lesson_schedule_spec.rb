require 'rails_helper'

RSpec.describe LessonSchedule, type: :model do
  describe 'validate_no_overlap_lesson_schedules' do
    let(:instructor) { create(:instructor) }
    let(:lesson1) { create(:lesson, instructor:) }
    let(:lesson2) { create(:lesson, instructor:) }

    before do
      travel_to '2025-08-30'
      create(:lesson_schedule, lesson: lesson1, start_at: '2025-09-01 12:00')
    end

    context '同じレッスンですでにスケジュールされた予定がある場合' do
      it '同じ時間帯にはスケジュールを設定できない' do
        schedule = build(:lesson_schedule, lesson: lesson1, start_at: '2025-09-01 12:00')

        expect(schedule).not_to be_valid
        expect(schedule.errors[:base]).to include('他のレッスンと重複しています')
      end
    end

    context '別のレッスンですでにスケジュールされた予定がある場合' do
      it '同じ時間帯にはスケジュールを設定できない' do
        schedule = build(:lesson_schedule, lesson: lesson2, start_at: '2025-09-01 12:00')

        expect(schedule).not_to be_valid
        expect(schedule.errors[:base]).to include('他のレッスンと重複しています')
      end

      it '終了時間がすでにスケジュールされている予定と被ると設定できない' do
        schedule = build(:lesson_schedule, lesson: lesson2, start_at: '2025-09-01 11:11')

        expect(schedule).not_to be_valid
        expect(schedule.errors[:base]).to include('他のレッスンと重複しています')
      end

      it '開始時間がすでにスケジュールされている予定と被ると設定できない' do
        schedule = build(:lesson_schedule, lesson: lesson2, start_at: '2025-09-01 12:49')

        expect(schedule).not_to be_valid
        expect(schedule.errors[:base]).to include('他のレッスンと重複しています')
      end
    end

    context 'スケジュールが被ってない場合' do
      it '違う日付の同じ時間に予約できる' do
        schedule = build(:lesson_schedule, lesson: lesson2, start_at: '2025-09-02 12:00')

        expect(schedule).to be_valid
      end

      it '同じ日の違う時間に予約できる' do
        schedule1 = build(:lesson_schedule, lesson: lesson2, start_at: '2025-09-01 11:09')

        expect(schedule1).to be_valid

        schedule2 = build(:lesson_schedule, lesson: lesson2, start_at: '2025-09-01 12:51')

        expect(schedule2).to be_valid
      end
    end
  end
end
