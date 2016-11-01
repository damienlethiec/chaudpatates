class TrainingPolicy < ApplicationPolicy

	def index?
		user.is_coach
	end

  def new?
    user.is_coach
  end

  def create?
    record.city.coach == user
  end

  def update?
    record.city.coach == user
  end

	def destroy?
    record.city.coach == user
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
