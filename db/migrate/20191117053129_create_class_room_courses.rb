class CreateClassRoomCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :class_room_courses do |t|
      t.references :class_room, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
