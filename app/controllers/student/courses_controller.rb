class Student::CoursesController < ApplicationController
  before_action :set_course, only: [:show]

  # GET student/courses
  # GET student/courses.json
  def index
    @courses = Course.all
  end

  # GET student/courses/1
  # GET student/courses/1.json
  def show
  end


  private
    def is_course_exist_with_same_time
      start_time = DateTime.new(course_params["start_time(1i)"].to_i, 
      course_params["start_time(2i)"].to_i,
      course_params["start_time(3i)"].to_i,
      course_params["start_time(4i)"].to_i,
      course_params["start_time(5i)"].to_i)
      end_time = DateTime.new(course_params["end_time(1i)"].to_i, 
      course_params["end_time(2i)"].to_i,
      course_params["end_time(3i)"].to_i,
      course_params["end_time(4i)"].to_i,
      course_params["end_time(5i)"].to_i)
      course = Course.where("start_time BETWEEN ? AND ? OR end_time BETWEEN ? AND ?", start_time, end_time, start_time, end_time)
      return course.present?
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end
end
