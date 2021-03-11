class MealPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

    def preferences?
      true
    end

    def show?
       true
    end

    def index?
      true
    end

    def create?
      true
    end

    def update?
      user.admin?
    end

    def edit?
      update?
    end
end
