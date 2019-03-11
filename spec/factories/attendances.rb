FactoryBot.define do
  factory :attendance do
    checkin { DateTime.now.beginning_of_day }
    user
  end
end