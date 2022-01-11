class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    @use.has_role? :admin
  end

  def edit?
  end

  def update?
  end
  
end
