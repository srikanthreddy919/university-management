module CoursesHelper

  def is_applied_to_course(course_id)
    return current_user.joined_courses.where(id: course_id).present?
  end
end
