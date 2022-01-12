class UserPolicy < ApplicationPolicy
  include SessionsHelper

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    @user.has_role? :admin
  end

  def edit?; end

  def update?; end

  def show?; end
end
