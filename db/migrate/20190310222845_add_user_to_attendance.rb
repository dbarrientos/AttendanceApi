class AddUserToAttendance < ActiveRecord::Migration[5.1]
  def change
    add_reference :attendances, :user, foreign_key: true
  end
end
