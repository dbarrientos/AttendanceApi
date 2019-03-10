class CreateAttendances < ActiveRecord::Migration[5.1]
  def change
    create_table :attendances do |t|
      t.datetime :checkin
      t.datetime :checkout

      t.timestamps
    end
  end
end
