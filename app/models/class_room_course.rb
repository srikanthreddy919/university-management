class ClassRoomCourse < ApplicationRecord
  belongs_to :class_room
  belongs_to :course
end
