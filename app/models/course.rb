class Course < ApplicationRecord
  belongs_to :user
  has_many :course_students
  has_many :users, through: :course_students
end
