class Admin::ClassRoomsController < ApplicationController
  before_action :set_class_room, only: [:show, :edit, :update, :destroy]
  before_action :verify_authorized

  def index
    @class_rooms = ClassRoom.all
  end

  def show
  end

  def new
    @class_room = ClassRoom.new
  end

  def edit
  end

  def create
    @class_room = current_user.class_rooms.new(class_room_params)

    respond_to do |format|
      if @class_room.save
        format.html { redirect_to [:admin, @class_room], notice: 'Class room was successfully created.' }
        format.json { render :show, status: :created, location: [:admin, @class_room] }
      else
        format.html { render :new }
        format.json { render json: @class_room.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @class_room.update(class_room_params)
        format.html { redirect_to [:admin, @class_room], notice: 'Class room was successfully updated.' }
        format.json { render :show, status: :ok, location: [:admin, @class_room] }
      else
        format.html { render :edit }
        format.json { render json: @class_room.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @class_room.destroy
    respond_to do |format|
      format.html { redirect_to admin_class_rooms_path, notice: 'Class room was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def verify_authorized
      authorize :common, :is_admin?
    end

    def set_class_room
      @class_room = ClassRoom.find(params[:id])
    end

    def class_room_params
      params.require(:class_room).permit(:name)
    end
end
