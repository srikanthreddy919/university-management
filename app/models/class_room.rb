class ClassRoom < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  belongs_to :user
  has_many :class_room_courses, dependent: :destroy
end
