class StudentPolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end

  attr_reader :context

  def initialize(user, record, context = {})
    @user = user
    @record = record
    @context = context
  end

  def index?
    is_admin? 
  end

  def show?
    is_admin?
  end

  def new?
    is_admin?
  end

  def create?
    is_admin?
  end

  def edit?
    is_admin? || is_correct_user?
  end

  def update?
    is_admin? || is_correct_user?
  end

  def destroy?
    is_admin?
  end

  def destroy_all?
    is_admin?
  end

end