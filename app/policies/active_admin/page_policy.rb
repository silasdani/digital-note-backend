# frozen_string_literal: true

module ActiveAdmin
  class PagePolicy < ApplicationPolicy
    def show?
      case record.name
      when 'Dashboard'
      when 'Setting'
      end
      is_admin?
    end

    def edit?
      show?
    end

    def update?
      show?
    end
  end
end
