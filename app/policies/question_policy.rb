class QuestionPolicy < ApplicationPolicy
  def create?
    user.present?
  end
  def index?
    true
  end
  def show?
    true
  end
  def update
    user.author?(record)
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
