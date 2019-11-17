class Student::CoursesController < ApplicationController
  before_action :set_course, only: [:show, :apply]

  # GET student/courses
  # GET student/courses.json
  def index
    @courses = Course.all
  end

  # GET student/courses/1
  # GET student/courses/1.json
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
    def is_course_exist_with_same_time
      start_time = @course.start_time
      end_time = @course.end_time
      course = current_user.joined_courses.where("start_time BETWEEN ? AND ? OR end_time BETWEEN ? AND ?", start_time, end_time, start_time, end_time)
      return course.present?
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end
end
