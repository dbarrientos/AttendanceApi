FactoryBot.define do
  factory :attendance do
    checkin { Time.now.beginning_of_day }
    attendance_date { Date.today }
    user
  end
end