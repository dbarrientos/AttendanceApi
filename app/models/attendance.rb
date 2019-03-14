class Attendance < ApplicationRecord
  belongs_to :user
  validates_presence_of :checkin, :attendance_date
  validates_uniqueness_of :attendance_date, scope: :user_id, message: "Assistance already entered for this day"

  attr_accessor :usr, :a_date
end
