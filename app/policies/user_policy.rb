class UserPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    @user.has_role? :admin
  end

  def edit? 
  end
  
  def update?
    @user.has_role? :moderator
  end

  def show?; end

  def create?
    @user.has_any_role? :admin, :teacher
  end
end
