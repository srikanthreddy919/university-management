class CommonPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def is_student?
    @user.student?
  end

  def is_teacher?
    @user.teacher?
  end

  def is_admin?
    @user.admin?
  end
  
end
