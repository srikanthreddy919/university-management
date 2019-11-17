class Course < ApplicationRecord
  belongs_to :user
  has_many :users, through: :course_student
end
