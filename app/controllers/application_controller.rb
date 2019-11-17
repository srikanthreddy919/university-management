class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource)
    case resource.role.to_sym
      when :student then student_courses_path
      when :teacher then teacher_courses_path
      when :admin then  admin_class_rooms_path
    end
  end
  
end
