class CoursePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    is_owner?
  end

  def new?
    is_owner?
  end

  def edit?
    is_owner?
  end

  def destroy?
    is_owner?
  end

  private

  def is_owner?
    @user == @record.user
  end
end
