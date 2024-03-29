class Teacher::CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  before_action :verify_authorized, only: [:index, :new]
  before_action :verify_authorized_course, only: [:show, :edit, :destroy]
  before_action :set_class_rooms, only: [:new, :edit, :create, :update]
  before_action :ensure_valid_timings, only: [:create, :update]

  def index
    @courses = current_user.courses
  end

  def show
    @students = @course.users
  end

  def new
    @course = Course.new
  end

  def edit
  end

  def create
    @course = current_user.courses.new(course_params)
    if is_course_exist_with_same_time?
      p "coming here"
      flash[:error] = "Course already present in the given timings, please change timings"
      render :new
    elsif is_class_room_occupied?
      flash[:error] = "Class room already occupied by other course, please change the class room or timings"
      render :new
    else
      respond_to do |format|
        if @course.save
          format.html { redirect_to [:teacher, @course], notice: 'Course was successfully created.' }
          format.json { render :show, status: :created, location: [:teacher, @course] }
        else
          format.html { render :new }
          format.json { render json: @course.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def update
    if is_course_exist_with_same_time?
      flash[:error] = "Course already present in the given timings, please change timings"
      render :edit
    elsif is_class_room_occupied?
      flash[:error] = "Class room already occupied by other course, please change the class room or timings"
      render :edit
    else
      respond_to do |format|
        if @course.update(course_params)
          format.html { redirect_to [:teacher, @course], notice: 'Course was successfully updated.' }
          format.json { render :show, status: :ok, location: [:teacher, @course] }
        else
          format.html { render :edit }
          format.json { render json: @course.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to teacher_courses_path, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def verify_authorized_course
      authorize @course
    end

    def verify_authorized
      authorize :common, :is_teacher?
    end

    def start_time
      @start_time ||= begin 
        DateTime.new(course_params["start_time(1i)"].to_i, 
        course_params["start_time(2i)"].to_i,
        course_params["start_time(3i)"].to_i,
        course_params["start_time(4i)"].to_i,
        course_params["start_time(5i)"].to_i)
      end
    end

    def end_time
      @end_time ||= begin 
        DateTime.new(course_params["end_time(1i)"].to_i, 
        course_params["end_time(2i)"].to_i,
        course_params["end_time(3i)"].to_i,
        course_params["end_time(4i)"].to_i,
        course_params["end_time(5i)"].to_i)
      end
    end

    def is_course_exist_with_same_time?
      courses = current_user.courses.where("start_time BETWEEN ? AND ? OR end_time BETWEEN ? AND ?", start_time, end_time, start_time, end_time)
      courses = courses.where.not(id: @course.id) if @course.persisted?
      return courses.present?
    end

    def is_class_room_occupied?
      class_room = ClassRoom.find(course_params[:class_room_id])
      if class_room
        courses = class_room.courses.where("start_time BETWEEN ? AND ? OR end_time BETWEEN ? AND ?", start_time, end_time, start_time, end_time)
        courses = courses.where.not(id: @course.id) if @course.persisted?
        return courses.present?
      else
        return false
      end
    end

    def ensure_valid_timings
      if start_time > end_time
        render_type = params[:action] == "update" ? :edit : :new
        respond_to do |format|
          flash[:error] = "Please ensure course start time is before end time"
          format.html{render render_type}
        end
      end
    end

    def set_class_rooms
      @class_rooms = ClassRoom.all.pluck(:name, :id)
    end

    def set_course
      @course = Course.find(params[:id])
    end

    def course_params
      params.require(:course).permit(:title, :description, :notes, :start_time, :end_time, :class_room_id)
    end
end
