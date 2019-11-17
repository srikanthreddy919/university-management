class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.string :title
      t.text :description
      t.text :notes
      t.time :start_time
      t.time :end_time
      t.references :user, null: false, foreign_key: true
      t.integer :class_room_id, foreign_key: true

      t.timestamps
    end
  end
end
