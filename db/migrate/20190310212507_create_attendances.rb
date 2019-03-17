class CreateAttendances < ActiveRecord::Migration[5.1]
  def change
    create_table :attendances do |t|
      t.time :checkin
      t.time :checkout

      t.timestamps
    end
  end
end
