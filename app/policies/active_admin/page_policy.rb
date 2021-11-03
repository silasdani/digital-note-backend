module ActiveAdmin
    class PagePolicy < ApplicationPolicy
  
      def show?
        case record.name
          when "Dashboard"
            is_admin?
          when "Setting"
            is_admin?
          else
            is_admin?
        end
      end
  
      def edit?
        show?
      end
  
      def update?
        show?
      end
  
    end
  end