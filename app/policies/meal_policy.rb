class MealPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end

    def preferences?
      true
    end

    def show?
      true
    end
  end
end
