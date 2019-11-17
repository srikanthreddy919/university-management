class Student::CoursesController < ApplicationController
  before_action :set_course, only: [:show, :apply]
  before_action :verify_authorized, only: [:index, :show]

  def index
    @courses = Course.all
  end

  def show
  end

  def apply
    if is_course_exist_with_same_time
      redirect_to student_courses_path, alert: "You have already joined to another course with in the same time"
    else
      current_user.course_students.create(course_id: @course.id)
      redirect_to student_courses_path, notice: "Applied successfully"
    end
  end


  private

    def verify_authorized
      authorize :common, :is_student?
    end

    def is_course_exist_with_same_time
      start_time = @course.start_time
      end_time = @course.end_time
      course = current_user.joined_courses.where("start_time BETWEEN ? AND ? OR end_time BETWEEN ? AND ?", start_time, end_time, start_time, end_time)
      return course.present?
    end

    def set_course
      @course = Course.find(params[:id])
    end
end
