class Course < ApplicationRecord
  belongs_to :user
  has_many :course_students
  has_many :users, through: :course_students
  belongs_to :class_room
  validates :class_room_id, presence: true
end
