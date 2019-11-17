class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: [:student, :teacher, :admin]
  after_initialize :set_default_role, :if => :new_record?
  
  has_many :courses
  has_many :course_students
  has_many :class_rooms



  private
  
  def set_default_role
    self.role ||= :student
  end

end
