class Teacher::CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = current_user.courses.new(course_params)
    if is_course_exist_with_same_time
      flash[:error] = "Course already present the given timings, please change timings"
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

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    if is_course_exist_with_same_time
      flash[:error] = "Course already present in tthe given timings, please change timings"
      render :edit
    else
      respond_to do |format|
        format.html { render :edit, error: "Course already present the given timings, please change timings" }
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

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to teacher_courses_path, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:title, :description, :notes, :start_time, :end_time)
    end
end
